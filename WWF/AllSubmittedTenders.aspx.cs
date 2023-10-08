using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class AllSubmittedTenders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var jobst = nav.Employees;
                List<DropdownItems> allJobst = new List<DropdownItems>();
                foreach (var myJob in jobst)
                {
                    DropdownItems employee = new DropdownItems();
                    employee.Code = myJob.No;
                    employee.Name = myJob.First_Name + " " + myJob.Last_Name;
                    allJobst.Add(employee);
                }
                evaluator.DataSource = allJobst;
                evaluator.DataValueField = "Code";
                evaluator.DataTextField = "Name";
                evaluator.DataBind();

                evaltwo.DataSource = allJobst;
                evaltwo.DataValueField = "Code";
                evaltwo.DataTextField = "Name";
                evaltwo.DataBind();

                evalthree.DataSource = allJobst;
                evalthree.DataValueField = "Code";
                evalthree.DataTextField = "Name";
                evalthree.DataBind();

                evalfour.DataSource = allJobst;
                evalfour.DataValueField = "Code";
                evalfour.DataTextField = "Name";
                evalfour.DataBind();

                evalfive.DataSource = allJobst;
                evalfive.DataValueField = "Code";
                evalfive.DataTextField = "Name";
                evalfive.DataBind();

                evaluatormultiple.DataSource = allJobst;
                evaluatormultiple.DataValueField = "Code";
                evaluatormultiple.DataTextField = "Name";
                evaluatormultiple.DataBind();
            }
        }

        protected void assign_Click(object sender, EventArgs e)
        {
            try
            {
                string xtenderno = tenderno.Text.Trim();
                string xevaluator = evaluator.Text.Trim();
                string tsmstoeval = smstoeval.Text.Trim();
                string status = Config.ObjNav.FnAssignTender(xtenderno, xevaluator, "", "", "", "", tsmstoeval);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SubmitSelectedCoreInitiatives(List<SelectedCoreInitiatives> targetNumber)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (targetNumber == null)
                {
                    targetNumber = new List<SelectedCoreInitiatives>();
                }
                foreach (SelectedCoreInitiatives target in targetNumber)
                {
                    string tenderNo = target.TargetNumber;
                    string evaluator = target.SelectedUser;
                    string evaluator2 = target.SelectedUserTwo;
                    string evaluator3 = target.SelectedUserThree;
                    string evaluator4 = target.SelectedUserFour;
                    string evaluator5 = target.SelectedUserFive;
                    string sms = target.MessageEval;
                    var status = Config.ObjNav.FnAssignTender(tenderNo, evaluator, evaluator2, evaluator3, evaluator4, evaluator5, sms);
                    string[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        protected void award_Click(object sender, EventArgs e)
        {
            try
            {
                string xtenderno = atenderno.Text.Trim();
                string tcomm = acomments.Text.Trim();
                string status = Config.ObjNav.FnAwardTender(xtenderno, true);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void noaward_Click(object sender, EventArgs e)
        {
            try
            {
                string xtenderno = ntenderno.Text.Trim();
                string tcomm = ncomments.Text.Trim();
                string status = Config.ObjNav.FnAwardTender(xtenderno, false);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}