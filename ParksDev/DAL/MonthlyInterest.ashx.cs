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
    /// Summary description for MonthlyInterest
    /// </summary>
    public class MonthlyInterest : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand("select * from [FOXPRODEV].[dbo].[INTEREST] order by [YEAR] desc, [MONTH] desc", conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objList = new List<MonthInterest>();
            List<MonthInterest> list = new List<MonthInterest>();
            foreach (DataRow dr in dt.Rows)
            { //for each "datarow" in datatable "dt" assinged the value to "dr" for each instance of loop
                MonthInterest mi = new MonthInterest();
                mi.ENTERED = dr["ENTERED"].ToString();
                mi.YEAR = dr["YEAR"].ToString();
                mi.MONTH = dr["MONTH"].ToString();
                mi.MONTH_NAME = dr["MONTH"].ToString();
                mi.INT = dr["INT"].ToString();
                mi.COMMENTS = dr["COMMENTS"].ToString();
                list.Add(mi);
            }

            objList = list;
            context.Response.Write(new JavaScriptSerializer().Serialize(objList));
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

    // Month Interest Object 
    public class MonthInterest
    {
        public string ENTERED { get; set; }
        public string YEAR { get; set; }
        public string MONTH { get; set; }
        public string MONTH_NAME { get; set; }
        public string INT { get; set; }
        public string COMMENTS { get; set; }
    }
}