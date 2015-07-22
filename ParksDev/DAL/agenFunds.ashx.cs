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
    /// Summary description for agenFunds
    /// </summary>
    public class agenFunds : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;

            string whatToDo = forms.Get("oper");

        
            string kfundtype = forms.Get("FUND_TYPE").ToString();
            string kfundamt = forms.Get("FUND_AMT").ToString();
            string kagecode = forms.Get("AGE_CODE").ToString();
            string kcomments = forms.Get("COMMENTS").ToString();
            //string agecodek = context.Request.QueryString["agecode"];

            if (whatToDo == "edit")
            {
                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

                SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();

                string editstring = "UPDATE [FOXPRODEV].[dbo].[AGENFUNDS] SET AMT = @amt WHERE AGE_CODE=@agecode and FTP_CODE = @ftpcode";

                SqlCommand editcommand = new SqlCommand(editstring, conn);

                editcommand.Parameters.Add("@amt", SqlDbType.Float).Value = kfundamt;
                editcommand.Parameters.Add("@agecode", SqlDbType.Float).Value = kagecode;
                editcommand.Parameters.Add("@ftpcode", SqlDbType.Float).Value = kfundtype;
               

                editcommand.ExecuteNonQuery();
                conn.Close();
                editcommand.Dispose();

            }
            else if (whatToDo == "add")
            {
                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
                SqlConnection addconn = new SqlConnection(connectionString);
                addconn.Open();

                SqlCommand addcommand = new SqlCommand("addAgenFunds", addconn);
                addcommand.CommandType = CommandType.StoredProcedure;

                addcommand.Parameters.Add("@AGE_CODE", SqlDbType.Float).Value = kagecode; //need to use same @ for stored
                addcommand.Parameters.Add("@FTP_CODE", SqlDbType.Float).Value = kfundtype;
                addcommand.Parameters.Add("@AMT", SqlDbType.Float).Value = kfundamt;
                addcommand.Parameters.Add("@COMMENTS", SqlDbType.NVarChar).Value = kcomments;
                addcommand.Parameters.Add("@LUPD_USER", SqlDbType.VarChar).Value = "test";

                addcommand.ExecuteNonQuery();
                addconn.Close();
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