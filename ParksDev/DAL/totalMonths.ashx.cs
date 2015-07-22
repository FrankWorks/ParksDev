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
    /// Summary description for totalMonths
    /// </summary>
    public class totalMonths : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string fy = context.Request.QueryString["fy"];

            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand("SELECT a.[MONTH] ,a.[YEAR], a.[FY] ,a.[BEG_SUM] ,b.[END_BAL] ,a.[DEBT] ,a.[INTR] FROM [FOXPRODEV].[dbo].[TOTMONTHSUM] a join [FOXPRODEV].[dbo].[TOTMONENDBAL_B] b on a.MONTH = b.MONTH and a.FY = b.FY where a.fy=" + fy , conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objList = new List<MONTHSUM>();
            List<MONTHSUM> list = new List<MONTHSUM>();
            foreach (DataRow dr in dt.Rows)
            { //for each "datarow" in datatable "dt" assinged the value to "dr" for each instance of loop
                MONTHSUM MS = new MONTHSUM();
                MS.MONTH = dr["MONTH"].ToString();
                MS.FY = dr["FY"].ToString();
                MS.BEG_SUM = dr["BEG_SUM"].ToString();
                MS.END_BAL = dr["END_BAL"].ToString();
                MS.DEBT = dr["DEBT"].ToString();
                MS.INTR = dr["INTR"].ToString();
                MS.YEAR = dr["YEAR"].ToString();


                list.Add(MS);
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
    public class MONTHSUM {
        public string MONTH { get; set; }
        public string FY { get; set; }
        public string YEAR {get;set;}
        public string BEG_SUM { get; set; }
        public string END_BAL { get; set; }
        public string DEBT { get; set; }
        public string INTR { get; set; }
    }


}