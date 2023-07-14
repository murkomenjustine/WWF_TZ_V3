using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class EmployeeProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                string emp = Convert.ToString(Session["employeeNo"]);
                var empls = nav.Employees.Where(x => x.No == emp);
                foreach (var user in empls)
                {
                    empNo.Text = user.No;
                    name.Text = user.First_Name + " " + user.Last_Name;
                    department.Text = user.Department;
                    jobtitle.Text = user.Job_Title;
                    gender.Text = user.Gender;
                    dateofbirth.Text = Convert.ToDateTime(user.Birth_Date).ToString("dd/MM/yyyy");
                    email.Text = user.Company_E_Mail;
                    phonenumber.Text = user.Mobile_Phone_No;
                    empstatus.Text = user.Status;
                    idno.Text = user.National_ID;
                }
            }
        }

        protected void backtodashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmployeeDashboard.aspx");
        }
    }
}