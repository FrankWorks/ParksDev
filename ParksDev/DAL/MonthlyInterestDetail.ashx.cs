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
    /// Summary description for MonthlyInterestDetail
    /// </summary>
    public class MonthlyInterestDetail : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string month = context.Request.QueryString["month"];
            string year = context.Request.QueryString["year"];

            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand("SELECT  [FOXPRODEV].[dbo].[AGENCIES].[AGENCY] as AGENCY,[FOXPRODEV].[dbo].[AGENBALANMONTH].[AMT_BEG] as AMT_BEG, [FOXPRODEV].[dbo].[AGENBALANMONTH].[AMT_INT] as AMT_INT FROM [FOXPRODEV].[dbo].[AGENBALANMONTH] JOIN [FOXPRODEV].[dbo].[AGENCIES] on [FOXPRODEV].[dbo].[AGENBALANMONTH].AGE_CODE = [FOXPRODEV].[dbo].[AGENCIES].[AGE_CODE] where [FOXPRODEV].[dbo].[AGENBALANMONTH].[MONTH] = " + month + " and [FOXPRODEV].[dbo].[AGENBALANMONTH].[YEAR] = " + year + " order by [FOXPRODEV].[dbo].[AGENCIES].[AGENCY]", conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objList = new List<MonthInterestDetail>();
            List<MonthInterestDetail> list = new List<MonthInterestDetail>();
            foreach (DataRow dr in dt.Rows)
            { //for each "datarow" in datatable "dt" assinged the value to "dr" for each instance of loop
                MonthInterestDetail mi = new MonthInterestDetail();
                mi.AGENCY = dr["AGENCY"].ToString();
                mi.AMT_BEG = dr["AMT_BEG"].ToString();
                mi.AMT_INT = dr["AMT_INT"].ToString();

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
    
    public class MonthInterestDetail
    {
        public string AGENCY { get; set; }
        public string AMT_BEG { get; set; }
        public string AMT_INT { get; set; }
    }
}