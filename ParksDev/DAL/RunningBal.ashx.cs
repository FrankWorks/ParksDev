using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

namespace ParksDev.DAL
{
    /// <summary>
    /// Summary description for RunningBal
    /// </summary>
    public class RunningBal : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string prefixCode = context.Request.QueryString["ager_code"];

            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand("SELECT * FROM [FoxProDev].[dbo].[AGENBALANCFY] where [AGE_CODE] = " + prefixCode + " order by [FY] asc", conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

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