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

namespace ParksDev.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TextBox tb = (TextBox)LoginUser.FindControl("UserName");
            tb.Focus();

        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            //string usernname = Request.Form["UserName"];
            //TextBox tbUserName = (TextBox)LoginUser.FindControl("UserName");
            //string username = tbUserName.Text;

            //string username = this.LoginUser.UserName.Trim();

            //string password = this.LoginUser.Password.Trim();


            //TextBox tbPassword = (TextBox)LoginUser.FindControl("Password");
            //string password = tbPassword.Text;
            //CheckBox ckRemberMe =(CheckBox)LoginUser.FindControl("RememberMe");

            //if (ckRemberMe.Checked )
            //{
            //    HttpCookie mycookie = new HttpCookie("LoginDetail");
            //    mycookie.Values["Username"] = username;
            //    mycookie.Values["Password"] = password;

            //    mycookie.Expires = System.DateTime.Now.AddDays(1);

            //    Response.Cookies.Add(mycookie);


                
                
            //}
        }
    }
}
