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
    /// Summary description for getTest
    /// </summary>
    public class getTest : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand("select * from [FOXPRODEV].[dbo].[TestTable]", conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objList = new List<Testing>();
            List<Testing> list = new List<Testing>();
            foreach (DataRow dr in dt.Rows)
            { //for each "datarow" in datatable "dt" assinged the value to "dr" for each instance of loop
                Testing mi = new Testing();
                mi.ID = dr["ID"].ToString();
                mi.FIRSTNAME = dr["FIRSTNAME"].ToString();
                mi.LASTNAME = dr["LASTNAME"].ToString();
                mi.SCOREA = dr["SCOREA"].ToString();
                mi.SCOREB = dr["SCOREB"].ToString();
                mi.SCOREC = dr["SCOREC"].ToString();

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
    public class Testing
    {
        public string ID { get; set; }
        public string FIRSTNAME { get; set; }
        public string LASTNAME { get; set; }
        public string SCOREA { get; set; }
        public string SCOREB { get; set; }
        public string SCOREC { get; set; }

    }
}