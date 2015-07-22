using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace ParksDev.DAL
{
    public partial class agenInterest : IHttpHandler
    {


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public void ProcessRequest(HttpContext context)
        {
            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;

            string whatToDo = forms.Get("oper");



            if (whatToDo == "edit")
            {
                
                //string kNo_Parc = forms.Get("NO_PARC").ToString();
                //string kInterest = forms.Get("PCT_BAS").ToString();
                //string kAgeCode = forms.Get("AGE_CODE").ToString();
                //string kAcaCode = forms.Get("ACA_CODE").ToString();

                float kNo_Parc = float.Parse(forms.Get("NO_PARC").ToString(), System.Globalization.CultureInfo.InvariantCulture);
                double kInterest = FromPercentageString(forms.Get("PCT_BAS").ToString());
                float kAgeCode = float.Parse(forms.Get("AGE_CODE").ToString(), System.Globalization.CultureInfo.InvariantCulture);
                float kAcaCode = float.Parse(forms.Get("ACA_CODE").ToString(), System.Globalization.CultureInfo.InvariantCulture);

                
                
                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;


                SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();

                string editstring = "UPDATE [FOXPRODEV].[dbo].[AGENCCALCS] SET PCT_BAS = @pct_bas, NO_PARC = @no_parc WHERE AGE_CODE=@age_code and ACA_CODE = @aca_code";

                SqlCommand editcommand = new SqlCommand(editstring, conn);

                editcommand.Parameters.Add("@pct_bas", SqlDbType.Float).Value = kInterest;
                editcommand.Parameters.Add("@no_parc", SqlDbType.Float).Value = kNo_Parc;
                editcommand.Parameters.Add("@age_code", SqlDbType.Float).Value = kAgeCode;
                editcommand.Parameters.Add("@aca_code", SqlDbType.Float).Value = kAcaCode;


                editcommand.ExecuteNonQuery();
                conn.Close();
                editcommand.Dispose();

            }
            else if (whatToDo == "del")
            {

                string rmv1 = forms.Get("Age_Code_Value").ToString();
                string rmv2 = forms.Get("Aca_Code_Value").ToString();
                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
                SqlConnection delconn = new SqlConnection(connectionString);
                delconn.Open();

                SqlCommand delcom = new SqlCommand("DELETE FROM FOXPRODEV.dbo.AGENCCALCS WHERE AGE_CODE = @age_code and ACA_CODE = @aca_code", delconn);
                delcom.Parameters.Add("@age_code", SqlDbType.Float).Value = rmv1;
                delcom.Parameters.Add("@aca_code", SqlDbType.Float).Value = rmv2;

                delcom.ExecuteNonQuery();
                delcom.Dispose();
                delconn.Close();
            }
            else if (whatToDo == "add")
            {
                throw new NotImplementedException();
            }



        }

        private double FromPercentageString(string p)
        {
       
          return double.Parse(p.Replace("%", "")) / 100;
       
        }



    }
}