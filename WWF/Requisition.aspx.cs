using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class Requisition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("AccountLogin.aspx");
                }

                var nav = new Config().ReturnNav();
                String requisitionNo = "";
                try
                {
                    requisitionNo = Request.QueryString["requisitionNo"];
                    if (string.IsNullOrEmpty(requisitionNo))
                    {
                        requisitionNo = "";
                    }
                    else
                    {
                        var pHeader = nav.PurchaseHeader.Where(x => x.No == requisitionNo);
                        foreach (var user in pHeader)
                        {
                            tprocesstype.SelectedValue = user.Process_Type;
                            currency.Text = user.Currency_Code;
                            description.Text = user.Description;
                            location.SelectedValue = user.Location_Code;
                            project.SelectedValue = user.Shortcut_Dimension_1_Code;
                            prof_endDate.Text = Convert.ToDateTime(user.Due_Date).ToString("dd/MM/yyyy");
                        }
                    }
                }
                catch
                {
                    requisitionNo = "";
                }

                //dropdowns
                var procMethods = nav.ProcurementMethod;
                tprocesstype.DataSource = procMethods;
                tprocesstype.DataTextField = "Description";
                tprocesstype.DataValueField = "Code";
                tprocesstype.DataBind();

                var tcurrency = nav.Currencies;
                currency.DataSource = tcurrency;
                currency.DataTextField = "Description";
                currency.DataValueField = "Code";
                currency.DataBind();

                var tlocation = nav.Locations;
                location.DataSource = tlocation;
                location.DataTextField = "Name";
                location.DataValueField = "Code";
                location.DataBind();

                var tprojects = nav.DimensionValue.Where(x => x.Global_Dimension_No == 1);
                project.DataSource = tprojects;
                project.DataTextField = "Name";
                project.DataValueField = "Code";
                project.DataBind();

                var jobs = nav.TransactionCode;
                List<DropdownItems> allJobs = new List<DropdownItems>();
                foreach (var myJob in jobs)
                {
                    DropdownItems employee = new DropdownItems();
                    employee.Code = myJob.Code;
                    employee.Name = myJob.No + " - " + myJob.Description;
                    allJobs.Add(employee);
                }
                transactionDesc.DataSource = allJobs;
                transactionDesc.DataValueField = "Code";
                transactionDesc.DataTextField = "Name";
                transactionDesc.DataBind();

            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string emp = Convert.ToString(Session["employeeNo"]);
                string tdescription = description.Text.Trim();
                string ttprocesstype = tprocesstype.SelectedValue.Trim();
                string tcurrency = currency.SelectedValue.Trim();
                string tlocation = location.SelectedValue.Trim();
                string tproject = project.SelectedValue.Trim();
                string tprof_endDate = prof_endDate.Text.Trim();
                DateTime nduedate = new DateTime();
                try
                {
                    nduedate = DateTime.ParseExact(tprof_endDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please provide a valid date for due date";
                }
                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String requisitionNo = "";
                    try
                    {
                        requisitionNo = Request.QueryString["requisitionNo"];
                        if (string.IsNullOrEmpty(requisitionNo))
                        {
                            requisitionNo = "";
                        }
                        else
                        {
                            requisitionNo = Request.QueryString["requisitionNo"];
                        }
                    }
                    catch
                    {
                        requisitionNo = "";
                    }
                    String status = Config.ObjNav.FnCreateRequisition(requisitionNo, emp, tdescription, tlocation, tproject, tcurrency, ttprocesstype, nduedate);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        Response.Redirect("Requisition.aspx?step=2&&requisitionNo=" + requisitionNo);
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void addrequisitionlines_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string emp = Convert.ToString(Session["employeeNo"]);
                string ttransactionDesc = transactionDesc.SelectedValue.Trim();
                string ttxtdescription = txtdescription.Text.Trim();
                //int tstaff = Convert.ToInt32(staff.Text.Trim());
                int tquantityRequested = Convert.ToInt32(quantityRequested.Text.Trim());
                decimal tdirectUnitCost = Convert.ToDecimal(directUnitCost.Text.Trim());

                if (error)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String requisitionNo = Request.QueryString["requisitionNo"];

                    String status = Config.ObjNav.FnCreateRequisitionLine(requisitionNo, ttransactionDesc, tquantityRequested, 0, tdirectUnitCost, ttxtdescription);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void backtostepone_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("Requisition.aspx?step=1&&requisitionNo=" + requisitionNo);
        }

        protected void nexttostepthree_Click(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            String requisitionNo = Request.QueryString["requisitionNo"];
            int purhaseLines = nav.PurchaseLines.Where(r => r.Document_No == requisitionNo).ToList().Count;
            if (purhaseLines > 0)
            {
                Response.Redirect("Requisition.aspx?step=3&&requisitionNo=" + requisitionNo);
            }
            else
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>Kindly enter at least one purchase line to proceed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removelinebtn_Click(object sender, EventArgs e)
        {
            try
            {
                int tlineNo = Convert.ToInt32(lineNo.Text.Trim());
                String requisitionNo = Request.QueryString["requisitionNo"];

                String status = Config.ObjNav.DeleteRequisitionLine(requisitionNo, tlineNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Purchase Requisition Header/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["requisitionNo"];
                            string imprest = imprestNo;
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                            if (createDirectory)
                            {
                                string filename = documentDirectory + document.FileName;
                                if (File.Exists(filename))
                                {
                                    documentsfeedback.InnerHtml =
                                                                       "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }
                                else
                                {
                                    document.SaveAs(filename);
                                    if (File.Exists(filename))
                                    {
                                        Config.navExtender.AddLinkToRecord("Purchase Requisition Header", imprest, filename, "");
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                    else
                                    {
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                }
                            }
                        }
                        else
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception ex)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void deletefilebtn_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Purchase Requisition Header/";
                String imprestNo = Request.QueryString["requisitionNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder + imprestNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void backtosteptwo_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("Requisition.aspx?step=2&&requisitionNo=" + requisitionNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string emp = Convert.ToString(Session["employeeNo"]);
                String requisitionNo = Request.QueryString["requisitionNo"];
                if (error)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String status = Config.ObjNav.SendPurchaseRequisitionApproval(emp, requisitionNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}