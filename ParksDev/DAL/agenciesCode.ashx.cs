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

namespace ParksDev.DAL
{
    /// <summary>
    /// Summary description for agenciesCode
    /// </summary>
    public class agenciesCode : IHttpHandler
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

                SqlCommand delcom = new SqlCommand("DELETE FROM FOXPRODEV.dbo.AGENCIES WHERE AGE_CODE = @agecode", delconn);
                delcom.Parameters.Add("@agecode", SqlDbType.Float).Value = rmv;

                delcom.ExecuteNonQuery();

                delcom.Dispose();
                delconn.Close();
            }
            else { 
            string kagecode = forms.Get("AGE_CODE").ToString(); //was listed first actually last in other file
            string kagency = forms.Get("AGENCY").ToString();
            string kname = forms.Get("NAME").ToString();
            string katpcode = forms.Get("ATP_CODE").ToString();
            string kdiscode = forms.Get("DIS_CODE").ToString();
            string kadr1 = forms.Get("ADR1").ToString();
            string kadr2 = forms.Get("ADR2").ToString();
            string kcity = forms.Get("CITY").ToString();
            string kzip = forms.Get("ZIP").ToString();
            string kamtdev = forms.Get("AMTDEV").ToString();
            string kamtmtc = forms.Get("AMTMTC").ToString();
            string kamtyeg = forms.Get("AMTYEG").ToString();

            if (whatToDo == "edit") {
                try
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

                    SqlConnection conn = new SqlConnection(connectionString);
                    conn.Open();
                    string sqlcommand = "UPDATE FOXPRODEV.dbo.AGENCIES SET AGENCY = @agency, NAME = @name, ATP_CODE=@atpcode, DIS_CODE = @discode, ADR1 = @adr1, ADR2=@adr2, CITY=@city , ZIP = @zip, AMTDEV = @amtdev, AMTMTC = @amtmtc, AMTYEG = @AMTYEG where AGE_CODE = @agecode";

                    SqlCommand command = new SqlCommand(sqlcommand, conn);

                    command.Parameters.Add("@agency", SqlDbType.NVarChar).Value = kagency;
                    command.Parameters.Add("@name", SqlDbType.NVarChar).Value = kname;
                    command.Parameters.Add("@atpcode", SqlDbType.Float).Value = katpcode;
                    command.Parameters.Add("@discode", SqlDbType.Float).Value = kdiscode;
                    command.Parameters.Add("@adr1", SqlDbType.NVarChar).Value = kadr1;
                    command.Parameters.Add("@adr2", SqlDbType.NVarChar).Value = kadr2;
                    command.Parameters.Add("@city", SqlDbType.NVarChar).Value = kcity;
                    command.Parameters.Add("@zip", SqlDbType.NVarChar).Value = kzip;
                    command.Parameters.Add("@amtdev", SqlDbType.Float).Value = kamtdev;
                    command.Parameters.Add("@amtmtc", SqlDbType.Float).Value = kamtmtc;
                    command.Parameters.Add("@amtyeg", SqlDbType.Float).Value = kamtyeg;
                    command.Parameters.Add("@agecode", SqlDbType.Float).Value = kagecode;

                    command.ExecuteNonQuery();
                    conn.Close();
                }
                catch (SqlException ex)
                {
                    context.Response.Write(ex);
                }
            }
            else if (whatToDo == "add")
            {
                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
                SqlConnection addconn = new SqlConnection(connectionString);
                addconn.Open();

                SqlCommand addcommand = new SqlCommand("FoxProAgencyAdd", addconn);
                addcommand.CommandType = CommandType.StoredProcedure;

                addcommand.Parameters.Add("@AGENCY", SqlDbType.VarChar).Value = kagency;
                addcommand.Parameters.Add("@NAME", SqlDbType.VarChar).Value = kname;
                addcommand.Parameters.Add("@ATP_CODE", SqlDbType.Int).Value = katpcode;
                addcommand.Parameters.Add("@DIS_CODE", SqlDbType.Int).Value = kdiscode;
                addcommand.Parameters.Add("@ADR1", SqlDbType.VarChar).Value = kadr1;
                addcommand.Parameters.Add("@ADR2", SqlDbType.VarChar).Value = kadr2;
                addcommand.Parameters.Add("@CITY", SqlDbType.VarChar).Value = kcity;
                addcommand.Parameters.Add("@ZIP", SqlDbType.VarChar).Value = kzip;
                addcommand.Parameters.Add("@AMTMTC", SqlDbType.Float).Value = kamtmtc;
                addcommand.Parameters.Add("@AMTDEV", SqlDbType.Float).Value = kamtdev;
                addcommand.Parameters.Add("@AMTYEG", SqlDbType.Float).Value = kamtyeg;
                addcommand.Parameters.Add("@LUPD_USER", SqlDbType.VarChar).Value = "test"; //fix later

                addcommand.ExecuteNonQuery();
                addcommand.Dispose();
                addconn.Close();
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