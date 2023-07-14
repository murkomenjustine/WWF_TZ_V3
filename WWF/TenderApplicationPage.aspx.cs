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
    public partial class TenderApplicationPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                populateTotals();
                var nav = new Config().ReturnNav();
                var ptype = nav.ProcurementDocumentType.Where(x => x.Type == "Vendor");
                documenttoupload.DataSource = ptype;
                documenttoupload.DataTextField = "Description";
                documenttoupload.DataValueField = "Code";
                documenttoupload.DataBind();
            }
        }

        protected void addprice_Click(object sender, EventArgs e)
        {
            try
            {
                decimal gunitprice = Convert.ToDecimal(unitprice.Text.Trim());
                int glineno = Convert.ToInt32(lineno.Text.Trim());
                decimal gquantity = Convert.ToDecimal(nquantity.Text.Trim());
                decimal gtotalprice = (gunitprice * gquantity);
                string cipherText = Request.QueryString["TenderNo"];
                string TenderNo = Decrypt(cipherText);
                decimal totalexclusivevat = getTotalExclusiveVAT(TenderNo);
                decimal totalinclusivevat = getTotalInclusiveVAT(TenderNo);
                string status = Config.ObjNav.FnUpdateTenderLine(glineno, TenderNo, gunitprice, gtotalprice, totalinclusivevat, totalexclusivevat);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    populateTotals();
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

        private void populateTotals()
        {
            string TenderNo = Decrypt(Request.QueryString["TenderNo"]);
            var nav = new Config().ReturnNav();
            var tenderDetails = nav.invitetoTenders.Where(x => x.Code == TenderNo).Take(1).ToList();
            foreach (var item in tenderDetails)
            {
                totalvatexclusive.Text = Convert.ToDecimal(item.Total_VAT_Exclusive).ToString("#,##0.00");
                totalinclusivevat.Text = Convert.ToDecimal(item.Total_VAT_Inclusive).ToString("#,##0.00");
                vat.Text = Convert.ToDecimal(item.VAT_Rate).ToString("#,##0.00");
            }
        }

        public static decimal getTotalExclusiveVAT(string TenderNo)
        {
            var nav = new Config().ReturnNav();
            decimal totallineamount = 0;
            var query = nav.purchaseCodeLines.Where(x => x.Standard_Purchase_Code == TenderNo).ToList();
            foreach (var t in query)
            {
                totallineamount += Convert.ToDecimal(t.Total_Price);
            }

            return totallineamount;
        }
        public static decimal getTotalInclusiveVAT(string TenderNo)
        {
            decimal totalinclvat = 0;
            try
            {
                var nav = new Config().ReturnNav();
                decimal totallineamount = 0;
                decimal vatrate = 0;
                decimal vatamount = 0;
                
                var tenderDetails = nav.invitetoTenders.Where(x => x.Code == TenderNo).Take(1).ToList();
                foreach (var item in tenderDetails)
                {
                    vatrate = Convert.ToDecimal(item.VAT_Rate);
                }
                var query = nav.purchaseCodeLines.Where(x => x.Standard_Purchase_Code == TenderNo).ToList();
                foreach (var t in query)
                {
                    totallineamount += Convert.ToDecimal(t.Total_Price);
                }
                vatamount = (vatrate / 100) * totallineamount;
                totalinclvat = totallineamount - vatamount;
            }
            catch (Exception ex)
            {
                
            }
            return totalinclvat;
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