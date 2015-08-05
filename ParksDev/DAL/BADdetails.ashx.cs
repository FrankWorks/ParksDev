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
    /// Summary description for BADdetails
    /// </summary>
    public class BADdetails : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string bascode = context.Request.QueryString["bascode"];

            string connection = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connection);
            //SqlCommand cmd = new SqlCommand("SELECT [FOXPRODEV].[dbo].[AGENCIES].[AGENCY],[FOXPRODEV].[dbo].[AGENBENEFITS].[ABA_CODE], [FOXPRODEV].[dbo].[AGENBENEFITS].[BAS],[FOXPRODEV].[dbo].[AGENBENEFITS].[FEE],[FOXPRODEV].[dbo].[AGENBENEFITS].[AVERAGE],[FOXPRODEV].[dbo].[AGENBENEFITS].[AVERAGE] FROM [FOXPRODEV].[dbo].[AGENBENEFITS] left outer join [FOXPRODEV].[dbo].[AGENCIES] on [AGENBENEFITS].[AGE_CODE] = [AGENCIES].[AGE_CODE] where [FOXPRODEV].[dbo].[AGENBENEFITS].[BAS_CODE] =" + bascode + "order by [AGENBENEFITS].[AGE_CODE]", conn);
            SqlCommand cmd = new SqlCommand("SELECT [FOXPRODEV].[dbo].[AGENCIES].[AGENCY],[FOXPRODEV].[dbo].[AGENBENEFITS].[ABA_CODE], [FOXPRODEV].[dbo].[AGENBENEFITS].[BAS],[FOXPRODEV].[dbo].[AGENBENEFITS].[FEE],[FOXPRODEV].[dbo].[AGENBENEFITS].[AVERAGE],[FOXPRODEV].[dbo].[AGENBENEFITS].[AVERAGE], [FOXPRODEV].[dbo].[AGENCIES].atp_code, [FOXPRODEV].[dbo].[AGENCIES].age_code FROM [FOXPRODEV].[dbo].[AGENBENEFITS] left outer join [FOXPRODEV].[dbo].[AGENCIES] on [AGENBENEFITS].[AGE_CODE] = [AGENCIES].[AGE_CODE] where [FOXPRODEV].[dbo].[AGENBENEFITS].[BAS_CODE] =" + bascode + "order by AGENCIES.ATP_CODE, [AGENBENEFITS].[AGE_CODE]", conn);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            var objList = new List<BADdetail>();
            List<BADdetail> list = new List<BADdetail>();
            foreach (DataRow dr in dt.Rows)
            { //for each "datarow" in datatable "dt" assinged the value to "dr" for each instance of loop
                BADdetail mi = new BADdetail();
                mi.AGENCY = dr["AGENCY"].ToString();
                mi.BAS = dr["BAS"].ToString();
                mi.FEE = dr["FEE"].ToString();
                mi.AVERAGE = dr["AVERAGE"].ToString();
                mi.ABA_CODE = dr["ABA_CODE"].ToString();
                // 2 More Properites are mapped for soart informaiton to dispaly agencies into proper groups, such as Distict / County Entities 
                // on 8/3/2015
                // Frank Kim
                mi.ATP_CODE = dr["ATP_CODE"].ToString();
                mi.AGE_CODE = dr["AGE_CODE"].ToString();

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
    public class BADdetail
    {
        public string AGENCY    { get; set; }
        public string BAS       { get; set; }
        public string FEE       { get; set; }
        public string AVERAGE   { get; set; }
        public string ABA_CODE { get; set; }
        public string ATP_CODE { get; set; }
        public string AGE_CODE { get; set; }

    }
}