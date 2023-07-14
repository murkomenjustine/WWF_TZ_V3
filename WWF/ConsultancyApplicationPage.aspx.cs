using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class ConsultancyApplicationPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string vendorNo = Convert.ToString(Session["vendorNo"]);
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var vendorgenaraldetails = nav.eProVendorQT.Where(x => x.No == vendorNo).ToList();
                foreach (var v in vendorgenaraldetails)
                {
                    consultantname.Text = v.Name;
                    emailaddress.Text = v.E_Mail;
                    phoneno.Text = v.Phone_No;
                    countryoforigin.Text = v.Country_Region_Code;
                    physicaladdress.Text = v.Address;
                    taxno.Text = v.VAT_Registration_No;
                }
            }
        }
    }
}