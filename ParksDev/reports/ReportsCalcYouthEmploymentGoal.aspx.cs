using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Globalization;
using System.Drawing;
using ParksDev;

namespace ParksDev.reports
{
    public partial class ReportsCalcYouthEmploymentGoal : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection thisConn = new SqlConnection(connectionString);
            thisConn.Open();
            SqlCommand thisCommand = new SqlCommand("SELECT * FROM [FOXPRODEV].[dbo].[GETcaraAGENCY]", thisConn);
            SqlDataReader thisReader = thisCommand.ExecuteReader();
            thisReader.Read();
            AgencyRepeater.DataSource = thisReader;
            AgencyRepeater.DataBind();
            thisConn.Close();



        }
        protected void repeatbound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                System.Data.Common.DbDataRecord crv = (System.Data.Common.DbDataRecord)e.Item.DataItem;
                int agecoder = Convert.ToInt32(crv["AGE_CODE"]);
                GridView RepeatGrid = (GridView)e.Item.FindControl("RepeatGrid");
                RepeatGrid.DataSource = GridData(agecoder);
                RepeatGrid.DataBind();
            }


        }
        public DataTable GridData(int agecoder)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;
            SqlConnection thisConn = new SqlConnection(connectionString);
            thisConn.Open();
            string agencyString = "SELECT * FROM [FOXPRODEV].[dbo].[AGENFUNDS] a inner join [FOXPRODEV].[dbo].[FUNDTYPES] b ON a.FTP_CODE = b.FTP_CODE inner join FOXPRODEV.dbo.GETcaraAGENCY c on a.AGE_CODE = c.AGE_CODE where a.AGE_CODE =" + agecoder + "ORDER BY b.FTP_CODE ASC";
            SqlCommand thisCommand = new SqlCommand(agencyString, thisConn);
            SqlDataAdapter da = new SqlDataAdapter(thisCommand);
            DataTable dt = new DataTable();
            da.Fill(dt);
            thisConn.Close();
            return dt;
        }


    }
}
