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
using System.Web.Security;

namespace ParksDev
{
    public partial class Payments : System.Web.UI.Page
    {
        public static int rowIndex = 0;

        public static int rowLimit = new int();

        public static int maintracode = new int();

        public static int agecoder = new int();

        public void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillOut();

            }
        }

        public void buttonClickNext(object sender, EventArgs e)
        {
            rowIndex++;
            rowIndexLab.Text = rowIndex.ToString();

            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
            newPanel.Visible = false;
            editPanel.Visible = false;
            viewPanel.Visible = true;
            ClearTextBoxes(grantsEntry1); //clear grants in case it was filled in from previous entry
            ClearTextBoxes(grantsEntr2);
            ClearTextBoxes(grantsEntr3);
            ClearTextBoxes(grantsEntr4);

            if (rowIndex <= rowLimit)
            {

                fillOut();                

             }
            else { rowIndex = rowLimit; }
        }

        public void buttonClickFirst(object sender, EventArgs e)
        {
            rowIndex = 0;//to the beginging

            fillOut();

            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
            newPanel.Visible = false;
            editPanel.Visible = false;
            viewPanel.Visible = true;
            ClearTextBoxes(grantsEntry1); //clear grants in case it was filled in from previous entry
            ClearTextBoxes(grantsEntr2);
            ClearTextBoxes(grantsEntr3);
            ClearTextBoxes(grantsEntr4);

        }

        public void buttonPrev(object sender, EventArgs e)
        {

            rowIndex--;

            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
            newPanel.Visible = false;
            editPanel.Visible = false;
            viewPanel.Visible = true;
            ClearTextBoxes(grantsEntry1); //clear grants in case it was filled in from previous entry
            ClearTextBoxes(grantsEntr2);
            ClearTextBoxes(grantsEntr3);
            ClearTextBoxes(grantsEntr4);

            rowIndexLab.Text = rowIndex.ToString();

            //grantsEntry1.Visible = false;
            //grantsEntr2.Visible = false;
            //grantsEntr3.Visible = false;
            //grantsEntr4.Visible = false;

            if (rowIndex >= 0) //make sure doesnt go past 0
            {

                fillOut();

            }
            else { rowIndex = 0; fillOut(); }
        }

        public void buttonlast(object sender, EventArgs e)
        {
            rowIndex = rowLimit;

            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
            newPanel.Visible = false;
            editPanel.Visible = false;
            viewPanel.Visible = true;
            ClearTextBoxes(grantsEntry1); //clear grants in case it was filled in from previous entry
            ClearTextBoxes(grantsEntr2);
            ClearTextBoxes(grantsEntr3);
            ClearTextBoxes(grantsEntr4);

            fillOut();

        }

        public void buttonedit(object sender, EventArgs e)
        {

            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
            newPanel.Visible = false;
            viewPanel.Visible = false;
            ClearTextBoxes(grantsEntry1); //clear grants in case it was filled in from previous entry
            ClearTextBoxes(grantsEntr2);
            ClearTextBoxes(grantsEntr3);
            ClearTextBoxes(grantsEntr4);

            rowIndexLab.Text = rowIndex.ToString();

            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection payConnection = new SqlConnection(connectionString);

            payConnection.Open();

            NumberFormatInfo nfi = new NumberFormatInfo();
            nfi.NumberNegativePattern = 0;

            if (ageFilter.Checked == true)
            {

                float filteragecode = float.Parse(AgencyViewScrolldown.SelectedValue.ToString());
                SqlCommand filtercommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[TRANSFERS] LEFT OUTER JOIN [FOXPRODEV].[dbo].[AGENCIES] on [TRANSFERS].[AGE_CODE] = [AGENCIES].[AGE_CODE] where [AGENCIES].[AGE_CODE] =  " + filteragecode + " order by  [TRANSFERS].[LUPD_DATE] asc", payConnection);
                SqlDataAdapter payAdapter = new SqlDataAdapter(filtercommand);


                DataTable payData = new DataTable(); // new datatable

                payAdapter.Fill(payData);

                //gona fill out all the text fields with values

                agecoder = int.Parse(payData.Rows[rowIndex]["AGE_CODE"].ToString());
                maintracode = int.Parse(payData.Rows[rowIndex]["TRA_CODE"].ToString());
                editTC.Text = payData.Rows[rowIndex]["TC"].ToString();
                editTD.Text = payData.Rows[rowIndex]["TD"].ToString();
                editMO.Text = payData.Rows[rowIndex]["MINOBJ"].ToString();
                editREF.Text = payData.Rows[rowIndex]["REFERENCE"].ToString();
                //reftest.Text = editREF.Text.ToString();
                editAGENCY.SelectedValue = payData.Rows[rowIndex]["AGE_CODE"].ToString(); //need to add agencies names to the sql statement
                //format dates
                DateTime preTranD = DateTime.Parse(payData.Rows[rowIndex]["TRANDATE"].ToString());
                editTRANSFERD.Text = preTranD.ToString("d");
                DateTime preProcD = DateTime.Parse(payData.Rows[rowIndex]["PROCESSED"].ToString());
                editPROCESSED.Text = preProcD.ToString("d");

                DropDownList1.SelectedValue = payData.Rows[rowIndex]["TTP_CODE"].ToString();
                editComments.Text = payData.Rows[rowIndex]["COMMENTS"].ToString();

                //getting the fiscal proccess year
                DateTime prodateTime = DateTime.Parse(payData.Rows[rowIndex]["PROCESSED"].ToString());

                editSubfund.Text = payData.Rows[rowIndex]["SUBFUND"].ToString();
                editloccode.Text = payData.Rows[rowIndex]["LOC_CODE"].ToString();
                editsupdist.Text = payData.Rows[rowIndex]["DIS_CODE"].ToString(); //add subfund, location data, and supporting district
                editpayreqnum.Text = payData.Rows[rowIndex]["PayReqNum"].ToString();
                vunitcode.Text = payData.Rows[rowIndex]["Unit_code"].ToString();
                editpayeedropdown.SelectedValue = payData.Rows[rowIndex]["payee"].ToString();
                editComments.Text = payData.Rows[rowIndex]["COMMENTS"].ToString();
                grantscontroler.Text = payData.Rows[rowIndex]["CON"].ToString(); //grant control number

                viewUser.Text = payData.Rows[rowIndex]["LUPD_USER"].ToString();
                DateTime viewdateDate = DateTime.Parse(payData.Rows[rowIndex]["LUPD_DATE"].ToString());
                viewDate.Text = viewdateDate.ToString("d");

                yearlabel.Text = prodateTime.ToString("yyyy"); //gets the year value
                int yearNumberInt = Convert.ToInt32(yearlabel.Text.ToString()); //turns year value into a number
                int proMonth = Convert.ToInt32(prodateTime.ToString("MM"));  //turns month into int value
                if (proMonth < 7) //check the fisical year for that date
                {
                    yearNumberInt = yearNumberInt - 1; //mark down the year if the month is less than july indicating previous fiscal year
                }
                fisYear.Text = yearNumberInt.ToString(); //gets the fiscal year

                string agecodeSelect = payData.Rows[rowIndex]["AGE_CODE"].ToString(); //gets agency code
                agecodeshow.Text = agecodeSelect.ToString();

                //use same connection strings?

                SqlCommand agenbalData = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENBALANCFY] where [AGE_CODE] = @ageCodeValue and [FY] = @fyYear", payConnection);
                agenbalData.Parameters.AddWithValue("ageCodeValue", agecodeSelect.ToString());//paramater for the sql statment to pull the agency code
                agenbalData.Parameters.AddWithValue("fyYear", yearNumberInt.ToString());//paramter for the fiscal year
                SqlDataAdapter agenbalAdapter = new SqlDataAdapter(agenbalData); //new sql adpater for agenbalfy
                DataTable agenbalTable = new DataTable(); //data table for the agenbal data
                agenbalAdapter.Fill(agenbalTable); //fill the datatable with the dataadapter 


                if (agenbalTable != null && agenbalTable.Rows.Count > 0)
                {
                    //populate the labels for fy collected.
                    editFCBA.Text = String.Format("${0:###,###.00}", float.Parse(agenbalTable.Rows[0]["AMT_BAS"].ToString())); //format to money
                    editPRA.Text = String.Format("${0:###,###.00}", float.Parse(agenbalTable.Rows[0]["YEG_BEG"].ToString()));
                    editPAY.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["TRA"].ToString()));
                    editAVG.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()));
                    //PRLabel.Text = payData.Rows[rowIndex]["YEG_BEG"].ToString();

                    //figuring out the restriction rate, first the remaining yeg
                    int yegTotal = Convert.ToInt32(agenbalTable.Rows[0]["YEG_TOT"]);
                    //Response.Write(Convert.ToInt32(agenbalTable.Rows[0]["YEG_TOT"]).ToString());
                    int yegBegin = Convert.ToInt32(agenbalTable.Rows[0]["YEG_BEG"]);
                    int yegRemains = yegTotal + yegBegin;
                    yegRemainer.Text = String.Format("${0:###,###.00}", float.Parse(yegRemains.ToString())); //first part of restriction rate

                    //get the second part of restriction rate
                    // use same connection
                    SqlCommand agencalc = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENCCALCS] where [AGE_CODE] = @agecodevalue and CTP_CODE between 2 and 3", payConnection);
                    agencalc.Parameters.AddWithValue("agecodevalue", agecodeSelect.ToString()); //gets the correct agecode
                    SqlDataAdapter agecalcAdapter = new SqlDataAdapter(agencalc);
                    DataTable agencalcTable = new DataTable();
                    agecalcAdapter.Fill(agencalcTable); //fills table

                    //test table

                    //Response.Write(agencalcTable.Rows[0]["FY_EST"].ToString());
                    //Response.Write(agencalcTable.Rows[1]["FY_EST"].ToString());


                    //get the values for remaining MS
                    int firstMS = Convert.ToInt32(agencalcTable.Rows[0]["FY_EST"]);

                    //Response.Write(firstMS.ToString());

                    ms1.Text = agencalcTable.Rows[0]["FY_EST"].ToString();

                    int secondMS = Convert.ToInt32(agencalcTable.Rows[1]["FY_EST"]);
                    ms2.Text = secondMS.ToString(); //debug it works damnit.

                    int firstMS1 = firstMS * 18;

                    //Response.Write("first" + firstMS1.ToString() + "\n");

                    int secondMS1 = secondMS * 4;

                    //Response.Write("second" + secondMS1.ToString() + "\n"); //works so far

                    int finalMS = firstMS1 + secondMS1;

                    //Response.Write("added" + finalMS.ToString() + "\n");

                    //add the remaining yeg and remaining ms
                    float yegFloat = (float)yegRemains;
                    float msFloat = (float)finalMS;


                    //Response.Write("yegfloat:" + yegFloat.ToString() + "\n");
                    //Response.Write("msfloat:" + msFloat.ToString() + "\n");

                    float restrictionRate = (yegFloat / msFloat) * 100;

                    ResLabel.Text = String.Format("{0}%", restrictionRate.ToString()); //works for when you get to index 63

                    //try to get current fy restrictions
                    float floatAmtBas = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BAS"]);
                    float currentFyRestriction = (restrictionRate * floatAmtBas) / 100;
                    editCFR.Text = String.Format("${0:###,###.00}", float.Parse(currentFyRestriction.ToString()));

                    //total restricted amount
                    float totalRestricted = currentFyRestriction + (float)yegBegin;
                    editTRA.Text = String.Format("${0:###,###.00}", float.Parse(totalRestricted.ToString()));

                    //total fund
                    float floatAmtBeg = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BEG"]);
                    //float floatAmtBas = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BAS"]);//used already
                    float floatAmtInt = Convert.ToInt64(agenbalTable.Rows[0]["AMT_INT"]);
                    float floatTotalFund = floatAmtBeg + floatAmtBas + floatAmtInt;
                    editTF.Text = String.Format("${0:###,###.00}", float.Parse(floatTotalFund.ToString()));

                    //unrestristed amount
                    float unrestictedAmount = floatTotalFund - totalRestricted;
                    editUF.Text = String.Format("${0:###,###.00}", float.Parse(unrestictedAmount.ToString()));
                    agencalc.Dispose();
                    agencalcTable.Dispose();
                    agecalcAdapter.Dispose();
                }
                else
                {
                    editPAY.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["TRA"].ToString()));
                    editAVG.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()));
                    editFCBA.Text = "No date available to retrive data";
                    editPRA.Text = "No date available to retrive data";
                    //editPAY.Text = "No date available to retrive data";
                    //editAVG.Text = "No date available to retrive data";
                    yegRemainer.Text = "No date available to retrive data";
                    ms1.Text = "No date available to retrive data";
                    ms2.Text = "No date available to retrive data";
                    ResLabel.Text = "No date available to retrive data";
                    editCFR.Text = "No date available to retrive data";
                    editTRA.Text = "No date available to retrive data";
                    editTF.Text = "No date available to retrive data";
                    editUF.Text = "No date available to retrive data";
                }

                //get rid of everything just now, working backwards
                payAdapter.Dispose();
                payData.Dispose();
                //payCommand.Dispose();
                payConnection.Close();
                agenbalData.Dispose();
                agenbalAdapter.Dispose();
                agenbalTable.Dispose();


                editPanel.Visible = true;
                viewPanel.Visible = false;
                newPanel.Visible = false;
                grantsEntry1.Visible = false;
            }
            else {
                SqlCommand payCommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[TRANSFERS] LEFT OUTER JOIN [FOXPRODEV].[dbo].[AGENCIES] on [TRANSFERS].[AGE_CODE] = [AGENCIES].[AGE_CODE] order by [TRANSFERS].[LUPD_DATE] asc", payConnection);

                SqlDataAdapter payAdapter = new SqlDataAdapter(payCommand); //new sql adapter

                DataTable payData = new DataTable(); // new datatable

                payAdapter.Fill(payData);

                //gona fill out all the text fields with values

                agecoder = int.Parse(payData.Rows[rowIndex]["AGE_CODE"].ToString());
                maintracode = int.Parse(payData.Rows[rowIndex]["TRA_CODE"].ToString());
                editTC.Text = payData.Rows[rowIndex]["TC"].ToString();
                editTD.Text = payData.Rows[rowIndex]["TD"].ToString();
                editMO.Text = payData.Rows[rowIndex]["MINOBJ"].ToString();
                editREF.Text = payData.Rows[rowIndex]["REFERENCE"].ToString();
                //reftest.Text = editREF.Text.ToString();
                editAGENCY.SelectedValue = payData.Rows[rowIndex]["AGE_CODE"].ToString(); //need to add agencies names to the sql statement
                //format dates
                DateTime preTranD = DateTime.Parse(payData.Rows[rowIndex]["TRANDATE"].ToString());
                editTRANSFERD.Text = preTranD.ToString("d");
                DateTime preProcD = DateTime.Parse(payData.Rows[rowIndex]["PROCESSED"].ToString());
                editPROCESSED.Text = preProcD.ToString("d");

                DropDownList1.SelectedValue = payData.Rows[rowIndex]["TTP_CODE"].ToString();
                editComments.Text = payData.Rows[rowIndex]["COMMENTS"].ToString();

                //getting the fiscal proccess year
                DateTime prodateTime = DateTime.Parse(payData.Rows[rowIndex]["PROCESSED"].ToString());

                editSubfund.Text = payData.Rows[rowIndex]["SUBFUND"].ToString();
                editloccode.Text = payData.Rows[rowIndex]["LOC_CODE"].ToString();
                editsupdist.Text = payData.Rows[rowIndex]["DIS_CODE"].ToString(); //add subfund, location data, and supporting district
                editpayreqnum.Text = payData.Rows[rowIndex]["PayReqNum"].ToString();
                vunitcode.Text = payData.Rows[rowIndex]["Unit_code"].ToString();
                editpayeedropdown.SelectedValue = payData.Rows[rowIndex]["payee"].ToString();
                editComments.Text = payData.Rows[rowIndex]["COMMENTS"].ToString();
                grantscontroler.Text = payData.Rows[rowIndex]["CON"].ToString(); //grant control number

                viewUser.Text = payData.Rows[rowIndex]["LUPD_USER"].ToString();
                DateTime viewdateDate = DateTime.Parse(payData.Rows[rowIndex]["LUPD_DATE"].ToString());
                viewDate.Text = viewdateDate.ToString("d");

                yearlabel.Text = prodateTime.ToString("yyyy"); //gets the year value
                int yearNumberInt = Convert.ToInt32(yearlabel.Text.ToString()); //turns year value into a number
                int proMonth = Convert.ToInt32(prodateTime.ToString("MM"));  //turns month into int value
                if (proMonth < 7) //check the fisical year for that date
                {
                    yearNumberInt = yearNumberInt - 1; //mark down the year if the month is less than july indicating previous fiscal year
                }
                fisYear.Text = yearNumberInt.ToString(); //gets the fiscal year

                string agecodeSelect = payData.Rows[rowIndex]["AGE_CODE"].ToString(); //gets agency code
                agecodeshow.Text = agecodeSelect.ToString();

                //use same connection strings?

                SqlCommand agenbalData = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENBALANCFY] where [AGE_CODE] = @ageCodeValue and [FY] = @fyYear", payConnection);
                agenbalData.Parameters.AddWithValue("ageCodeValue", agecodeSelect.ToString());//paramater for the sql statment to pull the agency code
                agenbalData.Parameters.AddWithValue("fyYear", yearNumberInt.ToString());//paramter for the fiscal year
                SqlDataAdapter agenbalAdapter = new SqlDataAdapter(agenbalData); //new sql adpater for agenbalfy
                DataTable agenbalTable = new DataTable(); //data table for the agenbal data
                agenbalAdapter.Fill(agenbalTable); //fill the datatable with the dataadapter 

                if (agenbalTable != null && agenbalTable.Rows.Count > 0)
                {
                    //populate the labels for fy collected.
                    editFCBA.Text = String.Format("${0:###,###.00}", float.Parse(agenbalTable.Rows[0]["AMT_BAS"].ToString())); //format to money
                    editPRA.Text = String.Format("${0:###,###.00}", float.Parse(agenbalTable.Rows[0]["YEG_BEG"].ToString()));
                    editPAY.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["TRA"].ToString()));
                    editAVG.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()));
                    //PRLabel.Text = payData.Rows[rowIndex]["YEG_BEG"].ToString();

                    //figuring out the restriction rate, first the remaining yeg
                    int yegTotal = Convert.ToInt32(agenbalTable.Rows[0]["YEG_TOT"]);
                    //Response.Write(Convert.ToInt32(agenbalTable.Rows[0]["YEG_TOT"]).ToString());
                    int yegBegin = Convert.ToInt32(agenbalTable.Rows[0]["YEG_BEG"]);
                    int yegRemains = yegTotal + yegBegin;
                    yegRemainer.Text = String.Format("${0:###,###.00}", float.Parse(yegRemains.ToString())); //first part of restriction rate

                    //get the second part of restriction rate
                    // use same connection
                    SqlCommand agencalc = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENCCALCS] where [AGE_CODE] = @agecodevalue and CTP_CODE between 2 and 3", payConnection);
                    agencalc.Parameters.AddWithValue("agecodevalue", agecodeSelect.ToString()); //gets the correct agecode
                    SqlDataAdapter agecalcAdapter = new SqlDataAdapter(agencalc);
                    DataTable agencalcTable = new DataTable();
                    agecalcAdapter.Fill(agencalcTable); //fills table

                    //test table

                    //Response.Write(agencalcTable.Rows[0]["FY_EST"].ToString());
                    //Response.Write(agencalcTable.Rows[1]["FY_EST"].ToString());


                    //get the values for remaining MS
                    int firstMS = Convert.ToInt32(agencalcTable.Rows[0]["FY_EST"]);

                    //Response.Write(firstMS.ToString());

                    ms1.Text = agencalcTable.Rows[0]["FY_EST"].ToString();

                    int secondMS = Convert.ToInt32(agencalcTable.Rows[1]["FY_EST"]);
                    ms2.Text = secondMS.ToString(); //debug it works damnit.

                    int firstMS1 = firstMS * 18;

                    //Response.Write("first" + firstMS1.ToString() + "\n");

                    int secondMS1 = secondMS * 4;

                    //Response.Write("second" + secondMS1.ToString() + "\n"); //works so far

                    int finalMS = firstMS1 + secondMS1;

                    //Response.Write("added" + finalMS.ToString() + "\n");

                    //add the remaining yeg and remaining ms
                    float yegFloat = (float)yegRemains;
                    float msFloat = (float)finalMS;


                    //Response.Write("yegfloat:" + yegFloat.ToString() + "\n");
                    //Response.Write("msfloat:" + msFloat.ToString() + "\n");

                    float restrictionRate = (yegFloat / msFloat) * 100;

                    ResLabel.Text = String.Format("{0}%", restrictionRate.ToString()); //works for when you get to index 63

                    //try to get current fy restrictions
                    float floatAmtBas = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BAS"]);
                    float currentFyRestriction = (restrictionRate * floatAmtBas) / 100;
                    editCFR.Text = String.Format("${0:###,###.00}", float.Parse(currentFyRestriction.ToString()));

                    //total restricted amount
                    float totalRestricted = currentFyRestriction + (float)yegBegin;
                    editTRA.Text = String.Format("${0:###,###.00}", float.Parse(totalRestricted.ToString()));

                    //total fund
                    float floatAmtBeg = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BEG"]);
                    //float floatAmtBas = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BAS"]);//used already
                    float floatAmtInt = Convert.ToInt64(agenbalTable.Rows[0]["AMT_INT"]);
                    float floatTotalFund = floatAmtBeg + floatAmtBas + floatAmtInt;
                    editTF.Text = String.Format("${0:###,###.00}", float.Parse(floatTotalFund.ToString()));

                    //unrestristed amount
                    float unrestictedAmount = floatTotalFund - totalRestricted;
                    editUF.Text = String.Format("${0:###,###.00}", float.Parse(unrestictedAmount.ToString()));

                    agencalc.Dispose();
                    agencalcTable.Dispose();
                    agecalcAdapter.Dispose();
                }
                else
                {
                    editPAY.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["TRA"].ToString()));
                    editAVG.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()));
                    editFCBA.Text = "No date available to retrive data";
                    editPRA.Text = "No date available to retrive data";
                    //editPAY.Text = "No date available to retrive data";
                    //editAVG.Text = "No date available to retrive data";
                    yegRemainer.Text = "No date available to retrive data";
                    ms1.Text = "No date available to retrive data";
                    ms2.Text = "No date available to retrive data";
                    ResLabel.Text = "No date available to retrive data";
                    editCFR.Text = "No date available to retrive data";
                    editTRA.Text = "No date available to retrive data";
                    editTF.Text = "No date available to retrive data";
                    editUF.Text = "No date available to retrive data";
                }

                
                //get rid of everything just now, working backwards
                payAdapter.Dispose();
                payData.Dispose();
                payCommand.Dispose();
                payConnection.Close();
                agenbalData.Dispose();
                agenbalAdapter.Dispose();
                agenbalTable.Dispose();


                editPanel.Visible = true;
                viewPanel.Visible = false;
                newPanel.Visible = false;
                grantsEntry1.Visible = false;
            }

          // User reqeust text fields display only
            editPAY.Enabled = false;
            editAVG.Enabled = false;
            editPRA.Enabled = false;
            editRR.Enabled = false;
            editFCBA.Enabled = false;
            editCFR.Enabled = false;
            editTRA.Enabled = false;
            editTF.Enabled = false;
            editUF.Enabled = false;


          // click on the Enter Grants Button per user Reqeust 

            grantsEntry1.Visible = true;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
            //editgrantcmd();
            editgrantcmd(sender, e);
        }

        public void buttoneditcancel(object sender, EventArgs e)
        {
            editPanel.Visible = false;
            viewPanel.Visible = true;
            newPanel.Visible = false;
            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
        }
        public void buttonnewcancel(object sender, EventArgs e)
        {
            newPanel.Visible = false;
            editPanel.Visible = false;
            viewPanel.Visible = true;
            grantsEntry1.Visible = false;
  
        }
        public void buttonnewclicked(object sender, EventArgs e) 
        {
            ClearTextBoxes(grantsEntry1); //clear grants in case it was filled in from previous entry
            ClearTextBoxes(grantsEntr2);
            ClearTextBoxes(grantsEntr3);
            ClearTextBoxes(grantsEntr4);
            ClearTextBoxes(newPanel);
            Label4.Text = "HB3";

            newPanel.Visible = true;
            editPanel.Visible = false;
            viewPanel.Visible = false;
            grantsEntry1.Visible = false;
            NewEnteredDate.Text = DateTime.Now.ToShortDateString();
            firstAgency();

        }
        public void buttongrantsclicked(object sender, EventArgs e)
        {
            grantsEntry1.Visible = true;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;

        }
        public void grantscancel(object sender, EventArgs e)
        {
            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
        }
        public void grantsdone1click(object sender, EventArgs e)
        {
            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
        }
        public void next1click(object sender, EventArgs e)
        {
            grantsEntry1.Visible = false;
            grantsEntr2.Visible = true;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
        }
        public void next2click(object sender, EventArgs e)
        {
            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = true;
            grantsEntr4.Visible = false;
        }
        public void next3click(object sender, EventArgs e)
        {
            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = true;
        }
        public void prev2click(object sender, EventArgs e)
        {
            grantsEntry1.Visible = true;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;
        }

        public void editsaveclick(object sender, EventArgs e)
        {
            string editstring = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

            SqlConnection edittranconn = new SqlConnection(editstring);
            edittranconn.Open();

            SqlCommand editcomm = new SqlCommand("editTransfers", edittranconn);
            editcomm.CommandType = CommandType.StoredProcedure;

            editcomm.Parameters.Add("@age_code", SqlDbType.NVarChar).Value = editAGENCY.SelectedValue;
            editcomm.Parameters.Add("@tra_code", SqlDbType.Float).Value = float.Parse(maintracode.ToString());
            editcomm.Parameters.Add("@ttp_code", SqlDbType.Float).Value = DropDownList1.SelectedValue;
            //editcomm.Parameters.Add("@age_code", SqlDbType.Float).Value = float.Parse(agecoder.ToString());
            editcomm.Parameters.Add("@minobj", SqlDbType.NVarChar).Value = editMO.Text.ToString();
            editcomm.Parameters.Add("@tc", SqlDbType.NVarChar).Value = editTC.Text.ToString();
            editcomm.Parameters.Add("@td", SqlDbType.NVarChar).Value = editTD.Text.ToString();
            editcomm.Parameters.Add("@reference", SqlDbType.NVarChar).Value = editREF.Text.ToString();
            string proTemp = editPROCESSED.Text.ToString();
            string traTemp = editTRANSFERD.Text.ToString();
            editcomm.Parameters.Add("@processed", SqlDbType.DateTime).Value = DateTime.Parse(proTemp.ToString());
            editcomm.Parameters.Add("@trandate", SqlDbType.DateTime).Value = DateTime.Parse(traTemp.ToString());
            editcomm.Parameters.Add("@tra", SqlDbType.Float).Value = double.Parse(editPAY.Text.ToString(), NumberStyles.Currency);
            //string testnum = editAVG.Text.ToString();
            //double numbersz;
            //if (double.TryParse(testnum, NumberStyles.Currency, CultureInfo.InvariantCulture, out numbersz))
            //{
                editcomm.Parameters.Add("@average", SqlDbType.Float).Value = double.Parse(editAVG.Text.ToString(), NumberStyles.Currency);
            //}
            //else
            //{ 
            //editcomm.Parameters.Add("@average", SqlDbType.Float).Value = 0;
            //}
            editcomm.Parameters.Add("@comments", SqlDbType.NVarChar).Value = editComments.Text.ToString(); //comments
            editcomm.Parameters.Add("@lupd_user", SqlDbType.NVarChar).Value = User.Identity.Name.ToString();

            editcomm.Parameters.Add("@supdist", SqlDbType.NVarChar).Value = editsupdist.Text.ToString();
            editcomm.Parameters.Add("@payreqnum", SqlDbType.NVarChar).Value = editpayreqnum.Text.ToString();
            editcomm.Parameters.Add("@payee", SqlDbType.NVarChar).Value = editpayeedropdown.SelectedValue;
            editcomm.Parameters.Add("@loccode", SqlDbType.NVarChar).Value = editloccode.Text.ToString();

                    //try
                    //{
                    //    int editcount = editcomm.ExecuteNonQuery();
                    //    if (editcount > 0)
                    //    {
                    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "savededit();", true);
                    //    }
                    //    else
                    //    {
                    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "editfailed();", true);
                    //    }
                    //}
                    //catch (SqlException ex)
                    //{
                    //    Console.WriteLine("Update Failed coz.. " + ex.Message);
                    //}
            int editcount = editcomm.ExecuteNonQuery();
            if (editcount > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "savededit();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "faileddiao();", true);
            }

            editcomm.Dispose();
            edittranconn.Close();

            string addString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection addconn = new SqlConnection(addString);
            addconn.Open();

            for (int i = 1; i < 41; i++)
            {
                SqlCommand editgrants = new SqlCommand("editGrants", addconn);
                editgrants.CommandType = CommandType.StoredProcedure; //for grants

                TextBox txtba = (TextBox)this.grantsEntry1.FindControl("gn" + i); //grants number
                if (!String.IsNullOrWhiteSpace(txtba.Text))
                {
                    TextBox txtbb = (TextBox)this.grantsEntry1.FindControl("gf" + i); //grants to
                    TextBox txtbc = (TextBox)this.grantsEntry1.FindControl("gt" + i); // grants from
                    TextBox txtbd = (TextBox)this.grantsEntry1.FindControl("ga" + i); // grants amount
                    TextBox txtbe = (TextBox)this.grantsEntry1.FindControl("glc" + i); // grants location code
                    TextBox txtbf = (TextBox)this.grantsEntry1.FindControl("gsd" + i); //support district
                    TextBox txtbg = (TextBox)this.grantsEntry1.FindControl("goc" + i); //object code
                    CheckBox txtbh = (CheckBox)this.grantsEntry1.FindControl("geo" + i); //extra ordinary

                    editgrants.Parameters.Add("@con", SqlDbType.NVarChar).Value = grantscontroler.Text.ToString(); //grant controller number
                    editgrants.Parameters.Add("@grant_num", SqlDbType.NVarChar).Value = txtba.Text.ToString();
                    editgrants.Parameters.Add("@amount", SqlDbType.Float).Value = float.Parse(txtbd.Text.ToString().Replace("$", String.Empty));
                    editgrants.Parameters.Add("@period_from", SqlDbType.DateTime).Value = Convert.ToDateTime(txtbb.Text.ToString());
                    editgrants.Parameters.Add("@period_to", SqlDbType.DateTime).Value = Convert.ToDateTime(txtbc.Text.ToString());
                    editgrants.Parameters.Add("@loccode", SqlDbType.NVarChar).Value = txtbe.Text.ToString();
                    editgrants.Parameters.Add("@supdist", SqlDbType.NVarChar).Value = txtbf.Text.ToString();
                    editgrants.Parameters.Add("@objcode", SqlDbType.NVarChar).Value = txtbg.Text.ToString();
                    if (txtbh.Checked == true)
                    {
                        editgrants.Parameters.Add("@eo", SqlDbType.NVarChar).Value = "1";
                    }
                    else
                    {
                        editgrants.Parameters.Add("@eo", SqlDbType.NVarChar).Value = "0";
                    }
                    editgrants.Parameters.Add("@con2", SqlDbType.NVarChar).Value = i.ToString(); //grants controler controler

                    editgrants.ExecuteNonQuery();
                    editgrants.Dispose();
                }
            }//looper!

            editPanel.Visible = false;
            viewPanel.Visible = true;
            newPanel.Visible = false;

            //close all grant entry screens
            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;

            //update view panel
            payeeViewScrollDown.SelectedValue = editpayeedropdown.SelectedValue;
            viewComments.Text = editComments.Text;
            viewPaymentReq.Text = editpayreqnum.Text;
            AgencyViewScrolldown.SelectedValue = editAGENCY.SelectedValue;

        }

        public void newsaveclick(object sender, EventArgs e)
        {

            grantsEntry1.Visible = false;
            grantsEntr2.Visible = false;
            grantsEntr3.Visible = false;
            grantsEntr4.Visible = false;

            string addString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
    
            //another sql connect to get average
            SqlConnection avgconn = new SqlConnection(addString);
            avgconn.Open();
            string getavgage = DropDownList2.SelectedValue.ToString(); //gets agecode
            SqlCommand getavg = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[transaverage] where [AGE_CODE] = @agecodes", avgconn);
            getavg.Parameters.Add("@agecodes", SqlDbType.Float).Value = float.Parse(getavgage.ToString());

            SqlDataAdapter avgad = new SqlDataAdapter(getavg);
            DataTable theavg = new DataTable();
            avgad.Fill(theavg);//filled
            string thisisavg;
            thisisavg = theavg.Rows[0]["average"].ToString();
            double thisavgnum = double.Parse(thisisavg.ToString());
            double thisisagain = double.Parse(thisavgnum.ToString("G7", CultureInfo.InvariantCulture));

            //get list of possible con(trol) values from transfers
            SqlCommand getTranCon = new SqlCommand("SELECT [CON] FROM [FOXPRODEV].[dbo].[TRANSFERS]", avgconn);
            SqlDataAdapter adapterTran = new SqlDataAdapter(getTranCon);
            DataTable tranTable = new DataTable();
            adapterTran.Fill(tranTable);



            bool nextrnd = true;
            string sb = "1"; //must decalre some sort of value.
            while (nextrnd)
            {
                //create randomized control number for grants
                Random ppp = new Random();
                string pprcontemp = ppp.Next(1, 1000000000).ToString(); // new random number hopefully for grants control number

                string consearch = "CON = " + pprcontemp; 
                DataRow[] foundcontrols;
                foundcontrols = tranTable.Select(consearch);

                if (foundcontrols.Length > 0)
                {
                    nextrnd = true;
                }
                else
                {
                    nextrnd = false;
                    sb = pprcontemp;
                }
            }

   
           

            avgconn.Close();

            //create randomized control number for grants
            //Random ppp = new Random();
            //string pprcon = ppp.Next(1, 1000000000).ToString(); // new random number hopefully for grants control number



 
            SqlConnection addconn = new SqlConnection(addString);
            addconn.Open();

            SqlCommand addcomm = new SqlCommand("addTransfer", addconn);
            addcomm.CommandType = CommandType.StoredProcedure;


            DateTime blankdate = DateTime.Parse("1 / 1 / 1900");
            addcomm.Parameters.Add("@ttp_code", SqlDbType.Float).Value = DropDownList3.SelectedValue;
            addcomm.Parameters.Add("@age_code", SqlDbType.Float).Value = DropDownList2.SelectedValue;
            addcomm.Parameters.Add("minobj", SqlDbType.NVarChar).Value = TextBox3.Text.ToString();
            string testtc = TC_Dropdown.Text.ToString();
            if (testtc == "") {addcomm.Parameters.Add("@tc", SqlDbType.NVarChar).Value = "None Entered";}
            else { addcomm.Parameters.Add("@tc", SqlDbType.NVarChar).Value = TC_Dropdown.Text.ToString();}//tc
            string testtd = TextBox2.Text.ToString();
            if (testtd == "") { addcomm.Parameters.Add("@td", SqlDbType.NVarChar).Value = "None Entered"; }
            else { addcomm.Parameters.Add("@td", SqlDbType.NVarChar).Value = TextBox2.Text.ToString(); } //td
            string testdocument = TextBox4.Text.ToString();
            if (testdocument == "") { addcomm.Parameters.Add("@reference", SqlDbType.NVarChar).Value = "None Entered"; }
            else { addcomm.Parameters.Add("@reference", SqlDbType.NVarChar).Value = TextBox4.Text.ToString(); } //document #
            addcomm.Parameters.Add("@tra", SqlDbType.Float).Value = float.Parse(TextBox5.Text.ToString().Replace("$", String.Empty));
            string testprocessed = TextBox6.Text.ToString();
            if (testprocessed == "")
            {
                addcomm.Parameters.Add("@processed", SqlDbType.DateTime).Value = blankdate;
            }
            else
            {
                addcomm.Parameters.Add("@processed", SqlDbType.DateTime).Value = Convert.ToDateTime(TextBox6.Text.ToString());
            }
            string testtransdate = TextBox7.Text.ToString();
            if (testtransdate == "")
            {
                addcomm.Parameters.Add("@trandate", SqlDbType.DateTime).Value = blankdate;
            }
            else
            {
                addcomm.Parameters.Add("@trandate", SqlDbType.DateTime).Value = Convert.ToDateTime(TextBox7.Text.ToString());
            }

            //addcomm.Parameters.Add("@processed", SqlDbType.DateTime).Value = Convert.ToDateTime(TextBox6.Text.ToString());
            //addcomm.Parameters.Add("@trandate", SqlDbType.DateTime).Value =  Convert.ToDateTime(TextBox7.Text.ToString());
            addcomm.Parameters.Add("@average", SqlDbType.Float).Value = thisisagain.ToString();
            addcomm.Parameters.Add("@comments", SqlDbType.NVarChar).Value =  newComments.Text.ToString();
            addcomm.Parameters.Add("@lupd_user", SqlDbType.NVarChar).Value = User.Identity.Name.ToString();
            addcomm.Parameters.Add("@con", SqlDbType.NVarChar).Value = sb.ToString(); //grants control number
            addcomm.Parameters.Add("@supdist", SqlDbType.NVarChar).Value = newsupdist.Text.ToString();

            string testpayment = newpayrequestno.Text.ToString();
            if (testpayment == "") { addcomm.Parameters.Add("@payreqnum", SqlDbType.NVarChar).Value = "None Entered"; }
            else { addcomm.Parameters.Add("@payreqnum", SqlDbType.NVarChar).Value = newpayrequestno.Text.ToString(); } //payment request number

            addcomm.Parameters.Add("@payee", SqlDbType.NVarChar).Value = newpayee.SelectedValue;
            addcomm.Parameters.Add("@loccode", SqlDbType.NVarChar).Value = newLocCode.Text.ToString();

            for (int i = 1; i < 41; i++)
            {
                SqlCommand addnewgrants = new SqlCommand("addGrants", addconn);
                addnewgrants.CommandType = CommandType.StoredProcedure; //for grants

                TextBox txtba = (TextBox)this.grantsEntry1.FindControl("gn" + i); //grants number
                if (txtba.Text != "")
                {
                    TextBox txtbb = (TextBox)this.grantsEntry1.FindControl("gf" + i); //grants to
                    TextBox txtbc = (TextBox)this.grantsEntry1.FindControl("gt" + i); // grants from
                     TextBox txtbd = (TextBox)this.grantsEntry1.FindControl("ga" + i); // grants amount
                    TextBox txtbe = (TextBox)this.grantsEntry1.FindControl("glc" + i); // grants location code
                    TextBox txtbf = (TextBox)this.grantsEntry1.FindControl("gsd" + i); //support district
                    TextBox txtbg = (TextBox)this.grantsEntry1.FindControl("goc" + i); //object code
                    CheckBox txtbh = (CheckBox)this.grantsEntry1.FindControl("geo" + i); //extra ordinary

                    addnewgrants.Parameters.Add("@con", SqlDbType.NVarChar).Value = sb;
                    addnewgrants.Parameters.Add("@con2", SqlDbType.NVarChar).Value = i.ToString();
                    addnewgrants.Parameters.Add("@grant_num", SqlDbType.NVarChar).Value = txtba.Text.ToString();
                    addnewgrants.Parameters.Add("@amount", SqlDbType.Float).Value = float.Parse(txtbd.Text.ToString());
                    addnewgrants.Parameters.Add("@period_from", SqlDbType.DateTime).Value = Convert.ToDateTime(txtbb.Text.ToString());
                    addnewgrants.Parameters.Add("@period_to", SqlDbType.DateTime).Value = Convert.ToDateTime(txtbc.Text.ToString());
                    addnewgrants.Parameters.Add("@locode", SqlDbType.NVarChar).Value = txtbe.Text.ToString();
                    addnewgrants.Parameters.Add("@supdist", SqlDbType.NVarChar).Value = txtbf.Text.ToString();
                    addnewgrants.Parameters.Add("@objcode", SqlDbType.NVarChar).Value = txtbg.Text.ToString();
                    if (txtbh.Checked == true)
                    {
                        addnewgrants.Parameters.Add("@eo", SqlDbType.NVarChar).Value = "1";
                    }
                    else
                    {
                        addnewgrants.Parameters.Add("@eo", SqlDbType.NVarChar).Value = "0";
                    }
                    //addnewgrants.Parameters.Add("@eo", SqlDbType.Int).Value = txtbh.Text.ToString();

                    addnewgrants.ExecuteNonQuery();
                }

                addnewgrants.Dispose();
            }//looper!
            try
                {
                    int suscount = addcomm.ExecuteNonQuery();
                    if(suscount > 0 )
                        {
                            savedagencyname.Text = DropDownList2.SelectedItem.ToString();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "saveddiao();", true);
                        }
                     else
                        {
                            //failedsave.Text = DropDownList2.SelectedItem.ToString();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "faileddiao();", true);
                        }
                 }
           catch (SqlException ex)
             {
                Console.WriteLine("Update Failed coz.. " + ex.Message);
             }
           finally{
                addconn.Close(); //works.

                newPanel.Visible = false;
                editPanel.Visible = false;
                viewPanel.Visible = true;
        
                  } 
        }

        public void newagencychange(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection payConnection = new SqlConnection(connectionString);

            payConnection.Open();

            string getavgage = DropDownList2.SelectedValue.ToString(); //gets agecode
            newpayee.SelectedValue = getavgage;
            SqlCommand payCommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENCIES] WHERE [AGE_CODE]= @agecodes", payConnection);
            payCommand.Parameters.Add("@agecodes", SqlDbType.Float).Value = float.Parse(getavgage.ToString());


            SqlDataAdapter payAdapter = new SqlDataAdapter(payCommand); //new sql adapter

            DataTable payData = new DataTable(); // new datatable

            payAdapter.Fill(payData);

            //gona fill out all the text fields with values


            for (int i = 1; i < 41; i++)
            {
                TextBox txtb = (TextBox)this.grantsEntry1.FindControl("glc" + i);

                txtb.Text = payData.Rows[0]["LOC_CODE"].ToString();

                TextBox txtb2 = (TextBox)this.grantsEntry1.FindControl("gsd" + i);

                txtb2.Text = payData.Rows[0]["SUPDIST"].ToString();

                TextBox txtb3 = (TextBox)this.grantsEntry1.FindControl("goc" + i);

                txtb3.Text = payData.Rows[0]["DEPTOBJ"].ToString();

            }
            textboxt.Text = getavgage;
            TextBox80.Text = payData.Rows[0]["SUBFUND"].ToString();
            newLocCode.Text = payData.Rows[0]["LOC_CODE"].ToString();
            newsupdist.Text = payData.Rows[0]["SUPDIST"].ToString();
            TextBox3.Text = payData.Rows[0]["DEPTOBJ"].ToString();
            NewUnit.Text = payData.Rows[0]["Unit_code"].ToString();

            //get rid of everything just now, working backwards
            payAdapter.Dispose();
            payData.Dispose();
            //payCommand.Dispose();
            payConnection.Close();

        }
        public void editAgencyChange(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection payConnection = new SqlConnection(connectionString);

            payConnection.Open();

            string getavgage = editAGENCY.SelectedValue.ToString(); //gets agecode
            editpayeedropdown.SelectedValue = getavgage;
            SqlCommand payCommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENCIES] WHERE [AGE_CODE]= @agecodes", payConnection);
            payCommand.Parameters.Add("@agecodes", SqlDbType.Float).Value = float.Parse(getavgage.ToString());


            SqlDataAdapter payAdapter = new SqlDataAdapter(payCommand); //new sql adapter

            DataTable payData = new DataTable(); // new datatable

            payAdapter.Fill(payData);

            //gona fill out all the text fields with values


            for (int i = 1; i < 41; i++)
            {
                TextBox txtb = (TextBox)this.grantsEntry1.FindControl("glc" + i);

                txtb.Text = payData.Rows[0]["LOC_CODE"].ToString();

                TextBox txtb2 = (TextBox)this.grantsEntry1.FindControl("gsd" + i);

                txtb2.Text = payData.Rows[0]["SUPDIST"].ToString();

                TextBox txtb3 = (TextBox)this.grantsEntry1.FindControl("goc" + i);

                txtb3.Text = payData.Rows[0]["DEPTOBJ"].ToString();

            }//this is ok every page uses the same grant entry form
            //textboxt.Text = getavgage; //??
            editSubfund.Text = payData.Rows[0]["SUBFUND"].ToString();
            editloccode.Text = payData.Rows[0]["LOC_CODE"].ToString();
            editsupdist.Text = payData.Rows[0]["SUPDIST"].ToString();
            editMO.Text = payData.Rows[0]["DEPTOBJ"].ToString();
            //NewUnit.Text = payData.Rows[0]["Unit_code"].ToString();

            //get rid of everything just now, working backwards
            payAdapter.Dispose();
            payData.Dispose();
            //payCommand.Dispose();
            payConnection.Close();

        }
        public void popdate(object sender, EventArgs e)
        {
           
        }
        public void editgrantcmd(object sender, EventArgs e)
        {
            rowIndexLab.Text = rowIndex.ToString();


            //need condition for if grants dont exist yet

            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection payConnection = new SqlConnection(connectionString);

            payConnection.Open();

            SqlCommand payCommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[TRANSFERS] LEFT OUTER JOIN [FOXPRODEV].[dbo].[AGENCIES] on [TRANSFERS].[AGE_CODE] = [AGENCIES].[AGE_CODE] order by [TRANSFERS].[LUPD_DATE] asc", payConnection);

            SqlDataAdapter payAdapter = new SqlDataAdapter(payCommand); //new sql adapter

            DataTable payData = new DataTable(); // new datatable

            payAdapter.Fill(payData);

            string grantcon = payData.Rows[rowIndex]["CON"].ToString();  //get grant control number "con"

            SqlCommand grantcommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[Grants] WHERE [CON] = @concode", payConnection);
            grantcommand.Parameters.AddWithValue("@concode", grantcon.ToString());
            SqlDataAdapter grantadpt = new SqlDataAdapter(grantcommand);
            DataTable grantdata = new DataTable();

            grantadpt.Fill(grantdata);

            int grantrowamount = grantdata.Rows.Count;

            for (int i = 0, j=1; i < grantrowamount; i++, j++)
            {
                TextBox txtba = (TextBox)this.grantsEntry1.FindControl("gn" + j);
                txtba.Text = grantdata.Rows[i]["GRANT_NUM"].ToString();

                TextBox txtbb = (TextBox)this.grantsEntry1.FindControl("gf" + j);
                txtbb.Text = DateTime.Parse(grantdata.Rows[i]["Period_from"].ToString()).ToShortDateString(); 

                TextBox txtbc = (TextBox)this.grantsEntry1.FindControl("gt" + j);
                txtbc.Text = DateTime.Parse(grantdata.Rows[i]["Period_to"].ToString()).ToShortDateString(); 

                TextBox txtbd = (TextBox)this.grantsEntry1.FindControl("ga" + j);
                //txtbd.Text = String.Format("C", float.Parse(grantdata.Rows[i]["AMOUNT"].ToString()));
                txtbd.Text = float.Parse(grantdata.Rows[i]["AMOUNT"].ToString()).ToString("c") ;

                TextBox txtbe = (TextBox)this.grantsEntry1.FindControl("glc" + j);
                txtbe.Text = grantdata.Rows[i]["locode"].ToString();

                TextBox txtbf = (TextBox)this.grantsEntry1.FindControl("gsd" + j);
                txtbf.Text = grantdata.Rows[i]["supDist"].ToString();

                TextBox txtbg = (TextBox)this.grantsEntry1.FindControl("goc" + j);
                txtbg.Text = grantdata.Rows[i]["objcode"].ToString();

                CheckBox txtbh = (CheckBox)this.grantsEntry1.FindControl("geo" + j);

                string eocheck = grantdata.Rows[i]["eo"].ToString();
                if (eocheck == "1")
                {
                    txtbh.Checked = true;
                }
                else { txtbh.Checked = false; }


                //TextBox txtb3 = (TextBox)this.grantsEntry1.FindControl("goc" + j);

                //txtb3.Text = payData.Rows[rowIndex]["DEPTOBJ"].ToString();

            }
            grantsEntry1.Visible = true;
            grantadpt.Dispose();
            grantdata.Dispose();
            grantcommand.Dispose();
            payAdapter.Dispose();
            payData.Dispose();
            payConnection.Close();
        }
        protected void ClearTextBoxes(Control control)
        {
            foreach (Control c in control.Controls)
            {
                if (c is TextBox)
                    ((TextBox)c).Text = "";
                if (c is CheckBox)
                    ((CheckBox)c).Checked = false;
            }
        }
        public void DisableGrants(object sender, EventArgs e)
        {
            if (DropDownList3.SelectedValue != "1")
            {
                eg.Visible = false;
                grantsEntry1.Visible = false;
                grantsEntr2.Visible = false;
                grantsEntr3.Visible = false;
                grantsEntr4.Visible = false;

            }
            else 
            { eg.Visible = true; }
        }

       protected void javatester(object sender, EventArgs e)
        {
            savedagencyname.Text = DropDownList2.SelectedItem.ToString();
            //failedsave.Text = DropDownList2.Text.ToString();
            //ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript: ReqField1Validator() ", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "saveddiao();", true);
           
        }

        public void tallysum(object sender, EventArgs e)
        {
            double summer = 0.00; 

            for (int i = 1; i < 41; i++)
            {
                TextBox txtadd = (TextBox)this.grantsEntry1.FindControl("ga" + i);

                double summerz;
                if (txtadd.Text == "")
                { summerz = 0.00;}
                else {
                    summerz = double.Parse(txtadd.Text.ToString().Replace("$", String.Empty));
                }
                summer = summer + summerz;

                TextBox5.Text = String.Format("${0:C}", summer);
                //PayLabel.Text = string.Format("${0:###,###.##}", float.Parse(payData.Rows[rowIndex]["TRA"].ToString()).ToString("N", nfi));
                editPAY.Text = String.Format("{0:C}", summer);

                txtadd.Focus();

            }

            //TextBox5.Text = String.Format("{0:C}", summer);
            //editPAY.Text = String.Format("{0:C}", summer);

        }
         

        public void fillOut() //main function for filling out the display values
        {
                rowIndexLab.Text = rowIndex.ToString();

                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
                SqlConnection payConnection = new SqlConnection(connectionString);

                payConnection.Open();

                NumberFormatInfo nfi = new NumberFormatInfo();
                nfi.NumberNegativePattern = 0;//  creates parenteses around negative numbers, dont ask me how it works.

                if (ageFilter.Checked == true)
                {

                    float filteragecode = float.Parse(AgencyViewScrolldown.SelectedValue.ToString());
                    SqlCommand filtercommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[TRANSFERS] LEFT OUTER JOIN [FOXPRODEV].[dbo].[AGENCIES] on [TRANSFERS].[AGE_CODE] = [AGENCIES].[AGE_CODE] where [AGENCIES].[AGE_CODE] =  " + filteragecode + " order by  [TRANSFERS].[LUPD_DATE] asc", payConnection);
                    SqlDataAdapter payAdapter = new SqlDataAdapter(filtercommand);

                    DataTable payData = new DataTable(); // new datatable

                    payAdapter.Fill(payData);

                    rowLimit = (Convert.ToInt32(payData.Rows.Count.ToString()) - 1);
                    rowLimitLab.Text = rowLimit.ToString();
                    rowIndexLab.Text = rowIndex.ToString();
                    //gona fill out all the text fields with values

                    agecoder = int.Parse(payData.Rows[rowIndex]["AGE_CODE"].ToString());


                    maintracode = int.Parse(payData.Rows[rowIndex]["TRA_CODE"].ToString());

                    TCLabel.Text = payData.Rows[rowIndex]["TC"].ToString();
                    TDLabel.Text = payData.Rows[rowIndex]["TD"].ToString();
                    MOLabel.Text = payData.Rows[rowIndex]["MINOBJ"].ToString();
                    RLabel.Text = payData.Rows[rowIndex]["REFERENCE"].ToString();
                    AgencyViewScrolldown.SelectedValue = payData.Rows[rowIndex]["AGE_CODE"].ToString(); //need to add agencies names to the sql statement
                    //format dates
                    DateTime preTranD = DateTime.Parse(payData.Rows[rowIndex]["TRANDATE"].ToString());
                    TranDate.Text = preTranD.ToString("d");
                    DateTime preProcD = DateTime.Parse(payData.Rows[rowIndex]["PROCESSED"].ToString());
                    ProDate.Text = preProcD.ToString("d");

                    tranTypeDropdownView.SelectedValue = payData.Rows[rowIndex]["TTP_CODE"].ToString();
                    viewComments.Text = payData.Rows[rowIndex]["COMMENTS"].ToString();

                    //getting the fiscal proccess year
                    DateTime prodateTime = DateTime.Parse(payData.Rows[rowIndex]["PROCESSED"].ToString());

                    SUBFUND.Text = payData.Rows[rowIndex]["SUBFUND"].ToString();
                    LOCC.Text = payData.Rows[rowIndex]["LOC_CODE"].ToString();
                    SUPDIST.Text = payData.Rows[rowIndex]["DIS_CODE"].ToString();
                    viewPaymentReq.Text = payData.Rows[rowIndex]["PayReqNum"].ToString();
                    vunitcode.Text = payData.Rows[rowIndex]["Unit_code"].ToString();
                    payeeViewScrollDown.SelectedValue = payData.Rows[rowIndex]["payee"].ToString();

                    viewUser.Text = payData.Rows[rowIndex]["LUPD_USER"].ToString();
                    DateTime viewdateDate = DateTime.Parse(payData.Rows[rowIndex]["LUPD_DATE"].ToString());
                    viewDate.Text = viewdateDate.ToString("d");

                    yearlabel.Text = prodateTime.ToString("yyyy"); //gets the year value
                    int yearNumberInt = Convert.ToInt32(yearlabel.Text.ToString()); //turns year value into a number
                    int proMonth = Convert.ToInt32(prodateTime.ToString("MM"));  //turns month into int value
                    if (proMonth < 7) //check the fisical year for that date
                    {
                        yearNumberInt = yearNumberInt - 1; //mark down the year if the month is less than july indicating previous fiscal year
                    }
                    fisYear.Text = yearNumberInt.ToString(); //gets the fiscal year

                    string agecodeSelect = payData.Rows[rowIndex]["AGE_CODE"].ToString(); //gets agency code
                    agecodeshow.Text = agecodeSelect.ToString();

                    //use same connection strings?

                    SqlCommand agenbalData = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENBALANCFY] where [AGE_CODE] = @ageCodeValue and [FY] = @fyYear", payConnection);
                    agenbalData.Parameters.AddWithValue("ageCodeValue", agecodeSelect.ToString());//paramater for the sql statment to pull the agency code
                    agenbalData.Parameters.AddWithValue("fyYear", yearNumberInt.ToString());//paramter for the fiscal year
                    SqlDataAdapter agenbalAdapter = new SqlDataAdapter(agenbalData); //new sql adpater for agenbalfy
                    DataTable agenbalTable = new DataTable(); //data table for the agenbal data
                    agenbalAdapter.Fill(agenbalTable); //fill the datatable with the dataadapter 

                    if (agenbalTable != null && agenbalTable.Rows.Count > 0) //check to see if table has anything in it, in the case of no valid processdate
                    {
                        //populate the labels for fy collected.
                        fycollected.Text = String.Format("${0:###,###.00}", float.Parse(agenbalTable.Rows[0]["AMT_BAS"].ToString()));
                        PRLabel.Text = String.Format("${0:###,###.00}", float.Parse(agenbalTable.Rows[0]["YEG_BEG"].ToString()));

                        //PayLabel.Text = String.Format("${0:#,###.00}", payData.Rows[rowIndex]["TRA"].ToString());
                        PayLabel.Text = string.Format("${0:###,###.##}", float.Parse(payData.Rows[rowIndex]["TRA"].ToString()).ToString("N", nfi));

                        //AVGLabel.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()));
                        AVGLabel.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()).ToString("N", nfi));

                        //figuring out the restriction rate, first the remaining yeg
                        int yegTotal = Convert.ToInt32(agenbalTable.Rows[0]["YEG_TOT"]);
                        //Response.Write(Convert.ToInt32(agenbalTable.Rows[0]["YEG_TOT"]).ToString());
                        int yegBegin = Convert.ToInt32(agenbalTable.Rows[0]["YEG_BEG"]);
                        int yegRemains = yegTotal + yegBegin;
                        yegRemainer.Text = String.Format("${0:###,###.00}", yegRemains.ToString()); //first part of restriction rate

                        //get the second part of restriction rate
                        // use same connection
                        SqlCommand agencalc = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENCCALCS] where [AGE_CODE] = @agecodevalue and CTP_CODE between 2 and 3", payConnection);
                        agencalc.Parameters.AddWithValue("agecodevalue", agecodeSelect.ToString()); //gets the correct agecode
                        SqlDataAdapter agecalcAdapter = new SqlDataAdapter(agencalc);
                        DataTable agencalcTable = new DataTable();
                        agecalcAdapter.Fill(agencalcTable); //fills table

                        //test table

                        //Response.Write(agencalcTable.Rows[0]["FY_EST"].ToString());
                        //Response.Write(agencalcTable.Rows[1]["FY_EST"].ToString());


                        //get the values for remaining MS
                        int firstMS = Convert.ToInt32(agencalcTable.Rows[0]["FY_EST"]);

                        //Response.Write(firstMS.ToString());

                        ms1.Text = agencalcTable.Rows[0]["FY_EST"].ToString();

                        int secondMS = Convert.ToInt32(agencalcTable.Rows[1]["FY_EST"]);
                        ms2.Text = secondMS.ToString(); //debug it works damnit.

                        int firstMS1 = firstMS * 18;

                        //Response.Write("first" + firstMS1.ToString() + "\n");

                        int secondMS1 = secondMS * 4;

                        //Response.Write("second" + secondMS1.ToString() + "\n"); //works so far

                        int finalMS = firstMS1 + secondMS1;

                        //Response.Write("added" + finalMS.ToString() + "\n");

                        //add the remaining yeg and remaining ms
                        float yegFloat = (float)yegRemains;
                        float msFloat = (float)finalMS;


                        //Response.Write("yegfloat:" + yegFloat.ToString() + "\n");
                        //Response.Write("msfloat:" + msFloat.ToString() + "\n");

                        float restrictionRate = (yegFloat / msFloat) * 100;

                        ResLabel.Text = String.Format("{0}%", restrictionRate.ToString("N", nfi)); //works for when you get to index 63

                        //try to get current fy restrictions
                        float floatAmtBas = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BAS"]);
                        float currentFyRestriction = (restrictionRate * floatAmtBas) / 100;
                        currentFylabel.Text = String.Format("${0:###,###.00}", float.Parse(currentFyRestriction.ToString()).ToString("N", nfi));

                        //total restricted amount
                        float totalRestricted = currentFyRestriction + (float)yegBegin;
                        totalResAmount.Text = String.Format("${0:###,###.00}", float.Parse(totalRestricted.ToString()).ToString("N", nfi));

                        //total fund
                        float floatAmtBeg = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BEG"]);
                        //float floatAmtBas = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BAS"]);//used already
                        float floatAmtInt = Convert.ToInt64(agenbalTable.Rows[0]["AMT_INT"]);
                        float floatTotalFund = floatAmtBeg + floatAmtBas + floatAmtInt;
                        TotalLabel.Text = string.Format("${0:###,###.00}", float.Parse(floatTotalFund.ToString()));

                        //unrestristed amount
                        float unrestictedAmount = floatTotalFund - totalRestricted;
                        URLabel.Text = String.Format("${0:###,###.00}", float.Parse(unrestictedAmount.ToString()));

                        agencalc.Dispose();
                        agencalcTable.Dispose();
                        agecalcAdapter.Dispose();
                    }
                    else
                    {
                        //PayLabel.Text = String.Format("${0:#,###.00}", payData.Rows[rowIndex]["TRA"].ToString());
                        PayLabel.Text = string.Format("${0:###,###.##}", float.Parse(payData.Rows[rowIndex]["TRA"].ToString()).ToString("N", nfi));

                        //AVGLabel.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()));
                        AVGLabel.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()).ToString("N", nfi));

                        fycollected.Text = "Not available without a process date";
                        PRLabel.Text = "Not available without a process date";
                        //PayLabel.Text = "Not available without a process date";
                        //AVGLabel.Text = "Not available without a process date";
                        yegRemainer.Text = "Not available without a process date";
                        ms1.Text = "Not available without a process date";
                        ms2.Text = "Not available without a process date";
                        ResLabel.Text = "Not available without a process date";
                        currentFylabel.Text = "Not available without a process date";
                        totalResAmount.Text = "Not available without a process date";
                        TotalLabel.Text = "Not available without a process date";
                        URLabel.Text = "Not available without a process date";
                    }

                    //use to populate grants

                    //get rid of everything just now, working backwards
                    payAdapter.Dispose();
                    payData.Dispose();
                    //payCommand.Dispose();
                    payConnection.Close();
                    agenbalData.Dispose();
                    agenbalAdapter.Dispose();
                    agenbalTable.Dispose();
                }  
        else
                {
                    SqlCommand payCommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[TRANSFERS] LEFT OUTER JOIN [FOXPRODEV].[dbo].[AGENCIES] on [TRANSFERS].[AGE_CODE] = [AGENCIES].[AGE_CODE] order by  [TRANSFERS].[LUPD_DATE] asc", payConnection);
                    SqlDataAdapter payAdapter = new SqlDataAdapter(payCommand);

                    DataTable payData = new DataTable(); // new datatable

                    payAdapter.Fill(payData);

                    rowLimit = (Convert.ToInt32(payData.Rows.Count.ToString()) - 1);
                    rowLimitLab.Text = rowLimit.ToString();
                    rowIndexLab.Text = rowIndex.ToString();
                    //gona fill out all the text fields with values

                    agecoder = int.Parse(payData.Rows[rowIndex]["AGE_CODE"].ToString());


                    maintracode = int.Parse(payData.Rows[rowIndex]["TRA_CODE"].ToString());
                    TCLabel.Text = payData.Rows[rowIndex]["TC"].ToString();
                    TDLabel.Text = payData.Rows[rowIndex]["TD"].ToString();
                    MOLabel.Text = payData.Rows[rowIndex]["MINOBJ"].ToString();
                    RLabel.Text = payData.Rows[rowIndex]["REFERENCE"].ToString();
                    AgencyViewScrolldown.SelectedValue = payData.Rows[rowIndex]["AGE_CODE"].ToString(); //need to add agencies names to the sql statement
                    //format dates
                    DateTime preTranD = DateTime.Parse(payData.Rows[rowIndex]["TRANDATE"].ToString());
                    TranDate.Text = preTranD.ToString("d");
                    DateTime preProcD = DateTime.Parse(payData.Rows[rowIndex]["PROCESSED"].ToString());
                    ProDate.Text = preProcD.ToString("d");

                    tranTypeDropdownView.SelectedValue = payData.Rows[rowIndex]["TTP_CODE"].ToString();
                    viewComments.Text = payData.Rows[rowIndex]["COMMENTS"].ToString();

                    //getting the fiscal proccess year
                    DateTime prodateTime = DateTime.Parse(payData.Rows[rowIndex]["PROCESSED"].ToString());

                    SUBFUND.Text = payData.Rows[rowIndex]["SUBFUND"].ToString();
                    LOCC.Text = payData.Rows[rowIndex]["LOC_CODE"].ToString();
                    SUPDIST.Text = payData.Rows[rowIndex]["DIS_CODE"].ToString();
                    viewPaymentReq.Text = payData.Rows[rowIndex]["PayReqNum"].ToString();
                    vunitcode.Text = payData.Rows[rowIndex]["Unit_code"].ToString();
                    payeeViewScrollDown.SelectedValue = payData.Rows[rowIndex]["payee"].ToString();

                    viewUser.Text = payData.Rows[rowIndex]["LUPD_USER"].ToString();
                    DateTime viewdateDate = DateTime.Parse(payData.Rows[rowIndex]["LUPD_DATE"].ToString());
                    viewDate.Text = viewdateDate.ToString("d");

                    yearlabel.Text = prodateTime.ToString("yyyy"); //gets the year value
                    int yearNumberInt = Convert.ToInt32(yearlabel.Text.ToString()); //turns year value into a number
                    int proMonth = Convert.ToInt32(prodateTime.ToString("MM"));  //turns month into int value
                    if (proMonth < 7) //check the fisical year for that date
                    {
                        yearNumberInt = yearNumberInt - 1; //mark down the year if the month is less than july indicating previous fiscal year
                    }
                    fisYear.Text = yearNumberInt.ToString(); //gets the fiscal year

                    string agecodeSelect = payData.Rows[rowIndex]["AGE_CODE"].ToString(); //gets agency code
                    agecodeshow.Text = agecodeSelect.ToString();

                    //use same connection strings?

                    SqlCommand agenbalData = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENBALANCFY] where [AGE_CODE] = @ageCodeValue and [FY] = @fyYear", payConnection);
                    agenbalData.Parameters.AddWithValue("ageCodeValue", agecodeSelect.ToString());//paramater for the sql statment to pull the agency code
                    agenbalData.Parameters.AddWithValue("fyYear", yearNumberInt.ToString());//paramter for the fiscal year
                    SqlDataAdapter agenbalAdapter = new SqlDataAdapter(agenbalData); //new sql adpater for agenbalfy
                    DataTable agenbalTable = new DataTable(); //data table for the agenbal data
                    agenbalAdapter.Fill(agenbalTable); //fill the datatable with the dataadapter 

                                       if (agenbalTable != null && agenbalTable.Rows.Count > 0) //check to see if table has anything in it, in the case of no valid processdate
                    {
                        //populate the labels for fy collected.
                        fycollected.Text = String.Format("${0:###,###.00}", float.Parse(agenbalTable.Rows[0]["AMT_BAS"].ToString()));
                        PRLabel.Text = String.Format("${0:###,###.00}", float.Parse(agenbalTable.Rows[0]["YEG_BEG"].ToString()));

                        //PayLabel.Text = String.Format("${0:#,###.00}", payData.Rows[rowIndex]["TRA"].ToString());
                        PayLabel.Text = string.Format("${0:###,###.##}", float.Parse(payData.Rows[rowIndex]["TRA"].ToString()).ToString("N", nfi));

                        //AVGLabel.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()));
                        AVGLabel.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()).ToString("N", nfi));

                        //figuring out the restriction rate, first the remaining yeg
                        int yegTotal = Convert.ToInt32(agenbalTable.Rows[0]["YEG_TOT"]);
                        //Response.Write(Convert.ToInt32(agenbalTable.Rows[0]["YEG_TOT"]).ToString());
                        int yegBegin = Convert.ToInt32(agenbalTable.Rows[0]["YEG_BEG"]);
                        int yegRemains = yegTotal + yegBegin;
                        yegRemainer.Text = String.Format("${0:###,###.00}", yegRemains.ToString()); //first part of restriction rate

                        //get the second part of restriction rate
                        // use same connection
                        SqlCommand agencalc = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENCCALCS] where [AGE_CODE] = @agecodevalue and CTP_CODE between 2 and 3", payConnection);
                        agencalc.Parameters.AddWithValue("agecodevalue", agecodeSelect.ToString()); //gets the correct agecode
                        SqlDataAdapter agecalcAdapter = new SqlDataAdapter(agencalc);
                        DataTable agencalcTable = new DataTable();
                        agecalcAdapter.Fill(agencalcTable); //fills table

                        //test table

                        //Response.Write(agencalcTable.Rows[0]["FY_EST"].ToString());
                        //Response.Write(agencalcTable.Rows[1]["FY_EST"].ToString());


                        //get the values for remaining MS
                        int firstMS = Convert.ToInt32(agencalcTable.Rows[0]["FY_EST"]);

                        //Response.Write(firstMS.ToString());

                        ms1.Text = agencalcTable.Rows[0]["FY_EST"].ToString();

                        int secondMS = Convert.ToInt32(agencalcTable.Rows[1]["FY_EST"]);
                        ms2.Text = secondMS.ToString(); //debug it works damnit.

                        int firstMS1 = firstMS * 18;

                        //Response.Write("first" + firstMS1.ToString() + "\n");

                        int secondMS1 = secondMS * 4;

                        //Response.Write("second" + secondMS1.ToString() + "\n"); //works so far

                        int finalMS = firstMS1 + secondMS1;

                        //Response.Write("added" + finalMS.ToString() + "\n");

                        //add the remaining yeg and remaining ms
                        float yegFloat = (float)yegRemains;
                        float msFloat = (float)finalMS;


                        //Response.Write("yegfloat:" + yegFloat.ToString() + "\n");
                        //Response.Write("msfloat:" + msFloat.ToString() + "\n");

                        float restrictionRate = (yegFloat / msFloat) * 100;

                        ResLabel.Text = String.Format("{0}%", restrictionRate.ToString("N", nfi)); //works for when you get to index 63

                        //try to get current fy restrictions
                        float floatAmtBas = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BAS"]);
                        float currentFyRestriction = (restrictionRate * floatAmtBas) / 100;
                        currentFylabel.Text = String.Format("${0:###,###.00}", float.Parse(currentFyRestriction.ToString()).ToString("N", nfi));

                        //total restricted amount
                        float totalRestricted = currentFyRestriction + (float)yegBegin;
                        totalResAmount.Text = String.Format("${0:###,###.00}", float.Parse(totalRestricted.ToString()).ToString("N", nfi));

                        //total fund
                        float floatAmtBeg = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BEG"]);
                        //float floatAmtBas = Convert.ToInt64(agenbalTable.Rows[0]["AMT_BAS"]);//used already
                        float floatAmtInt = Convert.ToInt64(agenbalTable.Rows[0]["AMT_INT"]);
                        float floatTotalFund = floatAmtBeg + floatAmtBas + floatAmtInt;
                        TotalLabel.Text = string.Format("${0:###,###.00}", float.Parse(floatTotalFund.ToString()));

                        //unrestristed amount
                        float unrestictedAmount = floatTotalFund - totalRestricted;
                        URLabel.Text = String.Format("${0:###,###.00}", float.Parse(unrestictedAmount.ToString()));

                        agencalc.Dispose();
                        agencalcTable.Dispose();
                        agecalcAdapter.Dispose();
                    }
                    else
                    {
                        //PayLabel.Text = String.Format("${0:#,###.00}", payData.Rows[rowIndex]["TRA"].ToString());
                        PayLabel.Text = string.Format("${0:###,###.##}", float.Parse(payData.Rows[rowIndex]["TRA"].ToString()).ToString("N", nfi));

                        //AVGLabel.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()));
                        AVGLabel.Text = String.Format("${0:###,###.00}", float.Parse(payData.Rows[rowIndex]["AVERAGE"].ToString()).ToString("N", nfi));
                        fycollected.Text = "Not available without a process date";
                        PRLabel.Text = "Not available without a process date";
                        //PayLabel.Text = "Not available without a process date";
                        //AVGLabel.Text = "Not available without a process date";
                        yegRemainer.Text = "Not available without a process date";
                        ms1.Text = "Not available without a process date";
                        ms2.Text = "Not available without a process date";
                        ResLabel.Text = "Not available without a process date";
                        currentFylabel.Text = "Not available without a process date";
                        totalResAmount.Text = "Not available without a process date";
                        TotalLabel.Text = "Not available without a process date";
                        URLabel.Text = "Not available without a process date";
                    }

                    //get rid of everything just now, working backwards
                    payAdapter.Dispose();
                    payData.Dispose();
                    payCommand.Dispose();
                    payConnection.Close();
                    agenbalData.Dispose();
                    agenbalAdapter.Dispose();
                    agenbalTable.Dispose();


                }//end else
            }//end fillOut function

        
        public void checkgrant(object sender, EventArgs e)
        {
            int testnumb = 1;
            testnumb = int.Parse( testnumber.Text.ToString());

            TextBox txtba = (TextBox)this.grantsEntry1.FindControl("gn" + testnumb); //grants number
            Lb1.Text = txtba.Text.ToString();
            TextBox txtbb = (TextBox)this.grantsEntry1.FindControl("gf" + testnumb); //grants to
            TextBox txtbc = (TextBox)this.grantsEntry1.FindControl("gt" + testnumb); // grants from
            TextBox txtbd = (TextBox)this.grantsEntry1.FindControl("ga" + testnumb); // grants amount
            TextBox txtbe = (TextBox)this.grantsEntry1.FindControl("glc" + testnumb); // grants location code
            TextBox txtbf = (TextBox)this.grantsEntry1.FindControl("gsd" + testnumb); //support district
            TextBox txtbg = (TextBox)this.grantsEntry1.FindControl("goc" + testnumb); //object code
            CheckBox txtbh = (CheckBox)this.grantsEntry1.FindControl("geo" + testnumb); //extra ordinary
            grantcontollertest.Text = grantscontroler.Text.ToString();

        }
        //public void grantmoneyformater(object sender, EventArgs e)
        //{
        //    double amount = 0.0d;
        //    if(Double.TryParse())
        //}
        public void firstAgency()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection payConnection = new SqlConnection(connectionString);

            payConnection.Open();

            string getavgage = "2";
            //newpayee.SelectedValue = getavgage;
            SqlCommand payCommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[AGENCIES] WHERE [AGE_CODE]= @agecodes", payConnection);
            payCommand.Parameters.Add("@agecodes", SqlDbType.Float).Value = float.Parse(getavgage.ToString());


            SqlDataAdapter payAdapter = new SqlDataAdapter(payCommand); //new sql adapter

            DataTable payData = new DataTable(); // new datatable

            payAdapter.Fill(payData);

            //gona fill out all the text fields with values


            for (int i = 1; i < 41; i++)
            {
                TextBox txtb = (TextBox)this.grantsEntry1.FindControl("glc" + i);

                txtb.Text = payData.Rows[0]["LOC_CODE"].ToString();

                TextBox txtb2 = (TextBox)this.grantsEntry1.FindControl("gsd" + i);

                txtb2.Text = payData.Rows[0]["SUPDIST"].ToString();

                TextBox txtb3 = (TextBox)this.grantsEntry1.FindControl("goc" + i);

                txtb3.Text = payData.Rows[0]["DEPTOBJ"].ToString();

            }
            textboxt.Text = getavgage;
            TextBox80.Text = payData.Rows[0]["SUBFUND"].ToString();
            newLocCode.Text = payData.Rows[0]["LOC_CODE"].ToString();
            newsupdist.Text = payData.Rows[0]["SUPDIST"].ToString();
            TextBox3.Text = payData.Rows[0]["DEPTOBJ"].ToString();
            NewUnit.Text = payData.Rows[0]["Unit_code"].ToString();

            //get rid of everything just now, working backwards
            payAdapter.Dispose();
            payData.Dispose();
            //payCommand.Dispose();
            payConnection.Close();
        }


        }// end payment class
    
}//end ParkDev namespace
