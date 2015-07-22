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
    public partial class defenitions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        
            
        }
        public void closeEditPanel(Object sender, EventArgs e)
        {
            if (editPanel.Visible == true)
            {
                editPanel.Visible = false;
            }
        }
        public void openEditPanel(Object sender, EventArgs e)
        {
           DataTable agencytypedatatable = new DataTable();
           agencytypedatatable.Columns.Add("agetype", typeof(string));
                agencytypedatatable.Rows.Add("All agencies");
                agencytypedatatable.Rows.Add("County");
                agencytypedatatable.Rows.Add("City");
                agencytypedatatable.Rows.Add("SMMC");
                agencytypedatatable.Rows.Add("MRCA");
                formAgencyType.DataSource = agencytypedatatable;
                formAgencyType.DataTextField = "agetype";
                formAgencyType.DataValueField = "agetype";
                formAgencyType.DataBind();
       

            if (editPanel.Visible == false)
            {
                editPanel.Visible = true;
            }
            else { editPanel.Visible = false; }
        }
        public string getMonth(Int32 getdaMonth) //gets the month name from the number
        {
            var dtf = CultureInfo.CurrentCulture.DateTimeFormat;
            string monthName = dtf.GetMonthName(getdaMonth);
            return monthName;

        }
        
        public void agencyselect(Object sender, EventArgs e)
        {
            string agencycode = agencydropdownlist.SelectedItem.Value.ToString();  // gets the agency code from the dropdown list
            test21.Text = agencycode; //writes out the agency code number next to the scroll down list in the aspx page test21 label

            string DMYstring = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString; //deninfions month, year connection string, for rest of the queries too.

            //gets the definitions data, development, maintence, yeg total
            SqlConnection agencyConn = new SqlConnection(DMYstring); //agencyconn sqlconnection
            agencyConn.Open();                                       //open the connection
            SqlCommand DMYcommand = new SqlCommand("SELECT * FROM FoxProDev.dbo.AGENCIES LEFT OUTER JOIN FoxProDev.dbo.AGENCYTYPES ON AGENCIES.ATP_CODE = AGENCYTYPES.ATP_CODE LEFT OUTER JOIN FoxProDev.dbo.DISTRICT ON AGENCIES.DIS_CODE = DISTRICT.DIS_CODE WHERE AGENCIES.AGE_CODE = @MYVCODE", agencyConn); // sqlstatement
            DMYcommand.Parameters.AddWithValue("MYVCODE", agencycode.ToString()); //gets parameters from agencycode, what to pull out of database

            SqlDataReader DMYreader = DMYcommand.ExecuteReader(); //while reader runs, doesnt work otherwise
            while (DMYreader.Read())
            {
                
                    int columMTC = Convert.ToInt32(DMYreader["AMTMTC"]);
                    MTCAMT.Text = string.Format("{0:C2}", columMTC); //sets the label value

                    int columDEV = Convert.ToInt32(DMYreader["AMTDEV"]);
                    DEVAMT.Text = string.Format("{0:C2}", columDEV);

                    int columYEG = Convert.ToInt32(DMYreader["AMTYEG"]);
                    YEGAMT.Text = string.Format("{0:C2}", columYEG);

                    secondDiv.Visible = true;// show now that it has info

                //fill out the agency information
                string agencyinfostring = DMYreader["AGENCY"].ToString();
                AgencyInfo.Text = agencyinfostring;  
                
                //can somtimes be null, have to check for that, not really though.
                string nameinfo = DMYreader["NAME"].ToString();
                if (nameinfo.Length.Equals(0))
                {
                    NameInfo.Text = "n/a";
                }
                else
                {
                    NameInfo.Text = (DMYreader["NAME"]).ToString();
                }
                AgeTypeInfo.Text = DMYreader["AGE_TYPE"].ToString();
                DistrictInfo.Text = (DMYreader["DISTRICT"]).ToString();
                ADR1Info.Text = (DMYreader["ADR1"]).ToString();
                //ADR2Info.Text = (DMYreader["ADR2"]).ToString();
                CityInfo.Text = (DMYreader["CITY"]).ToString();
                ZipInfo.Text = (DMYreader["ZIP"]).ToString();

                
            }
            DMYreader.Dispose(); DMYcommand.Dispose(); agencyConn.Close();  // end all readers, commands, connections


            // gets all the agency calculations data
            SqlConnection agecalConn = new SqlConnection(DMYstring); // new sql connection for agency calculations
            agecalConn.Open();
          //SqlCommand agecalCommand = new SqlCommand("Select * from AGENCCALCS LEFT OUTER JOIN CALTYPES ON AGENCCALS.CTP_CODE = CALTYPES.CTP_CODE WHERE AGENCCALCS.AGE_CODE = @acCode GROUP BY AGENCALCS.AGE_CODE", agecalConn);
            SqlCommand agecalCommand = new SqlCommand("select * from FoxProDev.dbo.AGENCCALCS left outer join FoxProDev.dbo.CALTYPES on AGENCCALCS.CTP_CODE = CALTYPES.CTP_CODE where AGENCCALCS.AGE_CODE = @acCode ORDER BY AGENCCALCS.CTP_CODE, YEAR_FR ASC", agecalConn); //sql statment
            agecalCommand.Parameters.AddWithValue("acCode", agencycode.ToString()); //paramters

            SqlDataReader ACreader = agecalCommand.ExecuteReader(); //new sqlreader for agency calculations
            agecalGrid.DataSource = ACreader; //set the datasource
            agecalGrid.DataBind(); ///databine to grideview
            ACreader.Dispose(); agecalCommand.Dispose(); agecalConn.Close(); //end all readers, commands, connections

            SqlConnection fundConn = new SqlConnection(DMYstring); //new connection for the funding list
            fundConn.Open();

            SqlCommand fundCommand = new SqlCommand("SELECT * FROM FOXPRODEV.DBO.AGENFUNDS LEFT OUTER JOIN FOXPRODEV.DBO.FUNDTYPES ON AGENFUNDS.FTP_CODE = FUNDTYPES.FTP_CODE WHERE AGENFUNDS.AGE_CODE = @agencyCODE ORDER BY FUNDTYPES.FTP_CODE ASC", fundConn); //SQL SATEMENT FOR FUNDS
            fundCommand.Parameters.AddWithValue("agencyCODE", agencycode.ToString());//adds paramerters

            SqlDataReader fundReader = fundCommand.ExecuteReader(); // start the reader
            fundingGridView.DataSource= fundReader;
            fundingGridView.DataBind();


        }
    }
}