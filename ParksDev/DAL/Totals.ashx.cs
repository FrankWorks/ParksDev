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
    /// Summary description for Totals
    /// </summary>
    public class Totals : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[TOT_BEGBAL] LEFT OUTER JOIN [FOXPRODEV].[dbo].[TOT_ENDBAL] ON [FOXPRODEV].[dbo].[TOT_BEGBAL].[FYA] =  [FOXPRODEV].[dbo].[TOT_ENDBAL].[FY] ORDER BY [FOXPRODEV].[dbo].[TOT_BEGBAL].[FY]", conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objList = new List<TotalBal>();
            List<TotalBal> list = new List<TotalBal>();
            foreach (DataRow dr in dt.Rows)
            { //for each "datarow" in datatable "dt" assinged the value to "dr" for each instance of loop
                TotalBal tol = new TotalBal();
                tol.YEAR = dr["FY"].ToString();
                tol.BEGBAL = dr["BEG_BAL"].ToString();
                tol.ENDBAL = dr["ENDBAL"].ToString();
                tol.YEGBAL = dr["YEG_BAL"].ToString();
                tol.FEEBAL = dr["FEEBAL"].ToString();
                tol.FY = dr["FYA"].ToString();

                list.Add(tol);
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


        public class TotalBal
        {
            public string YEAR   { get; set; }
            public string BEGBAL { get; set; }
            public string ENDBAL { get; set; }
            public string YEGBAL { get; set; }
            public string FEEBAL { get; set; }
            public string FY     { get; set; }

        }
    }