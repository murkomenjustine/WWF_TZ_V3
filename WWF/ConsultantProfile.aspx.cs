using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class ConsultantProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int step = 1;
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"]);
                if (step > 8 || step < 1)
                {
                    step = 1;
                }
            }
            catch (Exception)
            {
                step = 1;
            }
            string vendorNo = Convert.ToString(Session["vendorNo"]);
            if(!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                //step 1
                if (step == 1)
                {
                    //dropdowns for general
                    var dcountry = nav.Countries;
                    countryoforigin.DataSource = dcountry;
                    countryoforigin.DataTextField = "Name";
                    countryoforigin.DataValueField = "Code";
                    countryoforigin.DataBind();

                    //saved data load
                    var vendorgenaraldetails = nav.eProVendorQT.Where(x => x.No == vendorNo).ToList();
                    foreach (var v in vendorgenaraldetails)
                    {
                        consultantname.Text = v.Name;
                        emailaddress.Text = v.E_Mail;
                        phoneno.Text = v.Phone_No;
                        countryoforigin.SelectedValue = v.Country_Region_Code;
                        physicaladdress.Text = v.Address;
                        taxno.Text = v.VAT_Registration_No;
                    }
                }
                if (step == 5)
                {
                    var ptype = nav.ProcurementDocumentType.Where(x=> x.Type == "Consultant");
                    documenttoupload.DataSource = ptype;
                    documenttoupload.DataTextField = "Description";
                    documenttoupload.DataValueField = "Code";
                    documenttoupload.DataBind();
                }
            }
        }

        protected void generaldetails_Click(object sender, EventArgs e)
        {
            try
            {
                string gconsultantname = consultantname.Text.Trim();
                string gemailaddress = emailaddress.Text.Trim();
                string gphoneno = phoneno.Text.Trim();
                string gcountryoforigin = countryoforigin.SelectedValue.Trim();
                string gphysicaladdress = physicaladdress.Text.Trim();
                string gtaxno = taxno.Text.Trim();

                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnConsultantGeneralDetails(vendorNo, gconsultantname, gphoneno, gcountryoforigin, gemailaddress, gphysicaladdress, gtaxno);
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    Response.Redirect("ConsultantProfile.aspx?step=2");
                }
                else
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void savequalification_Click(object sender, EventArgs e)
        {
            try
            {
                string gqualification = qualification.Text.Trim();
                int gyearattained = Convert.ToInt32(yearattained.Text.Trim());
                int gduration = Convert.ToInt32(duration.Text.Trim());

                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnInsertConsultantQualification(vendorNo, gqualification, gyearattained, gduration);
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    qualificationfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    qualificationfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                qualificationfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void back_Click(object sender, EventArgs e)
        {
            try
            {
                int step = Convert.ToInt32(Request.QueryString["step"]);
                int toStep = step - 1;

                Response.Redirect("ConsultantProfile.aspx?step=" + Convert.ToString(toStep));
            }
            catch (Exception ex)
            {
                
            }
        }

        protected void nexttostep3_Click(object sender, EventArgs e)
        {
            try
            {
                var nav = new Config().ReturnNav();
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                int qualData = nav.ConsultantQualification.Where(r => r.VendoNo == vendorNo).ToList().Count;
                if (qualData > 0)
                {
                    Response.Redirect("ConsultantProfile.aspx?step=3");
                }
                else
                {
                    qualificationfeedback.InnerHtml = "<div class='alert alert-danger'>Kindly enter at least one qualification record to proceed.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch
            {

            }
        }

        protected void savereferee_Click(object sender, EventArgs e)
        {
            try
            {
                string grefname = refname.Text.Trim();
                int grefphone = Convert.ToInt32(refphone.Text.Trim());
                string grefemail = refemail.Text.Trim();

                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnInsertConsultantReferee(vendorNo, grefname, grefphone, grefemail);
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    refereeFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    refereeFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                refereeFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void nexttostep4_Click(object sender, EventArgs e)
        {
            Response.Redirect("ConsultantProfile.aspx?step=4");
        }

        protected void nexttostep5_Click(object sender, EventArgs e)
        {
            try
            {
                var nav = new Config().ReturnNav();
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                int refereeData = nav.ConsultantReferee.Where(r => r.VendorNo == vendorNo).ToList().Count;
                if (refereeData > 0)
                {
                    Response.Redirect("ConsultantProfile.aspx?step=5");
                }
                else
                {
                    refereeFeedback.InnerHtml = "<div class='alert alert-danger'>Kindly enter at least one referee record to proceed.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch
            {

            }
        }

        protected void submitprofiledetails_Click(object sender, EventArgs e)
        {
            try
            {
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnSubmitProfile(vendorNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('ConsultantProfileView.aspx') }, 10000);", true);
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void documentuploaddetails_Click(object sender, EventArgs e)
        {
            try
            {
                string gdocumenttoupload = documenttoupload.SelectedValue.Trim();

                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string ApplicationNumber = vendorNo;
                ApplicationNumber = ApplicationNumber.Replace('/', '_');
                ApplicationNumber = ApplicationNumber.Replace(':', '_');
                string path1 = Config.FilesLocation() + "Vendor Registration Card/";
                string str1 = Convert.ToString(ApplicationNumber);
                string folderName = path1 + str1 + "/";

                if (filetoupload.HasFile)
                {
                    string extension = System.IO.Path.GetExtension(filetoupload.FileName);
                    string filename = ApplicationNumber + "_" + gdocumenttoupload + extension;
                    string fullpath = folderName + filename;
                    if (!Directory.Exists(folderName))
                    {
                        Directory.CreateDirectory(folderName);
                    }
                    if (File.Exists(folderName + filename))
                    {
                        File.Delete(folderName + filename);
                    }
                    filetoupload.SaveAs(folderName + filename);
                    Config.navExtender.AddLinkToRecord("Vendor Registration Card", ApplicationNumber, fullpath, "");

                    //save details to table
                    string status = Config.ObjNav.FnInsertConsultantRegDocs(vendorNo, gdocumenttoupload, filename, fullpath);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removedocumnebt_Click(object sender, EventArgs e)
        {
            try
            {
                int lineno = Convert.ToInt32(docid.Text.Trim());
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnDeleteVendorRegDocs(vendorNo, lineno);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}