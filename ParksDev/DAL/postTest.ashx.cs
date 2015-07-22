using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ParksDev.DAL
{
    /// <summary>
    /// Summary description for postTest
    /// </summary>
    public class postTest : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;

            string whatToDo = forms.Get("oper");

            string ID = forms.Get("ID").ToString();
            string fName = forms.Get("FIRSTNAME").ToString();
            string lName = forms.Get("LASTNAME").ToString();
            string scoreA = forms.Get("SCOREA").ToString();
            string scoreB = forms.Get("SCOREB").ToString();
            string scoreC = forms.Get("SCOREC").ToString();


            if (whatToDo == "edit") { 
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

                SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();

                SqlCommand command = new SqlCommand("editTest", conn);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@ID", SqlDbType.VarChar).Value = ID;
                command.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = fName;
                command.Parameters.Add("@LastName", SqlDbType.VarChar).Value = lName;
                command.Parameters.Add("@ScoreA", SqlDbType.Int).Value = scoreA;
                command.Parameters.Add("@ScoreB", SqlDbType.Int).Value = scoreB;
                command.Parameters.Add("@ScoreC", SqlDbType.Int).Value = scoreC;

                command.ExecuteNonQuery();

                conn.Close();
                context.Response.Write("edited!");

                conn.Close();
                command.Dispose();
            }//end try
            catch (SqlException ex)
            {
                context.Response.Write(ex); //use context response write
            }
            }//end if
            else if (whatToDo == "add")
            {
                try{
                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

                SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();

                SqlCommand command = new SqlCommand("insertTest", conn);
                command.CommandType = CommandType.StoredProcedure;

          //      command.Parameters.Add("@ID", SqlDbType.VarChar).Value = ID;
                command.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = fName;
                command.Parameters.Add("@LastName", SqlDbType.VarChar).Value = lName;
                command.Parameters.Add("@ScoreA", SqlDbType.Int).Value = scoreA;
                command.Parameters.Add("@ScoreB", SqlDbType.Int).Value = scoreB;
                command.Parameters.Add("@ScoreC", SqlDbType.Int).Value = scoreC;

                command.ExecuteNonQuery();

                
                context.Response.Write(fName + " " + lName + "added");

                conn.Close();
                command.Dispose();
            }
            catch (SqlException ex)
            {
                context.Response.Write(ex); //use context response write
            }
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}