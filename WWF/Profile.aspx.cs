using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int step = 1;
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"]);
                if (step > 6 || step < 1)
                {
                    step = 1;
                }
            }
            catch (Exception)
            {
                step = 1;
            }
            string vendorNo = Convert.ToString(Session["vendorNo"]);
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                //step 1
                if (step == 1)
                {
                    //dropdowns for general
                    var dcountry = nav.Countries;
                    taxregistrationcountry.DataSource = dcountry;
                    taxregistrationcountry.DataTextField = "Name";
                    taxregistrationcountry.DataValueField = "Code";
                    taxregistrationcountry.DataBind();

                    var dsuppliercategorys = nav.SupplierCategory;
                    businesprofilesuppliercategory.DataSource = dsuppliercategorys;
                    businesprofilesuppliercategory.DataTextField = "Description";
                    businesprofilesuppliercategory.DataValueField = "Category_Code";
                    businesprofilesuppliercategory.DataBind();

                    //dropdowns for special group
                    var dsuppliercategory = nav.SpecialGroupCategories;
                    suppliercategory.DataSource = dsuppliercategory;
                    suppliercategory.DataTextField = "Description";
                    suppliercategory.DataValueField = "Code";
                    suppliercategory.DataBind();

                    var dcertifyingagaency = nav.Contact;
                    certifyingagaency.DataSource = dcertifyingagaency;
                    certifyingagaency.DataTextField = "Name";
                    certifyingagaency.DataValueField = "No";
                    certifyingagaency.DataBind();

                    //saved data load
                    var vendorgenaraldetails = nav.eProVendorQT.Where(x => x.No == vendorNo).ToList();
                    foreach(var v in vendorgenaraldetails)
                    {
                        suppliername.Text = v.Name;
                        taxregistrationno.Text = v.VAT_Registration_No;
                        taxregistrationcountry.SelectedValue = v.Country_of_Incorporation;
                        registrationdate.Text = Convert.ToDateTime(v.Reg_Incorporation_Date).ToString("yyyy-MM-dd");
                        registrationincorporationno.Text = v.Registration_Incorporation_No;
                        ownershiptype.SelectedValue = v.Ownership_Type;
                        languages.Text = "English";
                        vision.Text = v.Vision_Statement;
                        mission.Text = v.Mission_Statement;
                        if(v.Special_Group == true)
                        {
                            specialgroup.Checked = true;
                            divspecialcategory.Visible = true;
                            var specialvendordetails = nav.VendorSpecialGroupEntry.Where(x => x.Vendor_No == vendorNo).ToList();
                            foreach(var s in specialvendordetails)
                            {
                                certificateno.Text = s.Certifcate_No;
                                suppliercategory.SelectedValue = s.Vendor_Category;
                                certifyingagaency.SelectedValue = s.Certifying_Agency;
                                productservices.Text = s.Products_Service_Category;
                                certificateeffectivedate.Text = Convert.ToDateTime(s.Effective_Date).ToString("yyyy-MM-dd");
                                certificateexpirydate.Text = Convert.ToDateTime(s.Certificate_Expiry_Date).ToString("yyyy-MM-dd");
                            }

                        }
                        else
                        {
                            specialgroup.Checked = false;
                            divspecialcategory.Visible = false;
                        }
                    }
                }

                //step 2
                if(step == 2)
                {
                    var vendorcommcontactdetails = nav.eProVendorQT.Where(x => x.No == vendorNo).ToList();
                    foreach (var v in vendorcommcontactdetails)
                    {
                        address.Text = v.Address;
                        address2.Text = v.Address_2;
                        phone.Text = v.Phone_No;
                        email.Text = v.E_Mail;
                        buildinghouse.Text = v.Building_House_No;
                    }
                }

                //step 5
                if (step == 5)
                {
                    var dcountry = nav.Countries;
                    staffsnationality1.DataSource = dcountry;
                    staffsnationality1.DataTextField = "Name";
                    staffsnationality1.DataValueField = "Name";
                    staffsnationality1.DataBind();
                }

                //step 6
                if (step == 6)
                {
                    var ptype = nav.ProcurementDocumentType.Where(x => x.Type == "Vendor");
                    documenttoupload.DataSource = ptype;
                    documenttoupload.DataTextField = "Description";
                    documenttoupload.DataValueField = "Code";
                    documenttoupload.DataBind();
                }
            }
        }

        protected void specialgroup_CheckedChanged(object sender, EventArgs e)
        {
            if(specialgroup.Checked == true)
            {
                divspecialcategory.Visible = true;
            }
            else
            {
                divspecialcategory.Visible = false;
            }
        }

        protected void generaldetails_Click(object sender, EventArgs e)
        {
            try
            {
                bool flag = false;
                string err = "";
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string gsuppliername = suppliername.Text.Trim();
                string gtaxregistrationno = taxregistrationno.Text.Trim();
                string gtaxregistrationcountry = taxregistrationcountry.SelectedValue.Trim();
                string s = Convert.ToDateTime(registrationdate.Text.Trim()).ToString("yyyy-MM-dd");
                DateTime gregistrationdate = DateTime.ParseExact(s, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                string gregistrationincorporationno = registrationincorporationno.Text.Trim();
                string nownershiptype = ownershiptype.SelectedValue.Trim();
                string gbusinesprofilesuppliercategory = businesprofilesuppliercategory.SelectedValue.Trim();
                int gownershiptype = 0;
                if (nownershiptype == "Sole Ownership.Partnership")
                {
                    gownershiptype = 1;
                }
                if (nownershiptype == "Registered Company")
                {
                    gownershiptype = 2;
                }
                string glanguage = languages.Text.Trim();
                string gvision = vision.Text.Trim();
                string gmission = mission.Text.Trim();
                bool isspecialgroup = false;
                if (specialgroup.Checked == true)
                {
                    isspecialgroup = true;
                    string scertificateno = certificateno.Text.Trim();
                    string ssuppliercategory = suppliercategory.SelectedValue.Trim();
                    string scertifyingagaency = certifyingagaency.SelectedValue.Trim();
                    string sproductservices = productservices.Text.Trim();
                    string se = Convert.ToDateTime(certificateeffectivedate.Text.Trim()).ToString("yyyy-MM-dd");
                    DateTime scertificateeffectivedate = DateTime.ParseExact(se, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    string sx = Convert.ToDateTime(certificateexpirydate.Text.Trim()).ToString("yyyy-MM-dd");
                    DateTime scertificateexpirydate = DateTime.ParseExact(sx, "yyyy-MM-dd", CultureInfo.InvariantCulture);

                    string special = Config.ObjNav.FnSupplierSpecialGroup(vendorNo, scertificateno, ssuppliercategory, scertifyingagaency, sproductservices, scertificateeffectivedate, scertificateexpirydate);
                    string[] res = special.Split('*');
                    if (res[0] != "success")
                    {
                        flag = true;
                        err =  res[1];
                    }
                }
                else
                {
                    isspecialgroup = false;
                }
                
                if(flag)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + err + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    flag = false;
                    err = "";
                    string status = Config.ObjNav.FnSupplierGeneralDetails(vendorNo, gsuppliername, gtaxregistrationno, gtaxregistrationcountry, gregistrationdate, gregistrationincorporationno, gownershiptype, glanguage, gbusinesprofilesuppliercategory, gvision, gmission, isspecialgroup);
                    string[] info = status.Split('*');

                    if (info[0] == "success")
                    {
                        Response.Redirect("Profile.aspx?step=2");
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

        protected void communicationcontactdetails_Click(object sender, EventArgs e)
        {
            try
            {
                string gaddress = address.Text.Trim();
                string gaddress2 = address2.Text.Trim();
                string gphone = phone.Text.Trim();
                string gemail = email.Text.Trim();
                string gbuildinghouse = buildinghouse.Text.Trim();

                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnCommContactDetails(vendorNo, gaddress, gaddress2, gphone, gemail, gbuildinghouse, "", "", "");
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    Response.Redirect("Profile.aspx?step=3");
                }
                else
                {
                    communicationfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                communicationfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void back_Click(object sender, EventArgs e)
        {
            try
            {
                int step = Convert.ToInt32(Request.QueryString["step"]);
                int toStep = step - 1;

                Response.Redirect("Profile.aspx?step=" + Convert.ToString(toStep));
            }
            catch
            {
                
            }
        }

        protected void savebankdetails_Click(object sender, EventArgs e)
        {
            try
            {
                string gbankcode = bankcodes.Text.Trim();
                string gbankname = bankname.Text.Trim();
                string gbankbranchs = bankbranchs.Text.Trim();
                string gbankaccountno = bankaccountno.Text.Trim();

                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnInsertBankDetails(vendorNo, gbankcode, gbankname, gbankbranchs, gbankaccountno);
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    bankprofilefeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    bankprofilefeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                bankprofilefeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removebank_Click(object sender, EventArgs e)
        {
            try
            {
                string gbankcode = bankcode.Text.Trim();
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnDeleteBankDetails(vendorNo, gbankcode);
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    bankprofilefeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    bankprofilefeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                bankprofilefeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void editbank_Click(object sender, EventArgs e)
        {
            try
            {
                string gbankcode = modalbankcode.Text.Trim();
                string gbankname = modalbankname.Text.Trim();
                string gbankbranchs = modalbankbranch.Text.Trim();
                string gbankaccountno = modalbankaccountno.Text.Trim();

                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnEditBankDetails(vendorNo, gbankcode, gbankname, gbankbranchs, gbankaccountno);
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    bankprofilefeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    bankprofilefeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                bankprofilefeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void nexttostepfive_Click(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            string vendorNo = Convert.ToString(Session["vendorNo"]);
            int bankData = nav.VendorBankAccounts.Where(r => r.Vendor_No == vendorNo).ToList().Count;
            if(bankData > 0)
            {
                Response.Redirect("Profile.aspx?step=4");
            }
            else
            {
                bankprofilefeedback.InnerHtml = "<div class='alert alert-danger'>Kindly enter at least one bank record to proceed.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void pastexperiencedetails_Click(object sender, EventArgs e)
        {
            try
            {
                string gclientname = clientname.Text.Trim();
                string gassignmentproject = assignmentproject.Text.Trim();
                string s = Convert.ToDateTime(projectstartdate.Text.Trim()).ToString("yyyy-MM-dd");
                DateTime gprojectstartdate = DateTime.ParseExact(s, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                string enddate = Convert.ToDateTime(projectenddate.Text.Trim()).ToString("yyyy-MM-dd");
                DateTime gprojectenddate = DateTime.ParseExact(enddate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                string gprojectscopesummary = projectscopesummary.Text.Trim();
                string gcontactrefno = contactrefno.Text.Trim();
                string gprojectaddress = projectaddress.Text.Trim();
                decimal gprojectvalue = Convert.ToDecimal(projectvalue.Text.Trim());
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnInsertPastExperience(vendorNo, gclientname, gassignmentproject, gprojectstartdate, gprojectenddate, gprojectscopesummary, gcontactrefno, gprojectaddress, gprojectvalue);
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    pastexperiencefeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    pastexperiencefeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                pastexperiencefeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removepastexperience_Click(object sender, EventArgs e)
        {
            try
            {
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                int lineno = Convert.ToInt32(pastexpId.Text.Trim());
                string status = Config.ObjNav.FnDeletePastExperience(vendorNo, lineno);
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    pastexperiencefeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    pastexperiencefeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                pastexperiencefeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void editpastexperience_Click(object sender, EventArgs e)
        {
            try
            {
                string gclientname = peClientName.Text.Trim();
                string gassignmentproject = peAssignmentName.Text.Trim();
                string s = Convert.ToDateTime(peAssignmentStartDate.Text.Trim()).ToString("yyyy-MM-dd");
                DateTime gprojectstartdate = DateTime.ParseExact(s, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                string enddate = Convert.ToDateTime(peAssignmentEndDate.Text.Trim()).ToString("yyyy-MM-dd");
                DateTime gprojectenddate = DateTime.ParseExact(enddate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                string gprojectscopesummary = peProjectScopeSummary.Text.Trim();
                string gcontactrefno = peContractRefNo.Text.Trim();
                string gprojectaddress = peAddress.Text.Trim();
                decimal gprojectvalue = Convert.ToDecimal(peAssignmentValueLCY.Text.Trim());
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                int lineno = Convert.ToInt32(peEntryNo.Text.Trim());
                string status = Config.ObjNav.FnEditPastExperience(vendorNo, lineno, gclientname, gassignmentproject, gprojectstartdate, gprojectenddate, gprojectscopesummary, gcontactrefno, gprojectaddress, gprojectvalue);
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    pastexperiencefeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    pastexperiencefeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                pastexperiencefeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void nexttostepseven_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx?step=5");
        }

        protected void skippastexperience_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx?step=5");
        }

        protected void staffdetails_Click(object sender, EventArgs e)
        {
            try
            {
                string gstaffnumber = "";
                string gstaffname = staffname.Text.Trim();
                string gprofession = profession.Text.Trim();
                string gcurrentdesignation = designation.Text.Trim();
                string ndateofbirth = Convert.ToDateTime(DateTime.Now).ToString("yyyy-MM-dd");
                DateTime gdateofbirth = DateTime.ParseExact(ndateofbirth, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                string njoiningdate = Convert.ToDateTime(joiningdate.Text.Trim()).ToString("yyyy-MM-dd");
                DateTime gjoiningdate = DateTime.ParseExact(njoiningdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                int gyearsinthefirm = Convert.ToInt32(yearsinthefirm.Text.Trim());
                string gstaffphonenumber = staffphonenumber.Text.Trim();
                string gstaffnationality = staffsnationality1.SelectedValue.Trim();
                string gstaffemail = staffemail.Text.Trim();
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnInsertStaff(vendorNo, gstaffnumber, gstaffname, gprofession, gcurrentdesignation, gdateofbirth, gjoiningdate, gyearsinthefirm, gstaffphonenumber, gstaffnationality, gstaffemail);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    keystafffeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    keystafffeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                keystafffeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void editkeystaff_Click(object sender, EventArgs e)
        {
            try
            {
                string gstaffnumber = ksStaffNumber.Text.Trim();
                string gstaffname = ksStaffName.Text.Trim();
                string gprofession = ksProffesion.Text.Trim();
                string gcurrentdesignation = ksCurrentDesignation.Text.Trim();
                string ndateofbirth = Convert.ToDateTime(ksDateofBirth.Text.Trim()).ToString("yyyy-MM-dd");
                DateTime gdateofbirth = DateTime.ParseExact(ndateofbirth, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                string njoiningdate = Convert.ToDateTime(ksJoiningDate.Text.Trim()).ToString("yyyy-MM-dd");
                DateTime gjoiningdate = DateTime.ParseExact(njoiningdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                int gyearsinthefirm = Convert.ToInt32(ksYearsWiththeFirm.Text.Trim());
                string gstaffphonenumber = ksPhoneNo.Text.Trim();
                string gstaffnationality = ksNationality.Text.Trim();
                string gstaffemail = ksEMail.Text.Trim();
                int lineno = Convert.ToInt32(ksEntryNo.Text.Trim());
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnEditStaff(vendorNo, lineno, gstaffnumber, gstaffname, gprofession, gcurrentdesignation, gdateofbirth, gjoiningdate, gyearsinthefirm, gstaffphonenumber, gstaffnationality, gstaffemail);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    keystafffeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    keystafffeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                keystafffeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removekeystaff_Click(object sender, EventArgs e)
        {
            try
            {
                int lineno = Convert.ToInt32(ksEntryNo.Text.Trim());
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string status = Config.ObjNav.FnDeleteStaff(vendorNo, lineno);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    keystafffeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    keystafffeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                keystafffeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void nexttostepeight_Click(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            string vendorNo = Convert.ToString(Session["vendorNo"]);
            int keysatffdata = nav.VendorProffessionalStaff.Where(r => r.Vendor_No == vendorNo).ToList().Count;
            if (keysatffdata > 0)
            {
                Response.Redirect("Profile.aspx?step=6");
            }
            else
            {
                keystafffeedback.InnerHtml = "<div class='alert alert-danger'>Kindly enter at least one key staff record to proceed.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void documentuploaddetails_Click(object sender, EventArgs e)
        {
            try
            {
                string gdocumenttoupload = documenttoupload.SelectedValue.Trim();
                string gexternaldocumentno = externaldocumentno.Text.Trim();
                string nissuedate = Convert.ToDateTime(issuedate.Text.Trim()).ToString("yyyy-MM-dd");
                DateTime gissuedate = DateTime.ParseExact(nissuedate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                string nexpirydate = Convert.ToDateTime(expirydate.Text.Trim()).ToString("yyyy-MM-dd");
                DateTime gexpirydate = DateTime.ParseExact(nexpirydate, "yyyy-MM-dd", CultureInfo.InvariantCulture);

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
                    string filename = ApplicationNumber +"_" + gdocumenttoupload + extension;
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
                    string status = Config.ObjNav.FnInsertVendorRegDocs(vendorNo, gdocumenttoupload, gexternaldocumentno, gissuedate, gexpirydate, filename, fullpath);
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
                    "setTimeout(function() { window.location.replace('ProfileView.aspx') }, 10000);", true);
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