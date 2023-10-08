using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class TenderComments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                string tendorNo = Request.QueryString["tendorNo"];
                var data = nav.ProcurementRequest.Where(x => x.No == tendorNo).ToList();
                foreach (var item in data)
                {
                    tendorno.Text = item.No;
                    name.Text = item.Title;
                    vendorno.Text = item.Vendor_No+"-"+item.Selected_Bidder_Name;
                    if(item.Qualified == true)
                    {
                        status.Text = "Recommended";
                    }
                    else
                    {
                        status.Text = "Not Recommended";
                    }
                    comments.Text = item.Comments;
                }
            }
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AllSubmittedTenders.aspx");
        }
    }
}