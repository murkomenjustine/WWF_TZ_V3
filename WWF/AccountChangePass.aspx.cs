using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class AccountChangePass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void changepassword_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tEmailAddress = username.Text.Trim();
                string tCurrentPass = password.Text.Trim();
                string tNewPass = pass1.Text.Trim();
                string tConfirmPass = pass2.Text.Trim();
                bool isValid = IsValidEmail(tEmailAddress);
                if (isValid == false)
                {
                    error = true;
                    message = "Please enter a valid email address like test@gmail.com";
                }
                else
                {
                    feedback.InnerHtml = "";
                }
                bool isValidpass = IsValidPassword(tNewPass);
                if (isValidpass == false)
                {
                    error = true;
                    message = "Please enter a strong password. The password must have upper, lower, digit and special characters.";
                }
                else
                {
                    feedback.InnerHtml = "";
                }
                if (tNewPass != tConfirmPass)
                {
                    error = true;
                    message = "Confirm password does not match new password.";
                }
                else
                {
                    feedback.InnerHtml = "";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    feedback.InnerHtml = "";
                    string status = Config.ObjNav.FnChangePassword(tEmailAddress, tCurrentPass, tNewPass, tConfirmPass);
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

        public static bool IsValidPassword(string password)
        {
            bool valid = false;
            HashSet<char> specialCharacters = new HashSet<char>() { '%', '$', '#' };
            if (password.Any(char.IsLower) &&
                 password.Any(char.IsUpper) &&
                 password.Any(char.IsDigit) &&
                 password.Any(specialCharacters.Contains))
            {
                valid = true;
            }
            return valid;
        }
    }
}