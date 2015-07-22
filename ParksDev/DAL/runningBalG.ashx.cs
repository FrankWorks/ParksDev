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
    /// Summary description for runningBalG
    /// to populate grid according to agency code
    /// </summary>
    public class runningBalG : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string InComingText = context.Request.QueryString["ACODE"];

            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand("SELECT a.[fy] as FY, a.[AMT_BEG] as AMT_BEG, b.ENDBAL as ENDBAL, a.YEG_BEG as YEG_BEG, a.FEE_BEG as FEEBAL FROM [FOXPRODEV].[dbo].[AGENBALANCFY] a left outer join [FOXPRODEV].[dbo].[AGE_ENDBAL] b on a.fy = b.fy where a.[AGE_CODE] = " + InComingText + " and b.[AGE_CODE] = " + InComingText + " order by fy", conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objList = new List<faObject>();
            List<faObject> list = new List<faObject>();
            foreach (DataRow dr in dt.Rows)
            {
                faObject fa = new faObject();

                fa.YEAR   = dr["FY"].ToString();
                fa.BEGBAL = dr["AMT_BEG"].ToString();
                fa.ENDBAL = dr["ENDBAL"].ToString();
                fa.YEGBAL = dr["YEG_BEG"].ToString();
                fa.FEEBAL = dr["FEEBAL"].ToString();

                list.Add(fa);
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

    public class faObject
    {
        public string YEAR      { get; set; }
        public string BEGBAL    { get; set; }
        public string ENDBAL    { get; set; }
        public string YEGBAL    { get; set; }
        public string FEEBAL    { get; set; }

    }
}