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
    /// Summary description for BenefitsAssessmentDistribution
    /// </summary>
    public class BenefitsAssessmentDistribution : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand("Select * from  BENEFITS order by [ENTERED] DESC", conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objlist = new List<BenefitAS>();                 //objlist is new object of the List of benefitAS class
            List<BenefitAS> list = new List<BenefitAS>();        // list is new oject of a LIST<BenefitAS> collection?
            foreach (DataRow dr in dt.Rows)
            {
                BenefitAS ba = new BenefitAS();

                ba.TC = dr["TC"].ToString();
                ba.TD = dr["TD"].ToString();
                ba.REFERENCE = dr["REFERENCE"].ToString();
                ba.BASCODE   = dr["BAS_CODE"].ToString();
                ba.ENTERED   = dr["ENTERED"].ToString();
                ba.PROCESSED = dr["PROCESSED"].ToString();
                ba.BAS       = dr["BAS"].ToString();
                ba.FEE       = dr["FEE"].ToString();
                ba.AVERAGE   = dr["AVERAGE"].ToString();
                ba.COMMENTS = dr["COMMENTS"].ToString();

                list.Add(ba);
            }
            objlist = list;
            context.Response.Write(new JavaScriptSerializer().Serialize(objlist));

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
        public class BenefitAS
        {
            public string TC { get; set; }
            public string TD { get; set; }
            public string REFERENCE { get; set; }
            public string BASCODE   { get; set; }
            public string ENTERED   { get; set; }
            public string PROCESSED { get; set; }
            public string BAS       { get; set; }
            public string FEE       { get; set; }
            public string AVERAGE   { get; set; }
            public string COMMENTS { get; set; }
        }
    }
