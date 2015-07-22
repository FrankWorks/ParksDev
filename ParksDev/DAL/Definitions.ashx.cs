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
    /// Summary description for Definitions
    /// </summary>
    public class Definitions : IHttpHandler
    {
        public void ProcessRequest(HttpContext context) {

            string mString = context.Request.QueryString["agencies"];
            string mStringType = context.Request.QueryString["agencyType"];
            string mStringDist = context.Request.QueryString["distType"];
            string mStringDetail = context.Request.QueryString["detail"];
            string mStringFunding = context.Request.QueryString["funding"];
                
            string sqlQueryString = "";
            var obj = new object();

            if (mString == "a" && mStringType == "0")
            {
                sqlQueryString = "SELECT * FROM FoxProDev.dbo.AGENCIES LEFT OUTER JOIN FoxProDev.dbo.AGENCYTYPES ON AGENCIES.ATP_CODE = AGENCYTYPES.ATP_CODE LEFT OUTER JOIN FoxProDev.dbo.DISTRICT ON AGENCIES.DIS_CODE = DISTRICT.DIS_CODE order by AGENCIES.AGENCY ";
                obj = getAgencies(sqlQueryString, mString);
            }
            else if (mString != "a" && mString != "0" && mStringType == "0")
            {
                sqlQueryString = "SELECT * FROM FoxProDev.dbo.AGENCIES LEFT OUTER JOIN FoxProDev.dbo.AGENCYTYPES ON AGENCIES.ATP_CODE = AGENCYTYPES.ATP_CODE LEFT OUTER JOIN FoxProDev.dbo.DISTRICT ON AGENCIES.DIS_CODE = DISTRICT.DIS_CODE WHERE AGENCIES.AGE_CODE =" + mString ;
                obj = getAgencies(sqlQueryString, mString);
            }

            if (mString == "0" && mStringType == "t" && mStringType != "0")
            {
                //sqlQueryString = "SELECT distinct  AGENCYTYPES.ATP_CODE, AGENCYTYPES.AGE_TYPE FROM FoxProDev.dbo.AGENCIES LEFT OUTER JOIN FoxProDev.dbo.AGENCYTYPES ON AGENCIES.ATP_CODE = AGENCYTYPES.ATP_CODE LEFT OUTER JOIN FoxProDev.dbo.DISTRICT ON AGENCIES.DIS_CODE = DISTRICT.DIS_CODE";
                sqlQueryString = "SELECT distinct AGENCYTYPES.ATP_CODE, AGENCYTYPES.AGE_TYPE FROM FoxProDev.dbo.AGENCYTYPES";

                obj = getAgencies(sqlQueryString, mStringType);
            }
            else if (mString == "0" && mStringType != "t" && mStringType != "0")
            {
                sqlQueryString = "SELECT * FROM FoxProDev.dbo.AGENCIES LEFT OUTER JOIN FoxProDev.dbo.AGENCYTYPES ON AGENCIES.ATP_CODE = AGENCYTYPES.ATP_CODE LEFT OUTER JOIN FoxProDev.dbo.DISTRICT ON AGENCIES.DIS_CODE = DISTRICT.DIS_CODE WHERE AGENCYTYPES.ATP_CODE = " + mStringType;
                obj = getAgencies(sqlQueryString, mStringType);
            }
            else if (mString == "0" && mStringType == "0")
            {
                sqlQueryString = "SELECT * FROM FoxProDev.dbo.AGENCIES LEFT OUTER JOIN FoxProDev.dbo.AGENCYTYPES ON AGENCIES.ATP_CODE = AGENCYTYPES.ATP_CODE LEFT OUTER JOIN FoxProDev.dbo.DISTRICT ON AGENCIES.DIS_CODE = DISTRICT.DIS_CODE order by AGENCIES.AGENCY ";
                obj = getAgencies(sqlQueryString, mString);
            } // new for all agencies

            if (mStringDist == "d")
            {
                sqlQueryString = "SELECT DISTINCT DISTRICT.DIS_CODE, DISTRICT.FULLNAME FROM FoxProDev.dbo.AGENCIES LEFT OUTER JOIN FoxProDev.dbo.AGENCYTYPES ON AGENCIES.ATP_CODE = AGENCYTYPES.ATP_CODE LEFT OUTER JOIN FoxProDev.dbo.DISTRICT ON AGENCIES.DIS_CODE = DISTRICT.DIS_CODE";
                obj = getAgencies(sqlQueryString, mStringDist);
            }
            else if (mStringDist != "d" && mString == "0" && mStringType == "0" && mStringDist != "0")//added mstringdist != "0"
            {
                sqlQueryString = "SELECT * FROM FoxProDev.dbo.AGENCIES LEFT OUTER JOIN FoxProDev.dbo.AGENCYTYPES ON AGENCIES.ATP_CODE = AGENCYTYPES.ATP_CODE LEFT OUTER JOIN FoxProDev.dbo.DISTRICT ON AGENCIES.DIS_CODE = DISTRICT.DIS_CODE WHERE DISTRICT.DIS_CODE = " + mStringDist;
                obj = getAgencies(sqlQueryString, mStringDist);                
            }
            //if (mStringDist == "0" && mStringDist != "0" && mStringType != "0")
            //{
            //    sqlQueryString = "SELECT * FROM FoxProDev.dbo.AGENCIES LEFT OUTER JOIN FoxProDev.dbo.AGENCYTYPES ON AGENCIES.ATP_CODE = AGENCYTYPES.ATP_CODE LEFT OUTER JOIN FoxProDev.dbo.DISTRICT ON AGENCIES.DIS_CODE = DISTRICT.DIS_CODE WHERE DISTRICT.DIS_CODE = " + mStringDist + " AND AGENCIES.ATP_CODE = " + mStringType;
            //    obj = getAgencies(sqlQueryString, "other");  //new
            //}

            if (mStringDetail == "yes" && mString!= "0")
            {
                //sqlQueryString = "SELECT AGENCCALCS.NO_PARC, AGENCCALCS.PCT_BAS, AGENCCALCS.FY_EST, AGENCCALCS.FY_FEE, CALTYPES.FY_FROM, CALTYPES.FY_TO, CALTYPES.PRC_BAS, CALTYPES.YEAR_FR, CALTYPES.MONTH_FR, CALTYPES.YEAR_TO, CALTYPES.MONTH_TO, AGENCCALCS.AGE_CODE FROM AGENCCALCS LEFT OUTER JOIN CALTYPES ON AGENCCALCS.CTP_CODE = CALTYPES.CTP_CODE WHERE AGENCCALCS.AGE_CODE =" + mString +"ORDER BY CALTYPES.FY_FROM";
                //Frank Kim to capture ACA_CODE to Grid on 07/21/2015
                sqlQueryString = "SELECT AGENCCALCS.NO_PARC, AGENCCALCS.PCT_BAS, AGENCCALCS.FY_EST, AGENCCALCS.FY_FEE, CALTYPES.FY_FROM, CALTYPES.FY_TO, CALTYPES.PRC_BAS, CALTYPES.YEAR_FR, CALTYPES.MONTH_FR, CALTYPES.YEAR_TO, CALTYPES.MONTH_TO, AGENCCALCS.AGE_CODE, AGENCCALCS.ACA_CODE  FROM AGENCCALCS LEFT OUTER JOIN CALTYPES ON AGENCCALCS.CTP_CODE = CALTYPES.CTP_CODE WHERE AGENCCALCS.AGE_CODE =" + mString + "ORDER BY CALTYPES.FY_FROM";
                obj = getAgencies(sqlQueryString, mStringDetail);  
            }

            if (mStringFunding == "funding" && mString != "0")
            {
                //sqlQueryString = "SELECT FUNDTYPES.FUND_TYPE, FUNDTYPES.FUND_AMT, AGENFUNDS.AGE_CODE FROM AGENFUNDS LEFT OUTER JOIN FUNDTYPES ON AGENFUNDS.FTP_CODE = FUNDTYPES.FTP_CODE WHERE AGENFUNDS.AGE_CODE =" + mString;
                sqlQueryString = "SELECT FUNDTYPES.CALCULATED, FUNDTYPES.FUND_TYPE, AGENFUNDS.AMT, AGENFUNDS.AGE_CODE, AGENFUNDS.COMMENTS FROM AGENFUNDS LEFT OUTER JOIN FUNDTYPES ON AGENFUNDS.FTP_CODE = FUNDTYPES.FTP_CODE WHERE AGENFUNDS.AGE_CODE =" + mString;

                obj = getAgencies(sqlQueryString, mStringFunding);
            }

            if (obj != null)
            {
                context.Response.Write(new JavaScriptSerializer().Serialize(obj));
                obj = null;
            }
        }

        private object getAgencies(string sqlQueryString, string sw)
        {

            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
 
            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand(sqlQueryString, conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            if (sw == "yes")
            {
                var objlist = new List<ObjInterestDetail>();                            //objlist is new object of the List of benefitAS class
                List<ObjInterestDetail> list = new List<ObjInterestDetail>();           // list is new oject of a LIST<BenefitAS> collection?
                foreach (DataRow dr in dt.Rows) {
                    ObjInterestDetail ag = new ObjInterestDetail();
                    ag.NO_PARC = dr["NO_PARC"].ToString();
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
                    // Frank Kim on 07/21/15
                    ag.ACA_CODE = dr["ACA_CODE"].ToString();
                    

                    list.Add(ag);
                   
                }
                return objlist = list;
            }
            else if (sw == "funding")
            {
                var objlist = new List<objFunding>();                            //objlist is new object of the List of benefitAS class
                List<objFunding> list = new List<objFunding>();           // list is new oject of a LIST<BenefitAS> collection?
                foreach (DataRow dr in dt.Rows)
                {
                    objFunding ag = new objFunding();
                    ag.FUND_TYPE = dr["FUND_TYPE"].ToString();
                    ag.FUND_AMT = dr["AMT"].ToString();
                    ag.AGE_CODE = dr["AGE_CODE"].ToString();
                    ag.COMMENTS = dr["COMMENTS"].ToString();
                    ag.CALCULATED = dr["CALCULATED"].ToString();
                    list.Add(ag);
                }
                return objlist = list;
            }
            else
            {
                var objlist = new List<ObjDefinistions>();                          //objlist is new object of the List of benefitAS class
                List<ObjDefinistions> list = new List<ObjDefinistions>();           // list is new oject of a LIST<BenefitAS> collection?
                foreach (DataRow dr in dt.Rows)
                {
                    ObjDefinistions ag = new ObjDefinistions();

                    if (sw == "t")
                    {
                        ag.ATP_CODE = dr["ATP_CODE"].ToString();
                        ag.AGE_TYPE = dr["AGE_TYPE"].ToString();
                    }
                    else if (sw == "d")
                    {
                        ag.DIS_CODE = dr["DIS_CODE"].ToString();
                        ag.FULLNAME = dr["FULLNAME"].ToString();
                    }
                    else
                    {
                        ag.AGENCY = dr["AGENCY"].ToString();
                        ag.AGE_CODE = dr["AGE_CODE"].ToString();
                        ag.NAME = dr["NAME"].ToString();
                        ag.ATP_CODE = dr["ATP_CODE"].ToString();
                        ag.DIS_CODE = dr["DIS_CODE"].ToString();
                        ag.ADR1 = dr["ADR1"].ToString();
                        ag.ADR2 = dr["ADR2"].ToString();
                        ag.CITY = dr["CITY"].ToString();
                        ag.ZIP = dr["ZIP"].ToString();
                        ag.AMTMTC = dr["AMTMTC"].ToString();
                        ag.AMTDEV = dr["AMTDEV"].ToString();
                        ag.AMTYEG = dr["AMTYEG"].ToString();
                        ag.AGE_TYPE = dr["AGE_TYPE"].ToString();
                        ag.GOVWIDE = dr["GOVWIDE"].ToString();
                        ag.FULL_NAME = dr["FULL_NAME"].ToString();
                        ag.NO_PARCEL = dr["NO_PARCEL"].ToString();
                        ag.PCT_BA = dr["PCT_BA"].ToString();
                        ag.DISTRICT = dr["DISTRICT"].ToString();
                        ag.FULLNAME = dr["FULLNAME"].ToString();
                    }
                    list.Add(ag);
             
                 
                }
                return objlist = list;
            }//end else            
        }

        public class ObjDefinistions
        {
            public string AGENCY { get; set; }
            public string AGE_CODE { get; set; }
            public string NAME {get; set;}
            public string ATP_CODE { get; set; }
            public string DIS_CODE { get; set; }
            public string ADR1 { get; set; }
            public string ADR2 { get; set; }
            public string CITY { get; set; }
            public string ZIP { get; set; }
            public string AMTMTC {get; set;}
            public string AMTDEV { get; set; }
            public string AMTYEG {get; set;}
            public string AGE_TYPE { get; set; }
            public string GOVWIDE { get; set; }
            public string FULL_NAME { get; set; }
            public string NO_PARCEL { get; set; }
            public string PCT_BA { get; set; }
            public string DISTRICT { get; set; }
            public string FULLNAME { get; set; }
        }

        public class ObjInterestDetail 
        {
            public string NO_PARC { get; set; }
            public string PCT_BAS {get; set;}
            public string FY_EST {get; set;}
            public string FY_FEE {get; set;}
            public string FY_FROM { get; set; }
            public string FY_TO { get; set; }
            public string PRC_BAS {get; set;}
            public string YEAR_FR {get; set;}
            public string MONTH_FR {get; set;}
            public string YEAR_TO {get; set;}
            public string MONTH_TO {get; set;}
            public string AGE_CODE { get; set; }
            // Frank Kim on 07/21/15
            public string ACA_CODE { get; set; }
           
        }

        public class objFunding
        {
            public string FUND_TYPE {get; set;}
            public string FUND_AMT {get; set;}
            public string AGE_CODE {get; set;}
            public string COMMENTS { get; set; }
            public string CALCULATED { get; set; }
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