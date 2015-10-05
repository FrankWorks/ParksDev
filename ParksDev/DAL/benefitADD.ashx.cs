using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace ParksDev.DAL
{
    /// <summary>
    /// Summary description for benefitADD
    /// </summary>
    public class benefitADD : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;

            string whatToDo = forms.Get("oper");

            if (whatToDo == "del")
            {
                string rmv = forms.Get("delcode").ToString();

                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
                SqlConnection delconn = new SqlConnection(connectionString);
                delconn.Open();

                SqlCommand delcom = new SqlCommand("DELETE FROM FOXPRODEV.dbo.BENEFITS WHERE BAS_CODE = @basercode", delconn);
                delcom.Parameters.Add("@basercode", SqlDbType.Float).Value = rmv;

                delcom.ExecuteNonQuery();

                SqlCommand delagenben = new SqlCommand("DELETE FROM [FOXPRODEV].[dbo].[AGENBENEFITS] WHERE BAS_CODE = @basercodes", delconn);
                delagenben.Parameters.Add("@basercodes", SqlDbType.Float).Value = rmv;

                delagenben.ExecuteNonQuery();

                delcom.Dispose();
                delconn.Close();

            }//end of delete
            else{
                 
                string bbascode = forms.Get("BASCODE").ToString(); 
                string bentered = forms.Get("ENTERED").ToString(); 
                string bprocessed = forms.Get("PROCESSED").ToString(); 
                string btc = forms.Get("TC").ToString(); 
                string btd = forms.Get("TD").ToString(); 
                string breference = forms.Get("REFERENCE").ToString(); 
                string bbas = forms.Get("BAS").ToString(); 
                string bfee = forms.Get("FEE").ToString(); 
                string baverage = forms.Get("AVERAGE").ToString(); 
                string bcomments = forms.Get("COMMENTS").ToString(); 
                    

                if (whatToDo == "edit"){
                
                        string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

                    SqlConnection conn = new SqlConnection(connectionString);
                    conn.Open();

                    string sqlcommand = "UPDATE FOXPRODEV.dbo.BENEFITS SET ENTERED = @entered, PROCESSED = @processed, TC = @tc, TD = @td, REFERENCE = @reference, BAS = @bas, COMMENTS = @comments WHERE BAS_CODE= @bascode";

                    SqlCommand command = new SqlCommand(sqlcommand, conn);

                    command.Parameters.Add("@bascode", SqlDbType.Float).Value = bbascode;
                    command.Parameters.Add("@entered", SqlDbType.DateTime).Value= DateTime.Parse(bentered);
                    command.Parameters.Add("@processed", SqlDbType.DateTime).Value = DateTime.Parse(bprocessed);
                    command.Parameters.Add("@tc", SqlDbType.NVarChar).Value = btc;
                    command.Parameters.Add("@td", SqlDbType.NVarChar).Value = btd;
                    command.Parameters.Add("@reference", SqlDbType.NVarChar).Value = breference;
                    command.Parameters.Add("@bas",SqlDbType.Float).Value=bbas;
                    command.Parameters.Add("@comments", SqlDbType.NVarChar).Value = bcomments;

                    command.ExecuteNonQuery();
                    conn.Close();
                }
                else if(whatToDo == "add")
                {
                    string lpdUserName = HttpContext.Current.User.Identity.Name.ToString();
                    string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
                    SqlConnection addconn = new SqlConnection(connectionString);
                    addconn.Open();

                    SqlCommand addcommand = new SqlCommand("addbenefits", addconn);
                    addcommand.CommandType = CommandType.StoredProcedure;


                    //do agenbenefits stuff

                    addcommand.Parameters.Add("@entered", SqlDbType.DateTime).Value=DateTime.Parse(bentered);
                    addcommand.Parameters.Add("@processed", SqlDbType.DateTime).Value = DateTime.Parse(bprocessed);
                    addcommand.Parameters.Add("@tc", SqlDbType.NVarChar).Value= btc;
                    addcommand.Parameters.Add("@td", SqlDbType.NVarChar).Value=btd;
                    addcommand.Parameters.Add("@reference", SqlDbType.NVarChar).Value=breference;
                    addcommand.Parameters.Add("@bas",  SqlDbType.Float).Value=bbas;
                    
                    // Below line is just wild guess, previously there is clear business logic
                    // ( incoming amount - fee ) * ( days in this month - today's day + 1 ) /  days in this month
                    //addcommand.Parameters.Add("@average", SqlDbType.Float).Value= 0 ;
                    // by Frank Kim 9/21/15
                    DateTime dtProcessed = DateTime.Parse(bprocessed);

                    int daysInMonth = System.DateTime.DaysInMonth(dtProcessed.Year, dtProcessed.Month);
                    int processeddayInMonth = dtProcessed.Day;
                    int daysInAverageCalculation = daysInMonth - processeddayInMonth + 1;
                    if( string.IsNullOrEmpty(bfee) )
                    {
                        addcommand.Parameters.Add("@fee", SqlDbType.Float).Value = 0.00;
                        bfee = "0";

                    }
                    else
                    {
                        addcommand.Parameters.Add("@fee", SqlDbType.Float).Value = bfee;
                    }

                    
                    float AverageDailyBalence = daysInAverageCalculation * (float.Parse(bbas) - float.Parse(bfee)) / daysInMonth;
                    addcommand.Parameters.Add("@average", SqlDbType.Float).Value = AverageDailyBalence;

                    // by Frank Kim 9/21/15

                    // Need to implement to distribute logic Fees ,and Average for AgencyBenefit Balance, and AgebalFy, AgeBalMo...

                    addcommand.Parameters.Add("@comments", SqlDbType.NVarChar).Value= bcomments;
                    addcommand.Parameters.Add("@lupd_user", SqlDbType.NVarChar).Value = lpdUserName;

                    addcommand.ExecuteNonQuery();
                    //addconn.Close(); not yet but is the end of adding to benefits
                    
                    //now to distribute
                    //get bas_code and bas of last entry

                    //SqlCommand getbascommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[BENEFITS] WHERE [ENTERED] in (select max([ENTERED]) from [FOXPRODEV].[dbo].[BENEFITS])", addconn);

                    SqlCommand getbascommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[BENEFITS] WHERE [BAS_CODE] in (select max([bas_code]) from [FOXPRODEV].[dbo].[BENEFITS])", addconn);

                    SqlDataAdapter getbasda = new SqlDataAdapter(getbascommand);
                    DataTable BAS_table = new DataTable();
                    getbasda.Fill(BAS_table); //poplulate the DataTable 

                    //getting bas_code and BAS amount
                    float latest_bas = float.Parse(BAS_table.Rows[0]["BAS"].ToString());
                    float latest_bas_code = float.Parse(BAS_table.Rows[0]["BAS_CODE"].ToString());

                    //Get age_codes to cycle through
                    SqlCommand getAGECODEcom = new SqlCommand("SELECT [AGE_CODE] FROM [FOXPRODEV].[dbo].[AGENCIES]", addconn);

                    SqlDataReader agecodereader = getAGECODEcom.ExecuteReader();
                    SqlConnection adderconn = new SqlConnection(connectionString);
                    adderconn.Open();

                    while (agecodereader.Read())
                    {
                        

                        float ACcycler = float.Parse(agecodereader["AGE_CODE"].ToString());
                        //get pct_bas 
                        SqlCommand getpct = new SqlCommand("SELECT [PCT_BAS] FROM [FOXPRODEV].[dbo].[AGENCCALCS] WHERE ([AGE_CODE] = @agePCTcode and [CTP_CODE] = 2) or ([AGE_CODE] = @agePCTcode and [CTP_CODE] = 7)", adderconn); //might have to change ctpcode later
                        getpct.Parameters.AddWithValue("agePCTcode", ACcycler.ToString()); //sets the agecode so it can grab the correct pct

                        SqlDataAdapter PCTadapter = new SqlDataAdapter(getpct); //sqladapter
                        DataTable PCTtable = new DataTable(); //datatable
                        PCTadapter.Fill(PCTtable); //fill datatable with data from dataadapter

                        float rightNOWpct = float.Parse(PCTtable.Rows[0]["PCT_BAS"].ToString()); //get the PCT_BAS value
                        //System.Diagnostics.Debug.WriteLine("We Will test Age_CODE: {0} and PCT_BAS: {1}", ACcycler, rightNOWpct );
                        
                        SqlCommand AGENBENcommand = new SqlCommand("addAgenBen", adderconn);
                        AGENBENcommand.CommandType = CommandType.StoredProcedure;

                        //float bas_amount = latest_bas * rightNOWpct; //the bas for this paticular agency

                        // Round Up to the nearest .XX 
                        // 08/04/2015 
                        // Frank Kim
                        float bas_amount = (float)Math.Round(latest_bas * rightNOWpct, 2,MidpointRounding.AwayFromZero); //the bas for this paticular agency
                        //System.Diagnostics.Debug.WriteLine("We Will test Age_CODE: {0}            and BAS_Amount:         {1}", ACcycler, bas_amount);

                        AGENBENcommand.Parameters.Add("@bascode", SqlDbType.Float).Value = latest_bas_code;
                        AGENBENcommand.Parameters.Add("@age_code", SqlDbType.Float).Value = ACcycler;
                        AGENBENcommand.Parameters.Add("@bas", SqlDbType.Float).Value = bas_amount;
                        AGENBENcommand.Parameters.Add("@fee", SqlDbType.Float).Value = 0;
                        AGENBENcommand.Parameters.Add("@average", SqlDbType.Float).Value = 0; //for now i guess
                        AGENBENcommand.Parameters.Add("@lupd_user", SqlDbType.NVarChar).Value = lpdUserName;
                        AGENBENcommand.Parameters.Add("@processed", SqlDbType.DateTime).Value = DateTime.Parse(bprocessed);

                        AGENBENcommand.ExecuteNonQuery();
                        AGENBENcommand.Dispose();
                        PCTadapter.Dispose();
                        PCTtable.Dispose();
                        getpct.Dispose();
                     
                    }
                    //
                    // Here is 2nd Part of Rebalence Benefit Redisribtuion
                    //
                    SqlConnection Reconn = new SqlConnection(connectionString);
                    Reconn.Open();
                    SqlCommand ReDistributecommand = new SqlCommand("uspRedestributeBenefitAmount", Reconn);
                    ReDistributecommand.Parameters.Add("@bas_code", SqlDbType.Int).Value = latest_bas_code;
                    ReDistributecommand.CommandType = CommandType.StoredProcedure;
                    ReDistributecommand.ExecuteNonQuery();
                    Reconn.Close();
                }
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}