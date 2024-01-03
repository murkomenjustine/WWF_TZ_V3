using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace WWF
{
    public partial class TenderDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string TenderNo = Decrypt(Request.QueryString["TenderNo"]);
                var nav = new Config().ReturnNav();
                var tenderDetails = nav.ProcurementRequest.Where(x => x.No == TenderNo).ToList();
                foreach(var item in tenderDetails)
                {
                    //Tender General Details.
                    description.Text = item.Title;
                    proposaltype.Text = item.Tender_Type;
                    suppliercategory.Text = item.Supplier_Category;
                    validperiod.Text = item.Validity_Period;
                    startdate.Text = Convert.ToDateTime(item.Submission_Start_Date).ToString("dd/MM/yyyy");
                    starttime.Text = Convert.ToDateTime(item.Submission_Start_Time).ToString("HH:mm tt");
                    enddate.Text = Convert.ToDateTime(item.Submission_End_Date).ToString("dd/MM/yyyy");
                    endtime.Text = Convert.ToDateTime(item.Submission_End_Time).ToString("HH:mm tt");
                }
            }
        }

        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {
                var nav = new Config().ReturnNav();                
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string cipherText = Request.QueryString["TenderNo"];
                string TenderNo = Decrypt(cipherText);
                int tenderDetails = nav.ProcurementRequest.Where(x => x.Parent_TendorNo == TenderNo && x.Vendor_No == vendorNo).ToList().Count;
                if(tenderDetails > 0)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>You have already applied for this tender, if the earlier application was incomplete, navigate to (Unsubmitted Tenders) on the left side of the portal to complete application.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = Config.ObjNav.FnCreateNewTender(vendorNo, TenderNo);
                    string[] info = status.Split('*');

                    if (info[0] == "success")
                    {
                        string TenderNov1 = Encrypt(info[2]);
                        Response.Redirect("TenderApplicationPagev1.aspx?TenderNov1=" + TenderNov1);
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

        protected void cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }

        public static string Encrypt(string clearText)
        {
            try
            {
                string EncryptionKey = "@Test";
                byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                        {
                            cs.Write(clearBytes, 0, clearBytes.Length);
                            cs.Close();
                        }
                        clearText = Convert.ToBase64String(ms.ToArray());
                    }
                }
                return clearText;
            }
            catch (Exception ex)
            {
                //Log.writeLog(ex);
                return null;
            }
        }

        public static string Decrypt(string cipherText)
        {
            try
            {
                string EncryptionKey = "@Test";
                cipherText = cipherText.Replace(" ", "+");
                byte[] cipherBytes = Convert.FromBase64String(cipherText);
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                        {
                            cs.Write(cipherBytes, 0, cipherBytes.Length);
                            cs.Close();
                        }
                        cipherText = Encoding.Unicode.GetString(ms.ToArray());
                    }
                }
                return cipherText;
            }
            catch (Exception ex)
            {
                //Log.writeLog(ex);
                return null;
            }
        }
    }
}