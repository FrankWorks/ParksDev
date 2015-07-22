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
    /// Summary description for Agency
    /// </summary>
    public class Agency : IHttpHandler
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

            var objlist = new List<AgencyObject>();                 //objlist is new object of the List of benefitAS class
            List<AgencyObject> list = new List<AgencyObject>();        // list is new oject of a LIST<BenefitAS> collection?
            foreach (DataRow dr in dt.Rows)
            {
                AgencyObject ag = new AgencyObject();

                ag.AGENCY = dr["AGENCY"].ToString();
                ag.AGE_CODE = dr["AGE_CODE"].ToString();

                list.Add(ag);
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

    public class AgencyObject
    {
        public string AGENCY { get; set; }
        public string AGE_CODE { get; set; }
    }
}