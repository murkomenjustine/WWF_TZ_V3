<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EvaluateTender.aspx.cs" Inherits="WWF.EvaluateTender" %>

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
        string cipherText = Request.QueryString["TenderNov1"];
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
                        <h3 class="box-title"><strong>TENDER EVALUATION FORM</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p>
                                    This is the page for tender evalauation. Kindly download the documents attached, then proceed to evalaute the tender.
                                </p>
                                <p>
                                    After evalauting the tender documents, kindly proceed to upload your final evaluation report.
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
        <div runat="server" id="pricingfeedback"></div>
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
                                string vendorNo = Request.QueryString["vendorNo"];
                                vendorNo = vendorNo.Replace('/', '_');
                                vendorNo = vendorNo.Replace(':', '_');
                                String documentDirectory = filesFolder + vendorNo + "/";
                                if (Directory.Exists(documentDirectory))
                                {
                                    foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                    {
                                        String url = documentDirectory;
                                        if (file.Replace(documentDirectory, "").Contains(cipherText))
                                        {
                        %>
                        <tr>
                            <td><%= file.Replace(documentDirectory, "")%></td>
                            <td><a href="DownloadVendorTenderDocs.aspx?applicationNo=<%=vendorNo %>&&fileName=<%=file.Replace(documentDirectory, "")%>" class="btn btn-success"><i class="fa fa-download"></i>Download</a></td>
                        </tr>
                        <%}
                                    }
                                }
                            }
                            catch (Exception)
                            {

                            }%>
                    </tbody>
                </table>
            </div>
            <div class="panel-footer">
                <label class="btn btn-danger pull-left" onclick="disqualify('<%="" %>');"><i class="fa fa-times"></i> Vendor Not Recommended</label>
                <label class="btn btn-success pull-right" onclick="Qualify('<%="" %>');"><i class="fa fa-check"></i>Recommended Vendor</label>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                Saved Evaluation Details.
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-12 col-sm-12">
                        <div class="form-group">
                            <strong>Evaluation Comments<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="evcomments" CssClass="form-control" TextMode="MultiLine" Height="50px" ReadOnly="true" />
                        </div>
                    </div>
                </div>
                <%
                    bool isQualified = false;
                    string empNo = "";
                    var data = nav.ProcurementRequest.Where(x => x.No == cipherText).ToList();
                    foreach (var item in data)
                    {
                        empNo = item.Asigned_User;
                        isQualified = Convert.ToBoolean(item.Qualified);
                    }
                    if (isQualified)
                    {
                %>
                        <div class="row">
            <div class="col-md-12">
                <div class="box box-success">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>Saved Evaluation Report</strong></h3>
                    </div>
                    <!-- ./box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col -->
        </div>
                <div class="row">
                    <div class="col-lg-12 col-sm-12">
                    <table id="example9" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Document Title</th>
                                <th>Download</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try
                                {
                                    String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                    String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Tender Evaluation Card/";
                                    string vendorNo = Convert.ToString(Session["employeeNo"]);
                                    vendorNo = vendorNo.Replace('/', '_');
                                    vendorNo = vendorNo.Replace(':', '_');
                                    String documentDirectory = filesFolder + vendorNo + "/";
                                    if (Directory.Exists(documentDirectory))
                                    {
                                        foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                        {
                                            String url = documentDirectory;
                                            if (file.Replace(documentDirectory, "").Contains(cipherText))
                                            {
                            %>
                            <tr>
                                <td><%= file.Replace(documentDirectory, "")%></td>
                                <td><a href="DownloadEvaluationReport.aspx?applicationNo=<%=vendorNo %>&&fileName=<%=file.Replace(documentDirectory, "")%>" class="btn btn-primary"><i class="fa fa-download"></i>Download</a></td>
                                <td>
                                    <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                            </tr>
                            <%}
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
                <%
                    }
                %>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit Evaluation" ID="submitapplication" CausesValidation="false" OnClick="submitapplication_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Back" ID="back" CausesValidation="false" OnClick="back_Click" />
            <div class="clearfix"></div>
        </div>
    </section>
    <script>
        function deleteFile(fname) {
            document.getElementById("filetoDeleteName").innerText = fname;
            document.getElementById("ContentPlaceHolder1_fileName").value = fname;
            $("#deleteFileModal").modal();
        }
        function Qualify(user) {
            $("#QualifyModal").modal();
        }
        function disqualify(user) {
            $("#disqualifyModal").modal();
        }
    </script>
    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deletefile" CausesValidation="false" OnClick="deletefile_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="QualifyModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Recommended Vendor</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                            <div class="form-group">
                                <strong>Comments (Maximum of 250 characters)<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="comments" CssClass="form-control" placeholder="Enter Comments Here..." TextMode="MultiLine" Height="50px" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Evaluation Report<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:FileUpload runat="server" ID="filetoupload" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Recommended Vendor" ID="qualifyvendor" CausesValidation="false" OnClick="qualifyvendor_Click" />
                </div>
            </div>
        </div>
    </div>
    <div id="disqualifyModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Vendor Not Recommended </h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="TextBox1" type="hidden" />
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                            <div class="form-group">
                                <strong>Comments (Maximum of 250 characters)<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="discomments" CssClass="form-control" placeholder="Enter Comments Here..." TextMode="MultiLine" Height="50px" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Not Recommended" ID="disqualifyvendor" CausesValidation="false" OnClick="disqualifyvendor_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

