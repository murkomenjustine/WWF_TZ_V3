using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WWF
{
    public partial class EvaluateTender : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                string cipherText = Request.QueryString["TenderNov1"];
                string TenderNo = Decrypt(cipherText);
                var data = nav.ProcurementRequest.Where(x => x.No == TenderNo).ToList();
                foreach (var item in data)
                {
                    evcomments.Text = item.Comments;
                }
            }
        }

        protected void submitapplication_Click(object sender, EventArgs e)
        {
            try
            {
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string cipherText = Request.QueryString["TenderNov1"];
                string TenderNo = Decrypt(cipherText);
                string status = Config.ObjNav.FnSubmitTenderEvaluation(TenderNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    pricingfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('SubmittedEvaluation.aspx') }, 10000);", true);
                }
                else
                {
                    pricingfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                pricingfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void back_Click(object sender, EventArgs e)
        {
            Response.Redirect("OpenTenderEvaluation.aspx");
        }

        protected void deletefile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Tender Evaluation Card/";
                String imprestNo = Convert.ToString(Session["employeeNo"]);
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder + imprestNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        pricingfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        pricingfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    pricingfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                pricingfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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

        protected void disqualifyvendor_Click(object sender, EventArgs e)
        {
            try
            {
                string vendorNo = Convert.ToString(Session["vendorNo"]);
                string cipherText = Request.QueryString["TenderNov1"];
                string TenderNo = Decrypt(cipherText);
                string tcomm = discomments.Text.Trim();
                string status = Config.ObjNav.FnTenderQualification(TenderNo, tcomm, false);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    evcomments.Text = tcomm;
                    pricingfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    pricingfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                pricingfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void qualifyvendor_Click(object sender, EventArgs e)
        {
            try
            {
                string employeeNo = Convert.ToString(Session["employeeNo"]);
                string ApplicationNumber = employeeNo;
                ApplicationNumber = ApplicationNumber.Replace('/', '_');
                ApplicationNumber = ApplicationNumber.Replace(':', '_');
                string path1 = Config.FilesLocation() + "Tender Evaluation Card/";
                string cipherText = Request.QueryString["TenderNov1"];
                string TenderNo = Decrypt(cipherText);
                string str1 = Convert.ToString(ApplicationNumber);
                string folderName = path1 + str1 + "/";

                if (filetoupload.HasFile)
                {
                    string extension = System.IO.Path.GetExtension(filetoupload.FileName);
                    string filename = ApplicationNumber + "_" + TenderNo + "_EVALUATION_REPORT" + extension;
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
                    Config.navExtender.AddLinkToRecord("Tender Evaluation Card", TenderNo, fullpath, "");
                    if (File.Exists(folderName + filename))
                    {
                        string tcomm = comments.Text.Trim();
                        string status = Config.ObjNav.FnTenderQualification(TenderNo, tcomm, true);
                        string[] info = status.Split('*');
                        if (info[0] == "success")
                        {
                            evcomments.Text = tcomm;
                            pricingfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else
                        {
                            pricingfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }
                    else
                    {
                        pricingfeedback.InnerHtml = "<div class='alert alert-danger'>The document evaluation report was not uploaded, kindly try again<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                pricingfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}