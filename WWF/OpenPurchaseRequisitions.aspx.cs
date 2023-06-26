using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class OpenPurchaseRequisitions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void sendapproval_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string emp = Convert.ToString(Session["employeeNo"]);
                string tNo = imprestMemoToApprove.Text.Trim();
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String status = Config.ObjNav.SendPurchaseRequisitionApproval(emp, tNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void cancelapproval_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string emp = Convert.ToString(Session["employeeNo"]);
                string tNo = cancelImprestMemoNo.Text.Trim();
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String status = Config.ObjNav.CancelPurchaseRequisitionApproval(emp, tNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}