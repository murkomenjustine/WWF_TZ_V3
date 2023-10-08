<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TenderApplicationPagev1.aspx.cs" Inherits="WWF.TenderApplicationPagev1" %>

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
            <li class="active">Tender Application Page</li>
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
                        <h3 class="box-title"><strong>TENDER APPLICATION FORM</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p>
                                    This is the final page of the application process. Kindly fill all details before submitting your application.
                                </p>
                                <p>
                                    The currency to be used when quaoting pricing is: <strong style="color: red"><%=currency %></strong>
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
                Document Upload. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Document To Upload<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="documenttoupload" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="documenttoupload" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Select Document<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:FileUpload runat="server" ID="filetoupload" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="filetoupload" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Click Here To Upload Document" ID="documentuploaddetails" OnClick="documentuploaddetails_Click" />
                    <div class="clearfix"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title"><strong>Saved Documents List</strong></h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-md-12">
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
                                                        string vendorNo = Convert.ToString(Session["vendorNo"]);
                                                        vendorNo = vendorNo.Replace('/', '_');
                                                        vendorNo = vendorNo.Replace(':', '_');
                                                        String documentDirectory = filesFolder + vendorNo + "/";
                                                        if (Directory.Exists(documentDirectory))
                                                        {
                                                            foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                                            {
                                                                String url = documentDirectory;
                                                                if(file.Replace(documentDirectory, "").Contains(cipherText))
                                                        {
                                                %>
                                                <tr>                                                 
                                                    <td><%= file.Replace(documentDirectory, "")%></td>
                                                    <td><a href="DownloadVendorFile.aspx?applicationNo=<%=vendorNo %>&&fileName=<%=file.Replace(documentDirectory, "")%>" class="btn btn-primary"><i class="fa fa-download"></i>Download</a></td>
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
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Submit Application" ID="submitapplication" CausesValidation="false" OnClick="submitapplication_Click" />
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="back" CausesValidation="false" OnClick="back_Click" />
            <div class="clearfix"></div>
        </div>
    </section>
    <script>
        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
            $("#deleteFileModal").modal();
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
</asp:Content>
