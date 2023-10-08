using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class SubmittedTenderDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void exit_Click(object sender, EventArgs e)
        {
            Response.Redirect("AllSubmittedTenders.aspx");
        }
    }
}