﻿using System;
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
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["vendorNo"] == null)
                {
                    Response.Redirect("HomePage.aspx");
                }
                else
                {
                    string filesFolder = Server.MapPath("~/Passport/");
                    string employeeNo = Convert.ToString(Session["vendorNo"]);
                    string filename = filesFolder + employeeNo + ".png";
                    if (File.Exists(filename))
                    {
                        photosize.Visible = false;
                    }
                    else
                    {

                        photosize.InnerHtml = "<div class='alert alert-warning'>" + "Dear" + " " + Session["name"].ToString() + " " + "Kindly Upload your Passport Size Photo. <a href='ImageUpload.aspx'>Click here to upload logo / photo</a>" + "</div>";
                    }

                }
                string code = Decrypt(Request.QueryString["p"]);
                string user = Decrypt(Request.QueryString["u"]);
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