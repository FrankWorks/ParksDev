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
    /// Summary description for monthIadd
    /// </summary>
    public class monthIadd : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;

            string whatToDo = forms.Get("oper");
            string ientered = forms.Get("ENTERED").ToString();
            string iint = forms.Get("INT").ToString();
            string imonth = forms.Get("MONTH").ToString();
            string iyear = forms.Get("YEAR").ToString();
            string icomments=forms.Get("COMMENTS").ToString();

            if (whatToDo == "edit")
            {
                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

                SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();

                string editstring = "UPDATE [FOXPRODEV].[dbo].[INTEREST] SET ENTERED = @entered, INT = @int, COMMENTS = @comments where YEAR=@year and MONTH = @month";

                SqlCommand editcommand = new SqlCommand(editstring, conn);

                editcommand.Parameters.Add("@entered", SqlDbType.DateTime).Value = DateTime.Parse(ientered.ToString());
                editcommand.Parameters.Add("@int", SqlDbType.Float).Value = iint;
                editcommand.Parameters.Add("@comments,", SqlDbType.NVarChar).Value = icomments.ToString();
                editcommand.Parameters.Add("@year", SqlDbType.Float).Value = iyear;
                editcommand.Parameters.Add("@month", SqlDbType.Float).Value = imonth;




                //editcommand.ExecuteNonQuery();
                conn.Close();
                editcommand.Dispose();

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