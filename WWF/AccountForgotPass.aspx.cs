using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class AccountForgotPass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void forgotpass_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tEmailAddress = username.Text.Trim();
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
                    string status = Config.ObjNav.FnResetPassword(tEmailAddress);
                    string[] info = status.Split('*');

                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                        "setTimeout(function() { window.location.replace('AccountLogin.aspx') }, 10000);", true);
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
    }
}