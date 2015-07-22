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
namespace ParksDev
{
    public partial class Totals : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)  
        {

        }
        public void loadTotalGrid(object sender, EventArgs e)
        {
            //string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

            //SqlConnection totalConnection = new SqlConnection(connectionString);

            //totalConnection.Open();

            //SqlCommand totalCommand = new SqlCommand("select FY, SUM(AMT_BEG) as StartingBalance, SUM(AMT_BAS) as endingBalance, SUM(YEG_BEG) as YEGBalance From FOXPRODEV.dbo.AGENBALANCFY GROUP BY [FY] order by FY", totalConnection);
            //SqlDataReader totalReader = totalCommand.ExecuteReader();

            //totals.DataSource = totalReader;
            //totals.DataBind();
        

        }
    }
}