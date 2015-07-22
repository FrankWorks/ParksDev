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
    public partial class runbal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public string getMonth(Int32 getdaMonth) //gets the month name from the number
        {
            var dtf = CultureInfo.CurrentCulture.DateTimeFormat;
            string monthName = dtf.GetMonthName(getdaMonth);
            return monthName;

        }
        public void agencyselect(Object sender, EventArgs e)
        {
            //string agencycode = agencydropdownlist.SelectedItem.Value.ToString();  // gets the agency code from the dropdown list
   

            //string DMYstring = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString; //deninfions month, year connection string, for rest of the queries too.

            ////gets the definitions data, development, maintence, yeg total
            //SqlConnection agencyConn = new SqlConnection(DMYstring); //agencyconn sqlconnection
            //agencyConn.Open();                                       //open the connection
            //SqlCommand DMYcommand = new SqlCommand("SELECT * FROM FoxProDev.dbo.AGENCIES LEFT OUTER JOIN FoxProDev.dbo.AGENCYTYPES ON AGENCIES.ATP_CODE = AGENCYTYPES.ATP_CODE LEFT OUTER JOIN FoxProDev.dbo.DISTRICT ON AGENCIES.DIS_CODE = DISTRICT.DIS_CODE WHERE AGENCIES.AGE_CODE = @MYVCODE", agencyConn); // sqlstatement
            //DMYcommand.Parameters.AddWithValue("MYVCODE", agencycode.ToString()); //gets parameters from agencycode, what to pull out of database

            //SqlDataReader DMYreader = DMYcommand.ExecuteReader(); //while reader runs, doesnt work otherwise
            //while (DMYreader.Read())
            //{
            //    int columMTC = Convert.ToInt32(DMYreader["AMTMTC"]);
            //    MTCAMT.Text = string.Format("{0:C2}", columMTC); //sets the label value

            //    int columDEV = Convert.ToInt32(DMYreader["AMTDEV"]);
            //    DEVAMT.Text = string.Format("{0:C2}", columDEV);

            //    int columYEG = Convert.ToInt32(DMYreader["AMTYEG"]);
            //    YEGAMT.Text = string.Format("{0:C2}", columYEG);
            //}
            //dmyTable.Visible = true;
            //DMYreader.Close();
            //DMYcommand.Dispose();

            //SqlCommand FYcommand = new SqlCommand("SELECT * FROM [FoxProDev].[dbo].[AGENBALANCFY] where [AGE_CODE] = @ageCode order by [FY] asc", agencyConn);
            //FYcommand.Parameters.AddWithValue("ageCode", agencycode.ToString());

            //SqlDataReader FYreader = FYcommand.ExecuteReader();
            //FYGrid.DataSource = FYreader;
            //FYGrid.DataBind();
            //FYreader.Close(); //closes all the connections n such
            //FYcommand.Dispose();
            //DMYcommand.Dispose();
        }
        public void showMonth(object sender, EventArgs e)
        {

            //string agencycode = agencydropdownlist.SelectedItem.Value.ToString();  // gets the agency code from the dropdown list

            //string FYcode = FYGrid.SelectedValue.ToString();
            ////Response.Write(FYcode);
            //string MonthGridString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

            //SqlConnection MonthGriderCon = new SqlConnection(MonthGridString);

            //MonthGriderCon.Open();

            //SqlCommand MonthCommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENBALANMONTH] where [FY] = @FYcoder and [AGE_CODE] = @aCode  ORDER BY [YEAR] ", MonthGriderCon);

            //MonthCommand.Parameters.AddWithValue("FYcoder", FYcode.ToString()); //get pramaters from FYcode
            //MonthCommand.Parameters.AddWithValue("aCode", agencycode.ToString()); //get agency code

            //SqlDataReader MonthReader = MonthCommand.ExecuteReader();

            //MonthBalGrid.DataSource = MonthReader;
            //MonthBalGrid.DataBind();

            ////while (MonthReader.Read())
            ////{
                
            ////}
        }

    }
}
