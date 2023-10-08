using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class AccountLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                bool ChangePassword = false;
                string tEmailAddress = username.Text.Trim();
                string tPassword = password.Text.Trim();
                bool isValid = IsValidEmail(tEmailAddress);
                if (isValid == false)
                {
                    error = true;
                    message = "Please enter a valid email address! It should be like test@gmail.com";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    var nav = new Config().ReturnNav();
                    var users = nav.DynasoftPortalUser.Where(r => r.Authentication_Email == tEmailAddress && r.Password_Value == tPassword);
                    Boolean exists = false;
                    foreach (var user in users)
                    {
                        exists = true;
                        ChangePassword = Convert.ToBoolean(user.Change_Password);
                        Session["name"] = user.Full_Name;
                        Session["email"] = user.Authentication_Email;
                        Session["vendorNo"] = user.Record_ID;
                        Session["employeeNo"] = user.Record_ID;
                        Session["user"] = user.Record_Type;
                        if (ChangePassword == false)
                        {
                            Response.Redirect("AccountChangePass.aspx");
                        }
                    }
                    if (!exists)
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>Kindly enter correct credentials to login.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        if(Session["user"].ToString() == "Employee")
                        {
                            Response.Redirect("EmployeeDashboard.aspx");
                        }
                        else
                        {
                            Response.Redirect("Dashboard.aspx");
                        }                     
                    }
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        public static bool IsValidEmail(string email)
        {
            string pattern = @"^(?!\.)(""([^""\r\\]|\\[""\r\\])*""|" + @"([-a-z0-9!#$%&'*+/=?^_`{|}~]|(?<!\.)\.)*)(?<!\.)" + @"@[a-z0-9][\w\.-]*[a-z0-9]\.[a-z][a-z\.]*[a-z]$";
            var regex = new Regex(pattern, RegexOptions.IgnoreCase);
            return regex.IsMatch(email);
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }
    }
}