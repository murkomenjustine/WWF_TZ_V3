using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class ProfileView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                var nav = new Config().ReturnNav();
                var vendorgenaraldetails = nav.eProVendorQT.Where(x => x.No == vendorNo).ToList();
                foreach (var v in vendorgenaraldetails)
                {
                    suppliername.Text = v.Name;
                    taxregistrationno.Text = v.VAT_Registration_No;
                    taxregistrationcountry.Text = v.Country_of_Incorporation;
                    registrationdate.Text = Convert.ToDateTime(v.Reg_Incorporation_Date).ToString("yyyy-MM-dd");
                    registrationincorporationno.Text = v.Registration_Incorporation_No;
                    businesstype.Text = v.Business_Type;
                    ownershiptype.Text = v.Ownership_Type;
                    industrygroup.Text = v.Industry_Group;
                    language.Text = v.Language_Code;
                    suppliertype.Text = v.Supplier_Type;
                    vision.Text = v.Vision_Statement;
                    mission.Text = v.Mission_Statement;
                    if (v.Special_Group == true)
                    {
                        specialgroup.Checked = true;
                        divspecialcategory.Visible = true;
                        var specialvendordetails = nav.VendorSpecialGroupEntry.Where(x => x.Vendor_No == vendorNo).ToList();
                        foreach (var s in specialvendordetails)
                        {
                            certificateno.Text = s.Certifcate_No;
                            suppliercategory.Text = s.Vendor_Category;
                            certifyingagaency.Text = s.Certifying_Agency;
                            productservice.Text = s.Products_Service_Category;
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

                var vendorcommcontactdetails = nav.eProVendorQT.Where(x => x.No == vendorNo).ToList();
                foreach (var v in vendorcommcontactdetails)
                {
                    address.Text = v.Address;
                    address2.Text = v.Address_2;
                    phone.Text = v.Phone_No;
                    email.Text = v.E_Mail;
                    buildinghouse.Text = v.Building_House_No;
                    floor.Text = v.Floor;
                    plot.Text = v.Plot_No;
                    street.Text = v.Street;
                }

                var vendorBusinessProfile = nav.eProVendorQT.Where(x => x.No == vendorNo).ToList();
                foreach (var v in vendorBusinessProfile)
                {
                    companysizex.Text = v.Company_Size;
                    nominalcapital.Text = Convert.ToString(v.Nominal_Capital_LCY);
                    dealertypex.Text = v.Dealer_Type;
                    maxvalueofbusiness.Text = Convert.ToString(v.Max_Value_of_Business);
                    businesprofilesuppliercategoryx.Text = v.Supplier_Category;
                    natureofbusiness.Text = v.Nature_of_Business;
                }
            }
        }
    }
}