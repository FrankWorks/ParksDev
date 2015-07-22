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
    public partial class MonthlyInterest : System.Web.UI.Page
    {
        public void showoldgrid(object sender, EventArgs e)
        {
            //if (MIG.Visible == true)
            //{
            //    MIG.Visible = false;
            //}
            //else
            //{
            //    MIG.Visible = true;
            //}
        }

        protected void Page_Load(object sender, EventArgs e)
        {


        }
        //public string getMonth(Int32 getdaMonth) //gets the month name from the number
        //{
        //    var dtf = CultureInfo.CurrentCulture.DateTimeFormat;
        //    string monthName = dtf.GetAbbreviatedMonthName(getdaMonth);
        //    return monthName;
            
        //}
        public void distGridSelected(Object sender,  EventArgs e)
        {
            //GridViewRow row = MonthlyINTGrid.SelectedRow;
          
            //    //Response.Write(row.Cells[3].Text.ToString() + " / " + row.Cells[4].Text.ToString());
            //    string selectYear = row.Cells[2].Text.ToString();
            //    string selectMonth = row.Cells[3].Text.ToString();
            //    //Response.Write(selectMonth.ToString() + "month");
            //    //Response.Write(selectYear.ToString() + "year");
            //    string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

            //    SqlConnection MIConnection = new SqlConnection(connectionString);

            //    MIConnection.Open();

            //    SqlCommand MICommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENBALANMONTH] left outer join [FOXPRODEV].[dbo].[AGENCIES] on [AGENBALANMONTH].[AGE_CODE] = [AGENCIES].[AGE_CODE] where [AGENBALANMONTH].[MONTH] = @selectMonther AND [AGENBALANMONTH].[YEAR] = @selectYearer order by [AGENBALANMONTH].[YEAR]", MIConnection);
            //    MICommand.Parameters.AddWithValue("selectMonther", selectMonth.ToString());
            //    MICommand.Parameters.AddWithValue("selectYearer", selectYear.ToString());

            //    SqlDataReader MIReader = MICommand.ExecuteReader();

              
            //        MonthDistGrid.DataSource = MIReader;
            //        MonthDistGrid.DataBind();

        }
        public void distGridSelecting(Object sender, GridViewSelectEventArgs e)
        {
            //GridViewRow row = MonthlyINTGrid.Rows[e.NewSelectedIndex];
        }
        
    }
}