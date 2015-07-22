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
    /// Summary description for RunBalMonth
    /// </summary>
    public class RunBalMonth : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string code = context.Request.QueryString["code"];
            string year = context.Request.QueryString["year"];

            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand("SELECT a.[AGE_CODE],a.[MONTH],a.[YEAR] ,a.[AMT_BEG],b.[ENDBAL] ,a.[AMT_TRA],a.[FEE_PAY] FROM [FOXPRODEV].[dbo].[AGENBALANMONTH] a inner join [FOXPRODEV].[dbo].[MON_ENDBAL] b on a.month = b.month and a.AGE_CODE = b.AGE_CODE and a.year=b.year where a.age_code = " + code + " and a.fy = " + year, conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objList = new List<MonthBalDetail>();
            List<MonthBalDetail> list = new List<MonthBalDetail>();
            foreach (DataRow dr in dt.Rows)
            { //for each "datarow" in datatable "dt" assinged the value to "dr" for each instance of loop
                MonthBalDetail mi = new MonthBalDetail();
                mi.MONTH = dr["MONTH"].ToString();
                mi.YEAR = dr["YEAR"].ToString();
                mi.AMT_BEG = dr["AMT_BEG"].ToString();
                mi.ENDBAL = dr["ENDBAL"].ToString();
                mi.AMT_TRA = dr["AMT_TRA"].ToString();
                mi.FEE_PAY = dr["FEE_PAY"].ToString();

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

    public class MonthBalDetail
    {
        public string MONTH { get; set; }
        public string YEAR { get; set; }
        public string AMT_BEG { get; set; }
        public string ENDBAL { get; set; }
        public string AMT_TRA { get; set; }
        public string FEE_PAY { get; set; }
    }
}