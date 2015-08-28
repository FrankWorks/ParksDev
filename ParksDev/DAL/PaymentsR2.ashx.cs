using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace ParksDev.DAL
{
    /// <summary>
    /// Summary description for PaymentsR2
    /// </summary>
    public class PaymentsR2 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string mSwitch = context.Request.QueryString["switch"];
            string mString = context.Request.QueryString["agencies"];
            string mStringFiscalYear = context.Request.QueryString["agencyFiscalYear"];
            //string mStringDist = context.Request.QueryString["distType"];
            //string mStringDetail = context.Request.QueryString["detail"];
            //string mStringFunding = context.Request.QueryString["funding"];

            string sqlQueryString = "";
            //string strOption = mString;
            var obj = new object();

            if (mSwitch =="Step1")
            {
                sqlQueryString = "uspGetPaymentsMasterGrid";
                
                obj = getPaymentsInfo(sqlQueryString: sqlQueryString, strAgency: mString, fiscalYear: mStringFiscalYear);
                
            }

            if (mSwitch == "Step2")
            {
                sqlQueryString = "uspGetPaymentsFiscalYear";
                obj = getFiscalYear(sqlQueryString);
            }

            if (mSwitch == null && mString != null && mStringFiscalYear !=null)
            {
                sqlQueryString = "uspGetPaymentsMasterGrid";

                obj = getPaymentsInfo(sqlQueryString: sqlQueryString, strAgency: mString, fiscalYear: mStringFiscalYear);

            }

            if (mSwitch == null && mString != null && mStringFiscalYear == null)
            {
                sqlQueryString = "uspGetPaymentsMasterGrid";

                obj = getPaymentsInfo(sqlQueryString: sqlQueryString, strAgency: mString, fiscalYear: DateTime.Now.AddYears(-1).Year.ToString());

            }
            //sqlQueryString = "uspGetPaymentListDataR2";
            
            if (obj != null)
            {
                context.Response.Write(new JavaScriptSerializer().Serialize(obj));
                obj = null;
            }


            // 2nd intertion for getting 
        }

        private Object getPaymentsInfo(string sqlQueryString, string strAgency = "", string fiscalYear ="")
        {
            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand(sqlQueryString, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            if (String.IsNullOrEmpty(strAgency))
            {
                cmd.Parameters.Add("@AGE_CODE", SqlDbType.Int).Value = null;
                cmd.Parameters.Add("@fiscalYear", SqlDbType.Int).Value = null;
                
            }
            else
            {
                cmd.Parameters.Add("@AGE_CODE", SqlDbType.Int).Value = Int32.Parse(strAgency);
                cmd.Parameters.Add("@fiscalYear", SqlDbType.Int).Value = Int32.Parse(fiscalYear??DateTime.Now.AddYears(-1).Year.ToString());
            }
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
 	        



            var objlist = new List<ObjPaynetsGridSelect>();                            //objlist is new object of the List of benefitAS class
            List<ObjPaynetsGridSelect> list = new List<ObjPaynetsGridSelect>();           // list is new oject of a LIST<BenefitAS> collection?
            foreach (DataRow dr in dt.Rows)
            {
                ObjPaynetsGridSelect ag = new ObjPaynetsGridSelect();


                ag.Average = dr["Average"].ToString();
                ag.TRA_CODE = dr["TRA_CODE"].ToString();
                ag.TC = dr["TC"].ToString();
                ag.TD = dr["TD"].ToString();
                ag.Referece = dr["Reference"].ToString();
                ag.LUPD_DATE = dr["LUPD_DATE"].ToString();
                ag.LUPD_USER = dr["LUPD_USER"].ToString();
                ag.MinObj = dr["MinObj"].ToString();
                ag.Processed = dr["Processed"].ToString();
                ag.SUPDIST = dr["SUPDIST"].ToString();
                ag.Transferred = dr["TRANDATE"].ToString();
                ag.TRA = dr["TRA"].ToString();




                list.Add(ag);

            }
            return objlist = list;
            
        }


        private Object getFiscalYear(string sqlQueryString)
        {
            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand(sqlQueryString, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objlist = new List<ObjFiscalYear>();                            //objlist is new object of the List of benefitAS class
            List<ObjFiscalYear> list = new List<ObjFiscalYear>();           // list is new oject of a LIST<BenefitAS> collection?
            foreach (DataRow dr in dt.Rows)
            {
                ObjFiscalYear ag = new ObjFiscalYear();


                ag.FiscalYear = dr["fy"].ToString();


                list.Add(ag);
            }

            return list;

        }
        
 

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}