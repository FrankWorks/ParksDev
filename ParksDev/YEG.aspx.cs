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
    public partial class YEG : System.Web.UI.Page
    {
        public static int rowIndex = 0;
        public static int rowIndexF =0;
        public static int rowLimit = new int();
        public static int rowLimitF = new int();

        public static string yrccode;
        public static string agecoder;

      

        protected void Page_Load(object sender, EventArgs e)
        {
            EditPanel.Visible = false; //hide the edit panel
            eds.Visible = false;


            if (!IsPostBack)
            {
                FillView();
                
            }// end if post back
        } //end pageload

        public void clickFirst(object sender, EventArgs e)
        {
            if (ageFilter.Checked == true)
            {
                if (checkifempty())//make sure there's some value for that agency
                {
                    NORECORD.Visible = false;
                    viewPanel.Visible = true;
                    newPanel.Visible = false;
                    rowIndexF = 0; //back to the first

                    FillViewFilter();
                }
                else {
                    NORECORD.Visible = true;
                }
            
            }
            else
            {
                NORECORD.Visible = false; viewPanel.Visible = true;
                newPanel.Visible = false;
                rowIndex = 0; //back to the first

                FillView();
            }
          

        }//end clickFirst

        public void clickPrevious(object sender, EventArgs e)
        {
            if (ageFilter.Checked == true)
            {
                if (checkifempty())//make sure there's some value for that agency
                {
                    NORECORD.Visible = false;
                    viewPanel.Visible = true;
                    newPanel.Visible = false;
                    rowIndexF--; //back one
                    if (rowIndexF >= 0) //make sure doesnt go below zero
                    {
                        FillViewFilter();
                    }
                    else
                    {
                        rowIndexF = 0;
                        FillViewFilter();
                    }
                }
                else
                {
                    NORECORD.Visible = true;
                }
            }
            else
            {
                NORECORD.Visible = false;
                rowIndex--;
                viewPanel.Visible = true;
                eds.Visible = false;
                newPanel.Visible = false;
                if (rowIndex >= 0) //make sure doesnt go past 0
                {
                    FillView();
                }//end if
                else
                {
                    //rowindex is now less than 0
                    rowIndex = 0; //return rowindex back to 0
                }
            }
        }//end previous

        public void clickNext(object sender, EventArgs e)
        {
            if (ageFilter.Checked == true)
            {
                if (checkifempty())//make sure there's some value for that agency
                {
                    viewPanel.Visible = true;
                    newPanel.Visible = false;
                    rowIndexF++; //next inddex
                    if (rowIndexF <= rowLimitF)
                    {
                        FillViewFilter();
                    }
                    else
                    {
                        rowIndexF = rowLimitF;
                        FillViewFilter();
                    }
                }
                else
                {
                    NORECORD.Visible = true;
                }
            }
            else //else of agefilter
            {
                NORECORD.Visible = false;
                rowIndex++;
                viewPanel.Visible = true;
                eds.Visible = false;
                newPanel.Visible = false;
                if (rowIndex <= rowLimit) //doesnt go over the rowlimit
                {
                    FillView();

                }
                else { rowIndex = rowLimit; }
            }
        }//end nextbutton

        public void clickLast(object sender, EventArgs e)
        {
            if (ageFilter.Checked == true)
            {
                if (checkifempty())//make sure there's some value for that agency
                {
                    NORECORD.Visible = false;
                    viewPanel.Visible = true;
                    newPanel.Visible = false;
                    rowIndexF = rowLimitF; //to the last

                    FillViewFilter();
                }
                else
                {
                    NORECORD.Visible = true;
                }
            }
            else
            {
                NORECORD.Visible = false;
                rowIndex = rowLimit; //take rowindex to last row which is rowLimit
                eds.Visible = false;
                viewPanel.Visible = true;
                newPanel.Visible = false;

                FillView();
            }
            }//end last

        public void clickEdit(object sender, EventArgs e)
        {
            //set the current rowIndex
            roxindexLab.Text = rowIndex.ToString();
     

            newPanel.Visible = false;
            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection yegConnection = new SqlConnection(connectionString);

            yegConnection.Open();

            SqlCommand yegCommand = new SqlCommand("Select * FROM [FOXPRODEV].[dbo].[YEGCREDITS] order by [processed]", yegConnection);

                SqlDataAdapter yegAdapter = new SqlDataAdapter(yegCommand);

                DataTable yegData = new DataTable();

                yegAdapter.Fill(yegData); //fill it!!!!!!!!!!!!!!

                roxindexLab.Text = rowIndex.ToString();
                rowLimit = (Convert.ToInt32(yegData.Rows.Count.ToString()) - 1); //sets the row limit
                //   rowlimitLab.Text = rowLimit.ToString();

                agecoder = yegData.Rows[rowIndex]["age_code"].ToString();

                yrccode = yegData.Rows[rowIndex]["ycr_code"].ToString();

                DateTime editenteredtest;
                if (DateTime.TryParse(yegData.Rows[rowIndex]["entered"].ToString(), out editenteredtest))
                { 
                editEntered.Text = DateTime.Parse(yegData.Rows[rowIndex]["entered"].ToString()).ToShortDateString();
                }
                else{
                    editEntered.Text = "None Entered";
                }

                editBy.Text = yegData.Rows[rowIndex]["by"].ToString();
                editFy.Text = yegData.Rows[rowIndex]["fy"].ToString();
                editProcessed.Text = yegData.Rows[rowIndex]["processed"].ToString();
                editAgency.Text = yegData.Rows[rowIndex]["AGENCY"].ToString();
                editYeg.Text = String.Format("${0:#,###.00}",float.Parse(yegData.Rows[rowIndex]["yeg"].ToString()));

                string testtotalyeggoal = yegData.Rows[rowIndex]["YEG_TOT"].ToString();
                bool yegtotexist;
                if (testtotalyeggoal == "")
                {
                    editTotalYegGoal.Text = "No Data";
                    yegtotexist = false;
                }
                else
                {
                    editTotalYegGoal.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndex]["YEG_TOT"].ToString()));
                    yegtotexist = true;
                }
                string testedittypc = yegData.Rows[rowIndex]["YEGPTOT"].ToString();//generally always exist
                if (testedittypc == "")
                {
                    editTYPC.Text = "No Data";
                }
                else
                { 
                editTYPC.Text = String.Format("${0:#,###.00}",float.Parse(yegData.Rows[rowIndex]["YEGPTOT"].ToString()));
                }
                if (yegtotexist)
                {
                    int TRYGLabValue = (Convert.ToInt32(yegData.Rows[rowIndex]["YEG_TOT"]) - Convert.ToInt32(yegData.Rows[rowIndex]["YEGPTOT"]));
                    editTRYG.Text = String.Format("${0:#,###.00}", float.Parse(TRYGLabValue.ToString()));
                }//equation
                else
                {
                    int TRYGLabValue = 0 - Convert.ToInt32(yegData.Rows[rowIndex]["YEGPTOT"]);
                    editTRYG.Text = String.Format("${0:#,###.00}", float.Parse(TRYGLabValue.ToString()));
                }
                string testedituygfpf = yegData.Rows[rowIndex]["YEG_BEG"].ToString();
                bool yegbegexist;
                if(testedituygfpf == "")
                {
                editUYGFPF.Text="No Data";
                yegbegexist = false; 
                }
                else
                {
                editUYGFPF.Text = String.Format("${0:#,###.00}",float.Parse(yegData.Rows[rowIndex]["YEG_BEG"].ToString()));
                yegbegexist = true;
                }
                string testeditcfeyg = yegData.Rows[rowIndex]["YEG_CAL"].ToString();
                if(testeditcfeyg == ""){
                editCFEYG.Text= "No Data";
                }
                else{
                editCFEYG.Text = String.Format("${0:#,###.00}",float.Parse(yegData.Rows[rowIndex]["YEG_CAL"].ToString()));
                }
                string testedittyctf = yegData.Rows[rowIndex]["YEG_TRA"].ToString();
                if(testedittyctf == "")
                {
                    editTYCTF.Text = "No Data";
                    }
                else{
                editTYCTF.Text = String.Format("${0:#,###.00}",float.Parse(yegData.Rows[rowIndex]["YEG_TRA"].ToString()));
                }
                if (yegbegexist) {
                int RYGOCFLabValue = ((Convert.ToInt32(yegData.Rows[rowIndex]["YEG_BEG"])) + (Convert.ToInt32(yegData.Rows[rowIndex]["YEG_CAL"]))) - (Convert.ToInt32(yegData.Rows[rowIndex]["YEG_TRA"]));
                editRYGOCF.Text = String.Format("${0:#,###.00}",float.Parse(RYGOCFLabValue.ToString())); } //equation
                else
                {
                //int RYGOCFLabValue = ((Convert.ToInt32(yegData.Rows[rowIndex]["YEG_BEG"])) + (Convert.ToInt32(yegData.Rows[rowIndex]["YEG_CAL"]))) - (Convert.ToInt32(yegData.Rows[rowIndex]["YEG_TRA"]));
                editRYGOCF.Text = "No Data";
                }
                editGrantNo.Text = yegData.Rows[rowIndex]["grantno"].ToString();
                editProject.Text = yegData.Rows[rowIndex]["project"].ToString();
                editNoYouths.Text = yegData.Rows[rowIndex]["noyouths"].ToString();
                editNoOfHours.Text = Convert.ToDecimal(yegData.Rows[rowIndex]["nohours"].ToString()).ToString("N2");
                
                string testAproxAge = yegData.Rows[rowIndex]["age"].ToString(); //aproximate age
                if (testAproxAge == "") { editAproxAge.Text = " "; }
                else { editAproxAge.Text = testAproxAge.ToString(); }

                string testWage = yegData.Rows[rowIndex]["wage"].ToString(); // wage
                if (testWage == "") { editWage.Text = " "; }
                else { editWage.Text = testWage.ToString(); }

                
                editJobP.Text = yegData.Rows[rowIndex]["work"].ToString();
                editEmployed.Text = yegData.Rows[rowIndex]["employer"].ToString();
                editComments.Text = yegData.Rows[rowIndex]["comments"].ToString();
                DateTime editFromtest;
                if (DateTime.TryParse(yegData.Rows[rowIndex]["periodfr"].ToString(), out editFromtest))
                {
                    editFrom.Text = DateTime.Parse(yegData.Rows[rowIndex]["periodfr"].ToString()).ToShortDateString();
                }
                else
                { editFrom.Text = "No Date Entered"; }
                DateTime editTotest;
                if (DateTime.TryParse(yegData.Rows[rowIndex]["periodto"].ToString(), out editTotest))
                {
                    editTo.Text = DateTime.Parse(yegData.Rows[rowIndex]["periodto"].ToString()).ToShortDateString();
                }
                else
                { editTo.Text = "No Date Entered"; }

                yegAdapter.Dispose();
                yegCommand.Dispose();
                yegConnection.Close();


                EditPanel.Visible = true;
                viewPanel.Visible = false;
                newPanel.Visible = false;
                eds.Visible = false;            
          
        }// end edit

        public void clickNew(object sender, EventArgs e)
        {
            newPanel.Visible = true;
            viewPanel.Visible = false;
            EditPanel.Visible = false;
            eds.Visible = false;
            //set today's date
            newDate.Text = DateTime.Today.ToShortDateString();
            //set user
            newUser.Text = User.Identity.Name.ToString();
        }
        public void edittester(object sender, EventArgs e)
        {
            testbox.Text = editFy.Text.ToString();
            EditPanel.Visible = true;
        }

        public void editSaver(object sender, EventArgs e)
        {
            //try
            //{
                string editString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

                SqlConnection editconn = new SqlConnection(editString);
                editconn.Open();

                SqlCommand editcomm = new SqlCommand("editYEG", editconn);
                editcomm.CommandType = CommandType.StoredProcedure;

                editcomm.Parameters.Add("@ycr_code", SqlDbType.Float).Value = float.Parse(yrccode.ToString());
                editcomm.Parameters.Add("@entered", SqlDbType.DateTime).Value = Convert.ToDateTime(editEntered.Text.ToString());
                editcomm.Parameters.Add("@by", SqlDbType.NVarChar).Value = editBy.Text.ToString();
                editcomm.Parameters.Add("@age_code", SqlDbType.Float).Value = float.Parse( agecoder.ToString());
                editcomm.Parameters.Add("@ytp_code", SqlDbType.Float).Value = float.Parse(editYegType.SelectedValue);
                editcomm.Parameters.Add("@fy", SqlDbType.Float).Value = float.Parse(editFy.Text.ToString().Replace("$", String.Empty));
                editcomm.Parameters.Add("@processed", SqlDbType.DateTime).Value = Convert.ToDateTime(editProcessed.Text.ToString());
                editcomm.Parameters.Add("@yeg", SqlDbType.Float).Value = float.Parse(editYeg.Text.ToString().Replace("$", String.Empty));
                editcomm.Parameters.Add("@grantno", SqlDbType.NVarChar).Value = editGrantNo.Text.ToString();
                editcomm.Parameters.Add("@project", SqlDbType.NVarChar).Value = editProject.Text.ToString();
                editcomm.Parameters.Add("@noyouths", SqlDbType.Float).Value = editNoYouths.Text.ToString();
                editcomm.Parameters.Add("@nohours", SqlDbType.Float).Value = float.Parse(editNoOfHours.Text.ToString());
                editcomm.Parameters.Add("@age", SqlDbType.NVarChar).Value = editAproxAge.Text.ToString();
                editcomm.Parameters.Add("@wage", SqlDbType.NVarChar).Value = editWage.Text.ToString();
                editcomm.Parameters.Add("@work", SqlDbType.NVarChar).Value = editJobP.Text.ToString();
                editcomm.Parameters.Add("@employer", SqlDbType.NVarChar).Value = editEmployed.Text.ToString();
                DateTime peroidFRtest; //test if the current value in that text box is a valid datetime
                if (DateTime.TryParse(editFrom.Text.ToString(), out peroidFRtest))
                {
                    editcomm.Parameters.Add("@periodfr", SqlDbType.DateTime).Value = Convert.ToDateTime(editFrom.Text.ToString());
                }
                else
                {
                    editcomm.Parameters.Add("@periodfr", SqlDbType.DateTime).Value = Convert.ToDateTime("1/1/1900");
                }
                DateTime periodTOtest; //test if the current value in that text box is a valid datetime
                if (DateTime.TryParse(editTo.Text.ToString(), out periodTOtest))
                {
                    editcomm.Parameters.Add("@periodto", SqlDbType.DateTime).Value = Convert.ToDateTime(editTo.Text.ToString());
                }
                else
                {
                    editcomm.Parameters.Add("@periodto", SqlDbType.DateTime).Value = Convert.ToDateTime("1/1/1900");
                }

                editcomm.Parameters.Add("@comments", SqlDbType.NVarChar).Value = editComments.Text.ToString();
                editcomm.Parameters.Add("@lupd_user", SqlDbType.NVarChar).Value = User.Identity.Name.ToString();
                editcomm.Parameters.Add("@lupd_date", SqlDbType.DateTime).Value = DateTime.Today;
                editcomm.Parameters.Add("@lupd_time", SqlDbType.NVarChar).Value = DateTime.Today;

                int editcount = editcomm.ExecuteNonQuery();
                if (editcount > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "savededit();", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "faileddiao();", true);
                }
                //editcomm.ExecuteNonQuery();
                editconn.Close();
                editcomm.Dispose();
            //}
            //catch (Exception ex) { testbox.Text = ex.Message.ToString(); }
            //catch (Exception ex) { eds.Text = ex.Message.ToString();}
            EditPanel.Visible = false;
            viewPanel.Visible = true;
            eds.Visible = true;
           }

        public void editCanceler(object sender, EventArgs e)
        {
            EditPanel.Visible = false;
            viewPanel.Visible = true;
            eds.Visible = false;
        }

        public void addtester(object sender, EventArgs e)
        {
            //addtestlabel.Text = newFrom.Text.ToString();
            newPanel.Visible = true;
        }
        public void newSaveClick(object sender, EventArgs e)
        {
            //try
            //{
                string addString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

                SqlConnection addconn = new SqlConnection(addString);
                addconn.Open();

                SqlCommand addcomm = new SqlCommand("addYEG", addconn);
                addcomm.CommandType = CommandType.StoredProcedure;

                //addcomm.Parameters.Add("@ycr_code", SqlDbType.Float).Value = yrccode;
                addcomm.Parameters.Add("@entered", SqlDbType.DateTime).Value = Convert.ToDateTime(newDate.Text.ToString());
                addcomm.Parameters.Add("@by", SqlDbType.NVarChar).Value = newUser.Text.ToString();
                addcomm.Parameters.Add("@age_code", SqlDbType.Float).Value = DropDownList1.SelectedValue;
                addcomm.Parameters.Add("@ytp_code", SqlDbType.Float).Value = newYTP.SelectedValue;
                addcomm.Parameters.Add("@fy", SqlDbType.Float).Value = newFY.Text.ToString();
                addcomm.Parameters.Add("@processed", SqlDbType.DateTime).Value = Convert.ToDateTime(newProcessed.Text.ToString());
                addcomm.Parameters.Add("@yeg", SqlDbType.Float).Value = newYEG.Text.ToString();
                addcomm.Parameters.Add("@grantno", SqlDbType.NVarChar).Value = newGrantNo.Text.ToString();
                addcomm.Parameters.Add("@project", SqlDbType.NVarChar).Value = newProject.Text.ToString();
                addcomm.Parameters.Add("@noyouths", SqlDbType.Float).Value = newYouths.Text.ToString();
                addcomm.Parameters.Add("@nohours", SqlDbType.Float).Value = newHours.Text.ToString();
                addcomm.Parameters.Add("@age", SqlDbType.NVarChar).Value = newAproxAge.Text.ToString();
                addcomm.Parameters.Add("@wage", SqlDbType.NVarChar).Value = newWage.Text.ToString();
                addcomm.Parameters.Add("@work", SqlDbType.NVarChar).Value = newJob.Text.ToString();
                addcomm.Parameters.Add("@employer", SqlDbType.NVarChar).Value = newEmployed.Text.ToString();
                string tempfrom = newFrom.Text.ToString();
                //addtestlabel.Text = DateTime.Parse(tempfrom).ToString();
                string tempto = newTo.Text.ToString();
                addcomm.Parameters.Add("@periodfr", SqlDbType.DateTime).Value = DateTime.Parse(tempfrom);
                addcomm.Parameters.Add("@periodto", SqlDbType.DateTime).Value = DateTime.Parse(tempto);
                addcomm.Parameters.Add("@comments", SqlDbType.NVarChar).Value = newComments.Text.ToString();
                addcomm.Parameters.Add("@lupd_user", SqlDbType.NVarChar).Value = User.Identity.Name.ToString();
                addcomm.Parameters.Add("@lupd_date", SqlDbType.DateTime).Value = DateTime.Today;
                addcomm.Parameters.Add("@lupd_time", SqlDbType.NVarChar).Value = DateTime.Today;

                try
                {
                    int yegsavecount = addcomm.ExecuteNonQuery();
                    if (yegsavecount > 0)
                    {
                        savedagencyname.Text = DropDownList1.SelectedItem.ToString();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "saveddiao();", true);
                        newPanel.Visible = false;
                        viewPanel.Visible = true;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "faileddiao();", true);
                    }
                }
                catch (SqlException ex)
                {
                    Console.WriteLine("Update Failed coz.. " + ex.Message);
                }
                //addcomm.ExecuteNonQuery();
                addconn.Close();
                addcomm.Dispose();
            //}
            //catch (Exception ex) { testbox.Text = ex.Message.ToString(); }

            //EditPanel.Visible = false;
            //viewPanel.Visible = true;
            eds.Visible = true;
            
        }

        public void newCancelclick(object sender, EventArgs e)
        {
            newPanel.Visible = false;
            viewPanel.Visible = true;
            eds.Visible = false;
        }
        public void changeagency(object sender, EventArgs e)
        {
            rowIndexF = 0;

            DDSwitch.Text = "flipped";
          
          

        }
        public void ageclick(object sender, EventArgs e)
        {
            fclick.Text = "clicked";

            rowIndexF = 0;
            rowIndex = 0;
        }
        public bool checkifempty()
        {

            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection yegConnection = new SqlConnection(connectionString);

            yegConnection.Open();
            float filteragecode = float.Parse(AgencyViewScrolldown.SelectedValue.ToString()); //get agecode
            SqlCommand yegCommand = new SqlCommand("Select * FROM [FOXPRODEV].[dbo].[YEGCREDITS] where [AGE_CODE] = " + filteragecode + "order by [processed]", yegConnection);

            SqlDataAdapter yegAdapter = new SqlDataAdapter(yegCommand);

            DataTable yegData = new DataTable();

            yegAdapter.Fill(yegData);
            rowLimitF = (Convert.ToInt32(yegData.Rows.Count.ToString()) - 1); //sets the row limit for filter list

            if ((yegData != null) && (yegData.Rows.Count > 0))
            {
                nuller.Text = "it's not null";
                nullvalue.Text = yegData.Rows.Count.ToString();
                yegAdapter.Dispose();
                yegCommand.Dispose();
                yegConnection.Close();
                return true;
            }
            else
            {
                nuller.Text = "came back null";
                yegAdapter.Dispose();
                yegCommand.Dispose();
                yegConnection.Close();
                return false;
            }
        }//end checkifempty()

        private void FillView()
        {
            eds.Visible = false;

            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection yegConnection = new SqlConnection(connectionString);

            yegConnection.Open();

            SqlCommand yegCommand = new SqlCommand("Select * FROM [FOXPRODEV].[dbo].[YEGCREDITS] order by [processed]", yegConnection);

            SqlDataAdapter yegAdapter = new SqlDataAdapter(yegCommand);

            DataTable yegData = new DataTable();

            yegAdapter.Fill(yegData); //fill it!!!!!!!!!!!!!!

            roxindexLab.Text = rowIndex.ToString();
            rowLimit = (Convert.ToInt32(yegData.Rows.Count.ToString()) - 1); //sets the row limit
            rowlimitLab.Text = rowLimit.ToString();

            yrccode = yegData.Rows[rowIndex]["ycr_code"].ToString();

            DateTime checkentereddate;
            if (DateTime.TryParse(yegData.Rows[rowIndex]["entered"].ToString(), out checkentereddate))
            {
                DateTime entertemp = DateTime.Parse(yegData.Rows[rowIndex]["entered"].ToString());
                enteredLab.Text = entertemp.ToShortDateString();
            }
            else { enteredLab.Text = "No Date Entered"; }

            //convert to short time stamp
            //enteredLab.Text = String.Format("{0:MM/dd/yy}", yegData.Rows[rowIndex]["entered"].ToString());

            byLab.Text = yegData.Rows[rowIndex]["by"].ToString();
            fyLab.Text = yegData.Rows[rowIndex]["fy"].ToString(); //added fy to the mix


            DateTime temppro;
            if(DateTime.TryParse(yegData.Rows[rowIndex]["processed"].ToString(), out temppro))
                //DateTime.Parse(yegData.Rows[rowIndex]["processed"].ToString());
            {
                proLab.Text = temppro.ToShortDateString();
            }
            else
            {
                proLab.Text = "No Date Entered";
            }
            //convert processed to short date

            AgencyViewScrolldown.SelectedValue = yegData.Rows[rowIndex]["AGE_CODE"].ToString();
            //                AgencyViewScrolldown.SelectedValue = yegData.Rows[rowIndex]["AGE_CODE"].ToString();
            yegLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndex]["yeg"].ToString()));
             float yegtottest;
             if (float.TryParse(yegData.Rows[rowIndex]["YEG_TOT"].ToString(), out yegtottest))
             {
                 tYEGGLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndex]["YEG_TOT"].ToString()));
             }
             else { tYEGGLab.Text = "No Data";
            }
            totYEGpcLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndex]["YEGPTOT"].ToString()));

            int testyeg_tot;
            int TRYGLabValue;
            if(Int32.TryParse(yegData.Rows[rowIndex]["YEG_TOT"].ToString(), out testyeg_tot))
            {
                TRYGLabValue = (Convert.ToInt32(yegData.Rows[rowIndex]["YEG_TOT"]) - Convert.ToInt32(yegData.Rows[rowIndex]["YEGPTOT"]));
                TRYGLab.Text = String.Format("${0:#,###.00}", float.Parse(TRYGLabValue.ToString()));
            }
            else
            {
                //TRYGLab.Text = "Not Enough Data";
                TRYGLabValue = 0 - Convert.ToInt32(yegData.Rows[rowIndex]["YEGPTOT"]);
                TRYGLab.Text = String.Format("${0:#,###.00}", float.Parse(TRYGLabValue.ToString()));
            }
            
            //int TRYGLabValue = (Convert.ToInt32(yegData.Rows[rowIndex]["YEG_TOT"]) - Convert.ToInt32(yegData.Rows[rowIndex]["YEGPTOT"]));
            //TRYGLab.Text = String.Format("${0:#,###.00}", float.Parse(TRYGLabValue.ToString()));
            float testyegbeg;
            bool noyegbeg;
            if (float.TryParse(yegData.Rows[rowIndex]["YEG_BEG"].ToString(), out testyegbeg))
            {
                UYGFPFLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndex]["YEG_BEG"].ToString()));
                noyegbeg = false;
            }
            else { 
                UYGFPFLab.Text = "Not Enough Data";
                noyegbeg = true;
            }
            float testyegcal;
            if(float.TryParse(yegData.Rows[rowIndex]["YEG_CAL"].ToString(), out testyegcal))
            {
            CFEYGLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndex]["YEG_CAL"].ToString()));
            }
            else{
                CFEYGLab.Text = "Not Enough Data";
            }
            float testyegtra;
            bool noyegtra;
            if(float.TryParse(yegData.Rows[rowIndex]["YEG_TRA"].ToString(), out testyegtra))
            {
            TYCTFLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndex]["YEG_TRA"].ToString()));
            noyegtra = false;
            }
            else{
                TYCTFLab.Text = "Not Enough Data";
                noyegtra = true;
            }

            if (noyegbeg == true && noyegtra== true) { RYGOCFLab.Text = "Not Enough Data"; }
            else { 
            int RYGOCFLabValue = ((Convert.ToInt32(yegData.Rows[rowIndex]["YEG_BEG"])) + (Convert.ToInt32(yegData.Rows[rowIndex]["YEG_CAL"]))) - (Convert.ToInt32(yegData.Rows[rowIndex]["YEG_TRA"]));
            RYGOCFLab.Text = String.Format("${0:#,###.00}", float.Parse(RYGOCFLabValue.ToString()));
            } //equation

            grantLab.Text = yegData.Rows[rowIndex]["grantno"].ToString();
            projectLab.Text = yegData.Rows[rowIndex]["project"].ToString();
            nyouthLab.Text = yegData.Rows[rowIndex]["noyouths"].ToString();
            nHoursLab.Text = Convert.ToDecimal(yegData.Rows[rowIndex]["nohours"].ToString()).ToString("N2");

            string testage = yegData.Rows[rowIndex]["age"].ToString();
            if (testage == "") { aproxagev.Text = ""; }
            else { aproxagev.Text = testage.ToString(); }
            string testwage = yegData.Rows[rowIndex]["wage"].ToString();
            if (testwage == "") { wagehourv.Text = ""; }
            else{wagehourv.Text = testwage.ToString(); }
   
            //aproxagev.Text = yegData.Rows[rowIndex]["age"].ToString();
            //wagehourv.Text = yegData.Rows[rowIndex]["wage"].ToString();

            jperformedLab.Text = yegData.Rows[rowIndex]["work"].ToString();
            employLab.Text = yegData.Rows[rowIndex]["employer"].ToString();
            commentsLab.Text = yegData.Rows[rowIndex]["comments"].ToString();

            string testperiodfr = yegData.Rows[rowIndex]["periodfr"].ToString();//check for null values in date
            //null values end up being "" 
            if (testperiodfr == "")
            {
                testperiodfr = "no date";
                fromLab.Text = testperiodfr;
            }
            else
            {
                fromLab.Text = DateTime.Parse(yegData.Rows[rowIndex]["periodfr"].ToString()).ToShortDateString();
            }
            string testperiodto = yegData.Rows[rowIndex]["periodto"].ToString();
            if (testperiodto == "")
            {
                testperiodto = "no date";
                toLab.Text = testperiodto;
            }
            else
            {
                toLab.Text = DateTime.Parse(yegData.Rows[rowIndex]["periodto"].ToString()).ToShortDateString(); 
            }

            //fromLab.Text = DateTime.Parse(yegData.Rows[rowIndex]["periodfr"].ToString()).ToShortDateString();
            //toLab.Text = DateTime.Parse(yegData.Rows[rowIndex]["periodto"].ToString()).ToShortDateString(); 


            yegAdapter.Dispose();
            yegCommand.Dispose();
            yegConnection.Close();

        }

        private void FillViewFilter()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection yegConnection = new SqlConnection(connectionString);

            yegConnection.Open();

            float filteragecode = float.Parse(AgencyViewScrolldown.SelectedValue.ToString());//the agency code grabed here
            SqlCommand yegCommand = new SqlCommand("Select * FROM [FOXPRODEV].[dbo].[YEGCREDITS] where [AGE_CODE] = " + filteragecode + " order by [processed]", yegConnection);//select records with agency only

            SqlDataAdapter yegAdapter = new SqlDataAdapter(yegCommand);

            DataTable yegData = new DataTable();

            yegAdapter.Fill(yegData); //fill it!!!!!!!!!!!!!!

            roxindexLab.Text = rowIndexF.ToString();
            rowLimitF = (Convert.ToInt32(yegData.Rows.Count.ToString()) - 1); //sets the row limit
            rowlimitLab.Text = rowLimitF.ToString();

            yrccode = yegData.Rows[rowIndexF]["ycr_code"].ToString();

            DateTime checkentereddate;
            if (DateTime.TryParse(yegData.Rows[rowIndex]["entered"].ToString(), out checkentereddate))
            {
                DateTime entertemp = DateTime.Parse(yegData.Rows[rowIndex]["entered"].ToString());
                enteredLab.Text = entertemp.ToShortDateString();
            }
            else { enteredLab.Text = "No Date Entered"; }
            //convert to short time stamp
            //enteredLab.Text = String.Format("{0:MM/dd/yy}", yegData.Rows[rowIndex]["entered"].ToString());

            byLab.Text = yegData.Rows[rowIndexF]["by"].ToString();
            fyLab.Text = yegData.Rows[rowIndexF]["fy"].ToString(); //added fy to the mix


            DateTime temppro = DateTime.Parse(yegData.Rows[rowIndexF]["processed"].ToString());
            if (temppro == null)
            {
                proLab.Text = "no date";
            }
            else
            { 
            proLab.Text = temppro.ToShortDateString();
            } /// damn nulls up in this database!!

            //convert processed to short date

            AgencyViewScrolldown.SelectedValue = yegData.Rows[rowIndexF]["AGE_CODE"].ToString();
            //                AgencyViewScrolldown.SelectedValue = yegData.Rows[rowIndex]["AGE_CODE"].ToString();
            yegLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndexF]["yeg"].ToString()));
            tYEGGLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndexF]["YEG_TOT"].ToString()));
            totYEGpcLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndexF]["YEGPTOT"].ToString()));

            int TRYGLabValue = (Convert.ToInt32(yegData.Rows[rowIndexF]["YEG_TOT"]) - Convert.ToInt32(yegData.Rows[rowIndexF]["YEGPTOT"]));
            TRYGLab.Text = String.Format("${0:#,###.00}", float.Parse(TRYGLabValue.ToString()));

            UYGFPFLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndexF]["YEG_BEG"].ToString()));
            CFEYGLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndexF]["YEG_CAL"].ToString()));
            TYCTFLab.Text = String.Format("${0:#,###.00}", float.Parse(yegData.Rows[rowIndexF]["YEG_TRA"].ToString()));

            int RYGOCFLabValue = ((Convert.ToInt32(yegData.Rows[rowIndexF]["YEG_BEG"])) + (Convert.ToInt32(yegData.Rows[rowIndexF]["YEG_CAL"]))) - (Convert.ToInt32(yegData.Rows[rowIndexF]["YEG_TRA"]));
            RYGOCFLab.Text = String.Format("${0:#,###.00}", float.Parse(RYGOCFLabValue.ToString())); //equation

            grantLab.Text = yegData.Rows[rowIndexF]["grantno"].ToString();
            projectLab.Text = yegData.Rows[rowIndexF]["project"].ToString();
            nyouthLab.Text = yegData.Rows[rowIndexF]["noyouths"].ToString();
            nHoursLab.Text = Convert.ToDecimal(yegData.Rows[rowIndexF]["nohours"].ToString()).ToString("N2");

            string testage = yegData.Rows[rowIndexF]["age"].ToString();
            if (testage == "") { aproxagev.Text = ""; }
            else { aproxagev.Text = testage.ToString(); }
            string testwage = yegData.Rows[rowIndexF]["wage"].ToString();
            if (testwage == "") { wagehourv.Text = ""; }
            else { wagehourv.Text = testwage.ToString(); }

            jperformedLab.Text = yegData.Rows[rowIndexF]["work"].ToString();
            employLab.Text = yegData.Rows[rowIndexF]["employer"].ToString();
            commentsLab.Text = yegData.Rows[rowIndexF]["comments"].ToString();

            string testperiodfr = yegData.Rows[rowIndexF]["periodfr"].ToString();//check for null values in date
            if (testperiodfr == "")
            {
                testperiodfr = "no date";
                fromLab.Text = testperiodfr;
            }
            else
            {
                fromLab.Text = DateTime.Parse(yegData.Rows[rowIndexF]["periodfr"].ToString()).ToShortDateString();
            }
            string testperiodto = yegData.Rows[rowIndexF]["periodto"].ToString();
            if (testperiodto == "")
            {
                testperiodto = "no date";
                toLab.Text = testperiodto;
            }
            else
            {
                toLab.Text = DateTime.Parse(yegData.Rows[rowIndexF]["periodto"].ToString()).ToShortDateString();
            }

            //fromLab.Text = DateTime.Parse(yegData.Rows[rowIndex]["periodfr"].ToString()).ToShortDateString();
            //toLab.Text = DateTime.Parse(yegData.Rows[rowIndex]["periodto"].ToString()).ToShortDateString(); 

            yegAdapter.Dispose();
            yegCommand.Dispose();
            yegConnection.Close();

        }
        }
 
}