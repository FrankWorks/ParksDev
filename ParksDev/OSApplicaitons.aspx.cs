using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient; //for sql data connection 
 
namespace ParksDev
{

    public partial class OSApplicaitons : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //    string connstring = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString; //takes connection string from web.config
            //    SqlConnection osappcon = new SqlConnection(connstring);                                    //creates new sql connection named osappcon

            //    Response.Write(connstring.ToString());                                                    //dispalys the connection string on the screen

            //    SqlDataReader redr = null;                                                                //creates a sqldatareader named redr w
            //    osappcon.Open();                                                                          // opens up the sql connection
            //    SqlCommand testcmd = new SqlCommand("SELECT * FROM [AGENCIES]", osappcon);                // new query is sent using "osappcon" connection
            //    redr = testcmd.ExecuteReader();                                                           // runs the "testcmd" sql command
            //    DistrictGridView.DataSource = redr;                                                              // make the datareader redr the datasource for the grid view
            //    DistrictGridView.DataBind();                                                                     //binds the data to the gridview "gridview1"
            //    redr.Close();                                                                             // close the connection
        }
        public void DistrictselectChange(Object sender, EventArgs e)
        {
            GridViewRow row = DistrictGridView.SelectedRow;
            Response.Write(" you selected " + row.Cells[2].Text + ".");  //tells you what district you selected

        }
        public void DistrictselectChanging(Object sender, GridViewSelectEventArgs e)
        {
            string cString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;  //gets the connection string
            SqlConnection agbconnection = new SqlConnection(cString);                                               //new connection named agbconnection using the cString connection string

            GridViewRow row = DistrictGridView.SelectedRow;                                                         //create row ojbect of the selected row from districtGridView

            string thecode = row.Cells[1].Text;                                                                      //gets name of district from DistrictGridView from to use in the sql statment
            agbconnection.Open();

            SqlCommand agbcommand = new SqlCommand("Select TOP 10 * from [AGENBENEFITS] where AGE_CODE = @agbcode", agbconnection); //sql command to get agency benefits
            agbcommand.Parameters.AddWithValue("agbcode", thecode.ToString()); //inserts the query variable

            SqlDataReader agbreader = agbcommand.ExecuteReader();                        //starts the reader
            AGB.DataSource = agbreader;                                                         // datasource of the gridview
            AGB.DataBind();                                                         // binding source

            agbreader.Close();                                                              //close the agbreader connection


            agbcommand.Dispose();          //dispose of the last sqlcommand

            //start connection for balance year
            SqlCommand agenbalfy = new SqlCommand("Select * from [AGENBALACFY] where AGE_CODE = @abfy", agbconnection);
            agenbalfy.Parameters.AddWithValue("abfy", thecode.ToString());                                                      //add the variable, same as the last sqlcommandd

            SqlDataReader balfyreader = agenbalfy.ExecuteReader(); //creates a new reader

            agebalfy.DataSource = balfyreader; //datasouce for the gridview agebalfy
            agebalfy.DataBind();//gbind that data!
            balfyreader.Close();//close out the reader
            agenbalfy.Dispose();//gets rid of the sqlcommand

            //start connection for balance monthly
            SqlCommand agenbalm = new SqlCommand("Select * from [AGENBALANMONTH] where AGE_CODE = @agmo", agbconnection); // sql statment for monthly
            agenbalm.Parameters.AddWithValue("agmo", thecode.ToString()); //add the variable to sql statment.

            SqlDataReader balmoreader = agenbalm.ExecuteReader(); //new reader

            agebalmgrid.DataSource = balmoreader; //datasource for grid
            agebalmgrid.DataBind(); //bind the data


            agbconnection.Close();
        }

        public void agb_change(Object sender, EventArgs e)
        {
            GridViewRow row = AGB.SelectedRow;
            Response.Write(" you selected " + row.Cells[2].Text + ".");
        }
        public void agb_changing(Object sender, GridViewSelectEventArgs e)
        {
           
            string constring = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection beneConnection = new SqlConnection(constring);

            GridViewRow row = AGB.SelectedRow;
            string thecode = row.Cells[2].Text;

            beneConnection.Open();

            SqlCommand benecommand = new SqlCommand("Select * from [BENEFITS] where BAS_CODE = @bascoder", beneConnection);
            benecommand.Parameters.AddWithValue("bascoder", thecode.ToString());

            SqlDataReader benereader = benecommand.ExecuteReader();
            benefitsGrid.DataSource = benereader;
            benefitsGrid.DataBind();

            benereader.Close();
            beneConnection.Close();

        }
        public void benefitschanging(Object sender, GridViewSelectEventArgs e)
        {
            GridViewRow row = benefitsGrid.Rows[e.NewSelectedIndex];

            }


    }
}