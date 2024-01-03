<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AwardedTenderDetails.aspx.cs" Inherits="WWF.AwardedTenderDetails" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="WWF" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<%@ Import Namespace="System.Text" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>e-Procurement Portal</a></li>
            <li class="active">Tender Evaluation Page</li>
        </ol>
    </section>
    <%
        var nav = new Config().ReturnNav();
        string cipherText = Request.QueryString["TenderNo"];
        string currency = "";

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
        }
        catch (Exception ex)
        {

        }

        var tender = nav.ProcurementRequest.Where(x => x.No == cipherText).ToList();
        foreach (var item in tender)
        {
            currency = item.Currency_Code;
        }

    %>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-success">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>AWARDED TENDER DETAILS</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p>
                                    This is the page for awarded tender details. Kindly download the documents attached to view more details.
                                </p>
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- ./box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col -->
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                Attached Tender Documents By Vendor.
            </div>
            <div class="panel-body">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Document Title</th>
                            <th>Download</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try
                            {
                                String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Tender Evaluation Card/";
                                string vendorNum = Convert.ToString(Session["vendorNo"]);
                                string vendorNo = Request.QueryString["TenderNo"];;
                                vendorNo = vendorNo.Replace('/', '_');
                                vendorNo = vendorNo.Replace(':', '_');
                                String documentDirectory = filesFolder + vendorNo + "/";
                                if (Directory.Exists(documentDirectory))
                                {
                                    foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                    {
                                        String url = documentDirectory;
                                        //if (file.Replace(documentDirectory, "").Contains(vendorNum))
                                        //{
                        %>
                        <tr>
                            <td><%= file.Replace(documentDirectory, "")%></td>
                            <td><a href="DownloadVendorTenderDocs.aspx?applicationNo=<%=vendorNo %>&&fileName=<%=file.Replace(documentDirectory, "")%>" class="btn btn-success"><i class="fa fa-download"></i>Download</a></td>
                        </tr>
                        <%//}
                                    }
                                }
                            }
                            catch (Exception)
                            {

                            }%>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Exit This Page" ID="back1" CausesValidation="false" OnClick="back_Click"/>
            <div class="clearfix"></div>
        </div>
    </section>
</asp:Content>


