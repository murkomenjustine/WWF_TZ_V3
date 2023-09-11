using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }

        protected void register_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tapplicantbusinessname = applicantbusinessname.Text.Trim();
                string ttaxno = taxno.Text.Trim();
                string temail = email.Text.Trim().ToLower();
                string tphone = phone.Text.Trim();
                string tcontactperson = contactperson.Text.Trim();
                bool isValid = IsValidEmail(temail);
                if (isValid == false)
                {
                    error = true;
                    message = "Please enter a valid email address like test@gmail.com";
                }
                else
                {
                    feedback.InnerHtml = "";
                }
                if (tphone.Length > 13 || tphone.Length < 10)
                {
                    error = true;
                    message = "Please enter a valid phone number, it should be between 10 to 12 digits";
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
                    string status = Config.ObjNav.FnReqforRegistration(tapplicantbusinessname, tphone, temail, ttaxno, tcontactperson);
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

        protected void registeras_SelectedIndexChanged(object sender, EventArgs e)
        {
            string txtregister = registeras.SelectedValue;
            if(txtregister == "Supplier")
            {
                divvendor.Visible = true;
                divconsultant.Visible = false;
            }
            if (txtregister == "Consultant")
            {
                divvendor.Visible = false;
                divconsultant.Visible = true;
            }
            if (txtregister == "--Select--")
            {
                divvendor.Visible = false;
                divconsultant.Visible = false;
            }
        }
    }
}