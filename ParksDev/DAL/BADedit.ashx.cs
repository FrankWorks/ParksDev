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
    /// Summary description for BADedit
    /// </summary>
    public class BADedit : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;

            string whatToDo = forms.Get("oper");

            string badbas = forms.Get("BAS").ToString();
            string badfee = forms.Get("FEE").ToString();
            string badaverage = forms.Get("AVERAGE").ToString();
            string badabacode = forms.Get("ABA_CODE").ToString();

            if (whatToDo == "edit")
            {

                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

                SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();

                string sqlcommand = "UPDATE [FOXPRODEV].[dbo].[AGENBENEFITS] SET BAS = @bas, FEE = @fee, AVERAGE = @average WHERE ABA_CODE = @abacode";
                SqlCommand command = new SqlCommand(sqlcommand, conn);

                command.Parameters.Add("@bas", SqlDbType.Float).Value = badbas;
                command.Parameters.Add("@fee", SqlDbType.Float).Value = badfee;
                command.Parameters.Add("@average", SqlDbType.Float).Value = badaverage;
                command.Parameters.Add("@abacode", SqlDbType.Float).Value = badabacode;

                command.ExecuteNonQuery();
                conn.Close();

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