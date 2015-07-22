using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Globalization;


namespace ParksDev.reports
{
    public partial class ReportsCalcAnnualRestricedAmount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

            SqlConnection CARAConnection = new SqlConnection(connectionString);

            CARAConnection.Open();

            SqlCommand CARACommand = new SqlCommand("select * from [FOXPRODEV].[dbo].[GETcaraAGENCY] order by [AGE_CODE],[AGENCY]", CARAConnection);

            SqlDataReader CARAReader = CARACommand.ExecuteReader();

            CARAReader.Read();
           

                AGENCYrepeater.DataSource = CARAReader;
                AGENCYrepeater.DataBind();

                
            CARAConnection.Close();
        }
        private DataTable AgencyData(int AGECODEs)
        {
            string AgencyString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection AgencyConn = new SqlConnection(AgencyString);
            AgencyConn.Open();
            string AgencySQL = "SELECT * FROM [FOXPRODEV].[dbo].[R_CARA_TABLE] WHERE AGE_CODE=" + AGECODEs;
            SqlCommand AgencyComm = new SqlCommand(AgencySQL, AgencyConn);
            SqlDataAdapter da = new SqlDataAdapter(AgencyComm);
            DataTable dt = new DataTable();
            da.Fill(dt);
            AgencyConn.Close();
            return dt;
        }
        protected void AgencyRepeatBound(object sender, RepeaterItemEventArgs e)//called by first repeater
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) //not sure here but you need it. esp the alternating
            {
                System.Data.Common.DbDataRecord dvr = (System.Data.Common.DbDataRecord)e.Item.DataItem;//dvr that item dataitem
                int AGECODEs = Convert.ToInt32(dvr["AGE_CODE"]); //give agecodes the value of the item that's age_code
                Repeater therest = (Repeater)e.Item.FindControl("therest"); //the rest is the second repeater and is now the control for hte first repeater?
                therest.DataSource = AgencyData(AGECODEs);//sends AGECODEs to the agencydata method to retrive the corresponding data.
                therest.DataBind();//dat databind

            }
        }
        protected double getRRate(double a, double b, double c, double d)
        {
            int pre1 = (int)a - (int)b;
         

            if (pre1 <= 0)
            {
                double results = 0;
              
                return results;
            }
            else
            { 
            double resultsA = (a - b) / (c - d);
            double results = 100 * (Math.Round(resultsA, 6));
            return results;
            }
        }
        protected string getARAmount(double a, double b)
        {
            double resultsd = (a/100) * b;
            decimal resultsDEC = Convert.ToDecimal(resultsd);
            string results = resultsDEC.ToString("c");
            return results;
        }
       
    }
}