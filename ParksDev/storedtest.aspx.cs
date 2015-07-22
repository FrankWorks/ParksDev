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
    public partial class storedtest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void InsertCommand(object sender, EventArgs e)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["FoxProDevConnectionString"].ConnectionString;

                SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();

                SqlCommand command = new SqlCommand("insertTest", conn);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = first.Text;
                command.Parameters.Add("@LastName", SqlDbType.VarChar).Value = last.Text;
                command.Parameters.Add("@ScoreA", SqlDbType.Int).Value = ScoreA.Text;
                command.Parameters.Add("@ScoreB", SqlDbType.Int).Value = ScoreB.Text;
                command.Parameters.Add("@ScoreC", SqlDbType.Int).Value = ScoreC.Text;

                command.ExecuteNonQuery();

                conn.Close();
            }
            catch (SqlException ex)
            {
                Response.Write(ex);
            }
        }
    }
}