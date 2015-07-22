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
    /// Summary description for Definitions_Detail
    /// </summary>
    public class Definitions_Detail : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string prefixText = context.Request.QueryString["code"] + "%";

            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand("SELECT AGENCY, AGE_CODE FROM [AGENCIES] WHERE AGENCY like '" + prefixText + "'", conn);
            //SqlCommand cmd = new SqlCommand("SELECT AGENCY, AGE_CODE FROM [AGENCIES]", conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objlist = new List<ObjInterestDetail>();                 //objlist is new object of the List of benefitAS class
            List<ObjInterestDetail> list = new List<ObjInterestDetail>();        // list is new oject of a LIST<BenefitAS> collection?
            foreach (DataRow dr in dt.Rows)
            {
                ObjInterestDetail ag = new ObjInterestDetail();

                ag.FY_EST = dr["FY_EST"].ToString();
                ag.FY_FEE = dr["FY_FEE"].ToString();
                ag.FY_FROM = dr["FY_FROM"].ToString();
                ag.FY_TO = dr["FY_TO"].ToString();
                ag.MONTH_FR = dr["MONTH_FR"].ToString();
                ag.MONTH_TO = dr["MONTH_TO"].ToString();
                ag.PCT_BAS = dr["PCT_BAS"].ToString();
                ag.PRC_BAS = dr["PRC_BAS"].ToString();
                ag.YEAR_FR = dr["YEAR_FR"].ToString();
                ag.YEAR_TO = dr["YEAR_TO"].ToString();
                ag.AGE_CODE = dr["AGE_CODE"].ToString();

                list.Add(ag);
            }
            objlist = list;
            context.Response.Write(new JavaScriptSerializer().Serialize(objlist));
        
        }//end proc req

        public class ObjInterestDetail
        {
            public string PCT_BAS { get; set; }
            public string FY_EST { get; set; }
            public string FY_FEE { get; set; }
            public string FY_FROM { get; set; }
            public string FY_TO { get; set; }
            public string PRC_BAS { get; set; }
            public string YEAR_FR { get; set; }
            public string MONTH_FR { get; set; }
            public string YEAR_TO { get; set; }
            public string MONTH_TO { get; set; }
            public string AGE_CODE { get; set; }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        } // end isReusable
    }
}