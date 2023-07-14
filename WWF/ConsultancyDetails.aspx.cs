using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class ConsultancyDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                string cipherText = Request.QueryString["TenderNo"];
                string tendorNo = Decrypt(cipherText);
                var nav = new Config().ReturnNav();
                var data = nav.invitetoTenders.Where(x=> x.Code == tendorNo).ToList();
                foreach(var t in data)
                {
                    name.Text = t.Tender_Name;
                    status.Text = "Open";
                    startdate.Text = Convert.ToDateTime(t.Submission_Start_Date).ToString("dd-MM-yyyy");
                    starttime.Text = Convert.ToDateTime(t.Submission_Start_Time).ToString("HH:mm tt");
                    enddate.Text = Convert.ToDateTime(t.Submission_End_Date).ToString("dd-MM-yyyy");
                    endtime.Text = Convert.ToDateTime(t.Submission_End_Time).ToString("HH:mm tt");
                    summary.Text = t.Tender_Summary;
                }
            }
        }

        protected void applyconsultancy_Click(object sender, EventArgs e)
        {
            try
            {
                string cipherText = Request.QueryString["TenderNo"];
                Response.Redirect("ConsultancyApplicationPage.aspx?TenderNo=" + cipherText);
            }
            catch (Exception ex)
            {

            }           
        }

        protected void cancelapplication_Click(object sender, EventArgs e)
        {
            Response.Redirect("ConsultantDashboard.aspx");
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