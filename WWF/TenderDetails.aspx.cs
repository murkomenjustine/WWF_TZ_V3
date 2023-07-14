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
                var tenderDetails = nav.invitetoTenders.Where(x => x.Code == TenderNo).Take(1).ToList();
                foreach(var item in tenderDetails)
                {
                    //Tender General Details.
                    tenderno.Text = item.Code;
                    description.Text = item.Description;
                    targetbiddergroup.Text = item.Target_Bidder_Group;
                    bidselectionmethod.Text = item.Bid_Selection_Method;
                    requisitionprodgroup.Text = item.Requisition_Product_Group;
                    if(item.Mandatory_Special_Group_Reserv == true)
                    {
                        manspecialgroupreserv.Text = "YES";
                    }
                    else
                    {
                        manspecialgroupreserv.Text = "NO";
                    }
                    tenderexpirydate.Text = Convert.ToDateTime(item.Tender_Validity_Expiry_Date).ToString("dd/MM/yyyy");
                    location.Text = item.Location_Code;
                    tendervalidityduration.Text = item.Tender_Validity_Duration;
                    externaldocumentno.Text = item.External_Document_No;
                    bidenvelopetype.Text = item.Bid_Envelop_Type;
                    documentdate.Text = Convert.ToDateTime(item.Document_Date).ToString("dd/MM/yyyy");
                    mandatorymeeting.Text = Convert.ToDateTime(item.Mandatory_Pre_bid_Visit_Date).ToString("dd/MM/yyyy");

                    //Critical Submission Details
                    submissionstartdate.Text = Convert.ToDateTime(item.Submission_Start_Date).ToString("dd/MM/yyyy");
                    submissionstarttime.Text = item.Submission_Start_Time;
                    submissiondate.Text = Convert.ToDateTime(item.Submission_End_Date).ToString("dd/MM/yyyy");
                    submissiontime.Text = item.Submission_End_Time;
                    address2.Text = item.Address_2;
                    address.Text = item.Address;
                    prebidmeetingdate.Text = Convert.ToDateTime(item.Mandatory_Pre_bid_Visit_Date).ToString("dd/MM/yyyy");
                    prebidmeetingaddress.Text = item.Prebid_Meeting_Address;
                    country.Text = item.Country_Region_Code;
                    city.Text = item.City;
                    bidopeningdate.Text = Convert.ToDateTime(item.Bid_Opening_Date).ToString("dd/MM/yyyy");
                    bidopeningtime.Text = item.Bid_Opening_Time;
                    //bidopeningtime.Text = Convert.ToDateTime(item.Bid_Opening_Time).ToString("HH:mm:ss tt");
                    phonenum.Text = item.Phone_No;
                    bidopeningvunue.Text = item.Bid_Opening_Venue;
                    tenderboxlocation.Text = item.Tender_Box_Location_Code;
                    procurringentityname.Text = item.Procuring_Entity_Name_Contact;
                    primarytendersubmissionaddress.Text = item.Primary_Tender_Submission;
                    postalcode.Text = item.Post_Code;
                }
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

        protected void apply_Click(object sender, EventArgs e)
        {
            string cipherText = Request.QueryString["TenderNo"];
            Response.Redirect("TenderApplicationPage.aspx?TenderNo=" + cipherText);
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("TenderDetails.aspx");
        }
    }
}