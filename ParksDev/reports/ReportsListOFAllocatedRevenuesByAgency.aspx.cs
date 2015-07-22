using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Globalization;

namespace ParksDev.reports
{
    public partial class ReportsListOFAllocatedRevenuesByAgency : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string constring = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(constring);
            conn.Open();

            SqlCommand command = new SqlCommand("Select * from [FOXPRODEV].[dbo].[getLARAfy] order by [FY], [AGE_CODE]", conn);
            SqlDataReader reader = command.ExecuteReader();
            reader.Read();
            FYRepeater.DataSource = reader;
            FYRepeater.DataBind();
            conn.Close();
        }
        private DataTable FYData(int fy)
        {
            string agencystring = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection agencycon = new SqlConnection(agencystring);
            agencycon.Open();
            string agencysql = "select distinct a.agency, ISNULL(b.AMT_BAS,0) as AMT_BAS, ISNULL(b.AMT_INT,0) as AMT_INT from FOXPRODEV.dbo.AGENBALANCFY b inner join FOXPRODEV.dbo.AGENCIES a on a.AGE_CODE = b.AGE_CODE where fy =" + fy +"order by a.AGENCY";
            SqlCommand command = new SqlCommand(agencysql, agencycon);
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            da.Fill(dt);
            agencycon.Close();
            return dt;
        }
        protected void FYRepeatBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                System.Data.Common.DbDataRecord dvr = (System.Data.Common.DbDataRecord)e.Item.DataItem;
                int fys = Convert.ToInt32(dvr["FY"]);
                Repeater innerRepeat = (Repeater)e.Item.FindControl("innerRepeat");
                innerRepeat.DataSource = FYData(fys);
                innerRepeat.DataBind();

            }
            

        }
        public int nextyear(int b)
        {
            int results = 1 + b;
            return results;
        }
        public string totalHB3(double a, double b)
        {
            double resultsnum = a + b;
            string results = resultsnum.ToString("c");
            return results;
        }
    
    }
}