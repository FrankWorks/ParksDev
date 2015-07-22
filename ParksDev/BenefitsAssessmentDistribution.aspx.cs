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
    public partial class BenefitsAssessmentDistribution : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void badselected(Object sender, EventArgs e)
        {
           // string bascoder = BenAssDisGrid.SelectedValue.ToString();
           ////Response.Write(bascoder); //testing

           // //sql stuff
           //string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString; //connection string for sql
           //SqlConnection badConnection = new SqlConnection(connectionString);   //creates new sql connetion
           //badConnection.Open();//opens connection
           //SqlCommand badCommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENBENEFITS] left outer join [FOXPRODEV].[dbo].[AGENCIES] on [AGENBENEFITS].[AGE_CODE] = [AGENCIES].[AGE_CODE] where [FOXPRODEV].[dbo].[AGENBENEFITS].[BAS_CODE] = @BASERCODE order by [AGENBENEFITS].[AGE_CODE]", badConnection); //sql statement and the connection name
           // badCommand.Parameters.AddWithValue("BASERCODE", bascoder.ToString()); //get bascode
           // SqlDataReader badReader = badCommand.ExecuteReader(); //create and execute reader
           // while (badReader.Read())
           // {
           //     AgencyDistGrid.DataSource = badReader;
           //     AgencyDistGrid.DataBind();
           // }



        }
        public void badselectchanging(Object send, GridViewSelectEventArgs e)
        {
        //    GridViewRow row = BenAssDisGrid.Rows[e.NewSelectedIndex];
        }

    }
}