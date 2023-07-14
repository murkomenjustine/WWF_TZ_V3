<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsultancyApplicationPage.aspx.cs" Inherits="WWF.ConsultancyApplicationPage" %>

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
            <li class="active">Consultancy Application Form</li>
        </ol>
    </section>
    <%
        var nav = new Config().ReturnNav();
        string vendorNo = Convert.ToString(Session["vendorNo"]);
        string cipherText = Request.QueryString["TenderNo"];
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

    %>
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-success">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>CONSULTANCY APPLICATION FORM</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p>
                                    This is the final page of the application process. Kindly confirm that all your details are correct before submitting the application. If your profile details are incorrect please update on the "Complete Profile" section on the left side of the portal. After confirming everything is okay proceed to attach the required documents and submit your application.
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
        <div class="row">
            <div class="col-md-12">
                <!-- Custom Tabs -->
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_1" data-toggle="tab">General Details</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Qualifications</a></li>
                        <li><a href="#tab_3" data-toggle="tab">Past Experience</a></li>
                        <li><a href="#tab_4" data-toggle="tab">Referees</a></li>
                        <li><a href="#tab_5" data-toggle="tab">Documents</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab_1">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    General Details
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="feedback"></div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Consultant Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="consultantname" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Email Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="emailaddress" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Phone Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="phoneno" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Physical Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="physicaladdress" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Country of Origin<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="countryoforigin" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Tax Registration No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="taxno" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_2">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Qualifications / Skills
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div9"></div>
                                    <table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Qualification / Skill</th>
                                                <th>Year Obtained</th>
                                                <th>Duration</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter = 0;
                                                var qualData = nav.ConsultantQualification.Where(r => r.VendoNo == vendorNo);
                                                foreach (var t in qualData)
                                                {
                                                    counter++;
                                            %>
                                            <tr>
                                                <td><%=counter %></td>
                                                <td><%=t.Qualification %></td>
                                                <td><%=t.Year_Obtained %></td>
                                                <td><%=t.Duration %></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_3">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Past Experience
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div1"></div>
                                    <table id="example2" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Client Name</th>
                                                <th>Assignment/Project</th>
                                                <th>Project Start Date</th>
                                                <th>Project End Date</th>
                                                <th>Project Scope Summary</th>
                                                <th>Project Value</th>
                                                <th>Contract Ref No</th>
                                                <th>Address</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter2 = 0;
                                                var data = nav.VendorPastExperience.Where(r => r.Vendor_No == vendorNo);
                                                foreach (var t in data)
                                                {
                                                    counter2++;
                                            %>
                                            <tr>
                                                <td><%=counter2 %></td>
                                                <td><%=t.Client_Name %></td>
                                                <td><%=t.Assignment_Name %></td>
                                                <td><%=Convert.ToDateTime(t.Assignment_Start_Date).ToString("dd-MM-yyyy") %></td>
                                                <td><%=Convert.ToDateTime(t.Assignment_End_Date).ToString("dd-MM-yyyy") %></td>
                                                <td><%=t.Project_Scope_Summary %></td>
                                                <td><%=t.Assignment_Value_LCY %></td>
                                                <td><%=t.Contract_Ref_No %></td>
                                                <td><%=t.Address %></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_4">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Referees
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div4"></div>
                                    <table id="example3" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Name</th>
                                                <th>Phone</th>
                                                <th>Email</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter3 = 0;
                                                var refereeData = nav.ConsultantReferee.Where(r => r.VendorNo == vendorNo);
                                                foreach (var t in refereeData)
                                                {
                                                    counter3++;
                                            %>
                                            <tr>
                                                <td><%=counter3 %></td>
                                                <td><%=t.Name %></td>
                                                <td><%=t.Phone %></td>
                                                <td><%=t.Email %></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_5">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Document List
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div6"></div>
                                    <table id="example4" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Document Name</th>
                                                <th>File Name</th>
                                                <th>Date Uploaded</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter5 = 0;
                                                var regdocdata = nav.VendorFiledRegDocument.Where(x => x.Vendor_No == vendorNo && x.Procurement_Process == "Registration").ToList();
                                                foreach (var member in regdocdata)
                                                {
                                                    counter5++;
                                            %>
                                            <tr>
                                                <td><%=counter5 %></td>
                                                <td><%=member.Description %></td>
                                                <td><%=member.File_Name %></td>
                                                <td><%=Convert.ToDateTime(member.Document_Date).ToString("dd-MM-yyyy") %></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.tab-content -->
                </div>
                <!-- nav-tabs-custom -->
            </div>
            <!-- /.col -->
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                Document Upload. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Technical proposal<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:fileupload runat="server" id="curriculumvitae" cssclass="form-control" />
                            <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="curriculumvitae" errormessage="Please fill this field, it cannot be empty!" forecolor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Financial proposal<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:fileupload runat="server" id="coverletter" cssclass="form-control" />
                            <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="coverletter" errormessage="Please fill this field, it cannot be empty!" forecolor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:button runat="server" cssclass="btn btn-primary pull-right" text="Upload Documents" id="documentuploaddetails" />
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
                                                        String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Leave Application card/";
                                                        String imprestNo = Request.QueryString["leaveNo"];
                                                        imprestNo = imprestNo.Replace('/', '_');
                                                        imprestNo = imprestNo.Replace(':', '_');
                                                        String documentDirectory = filesFolder + imprestNo + "/";
                                                        if (Directory.Exists(documentDirectory))
                                                        {
                                                            foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                                            {
                                                                String url = documentDirectory;
                                                %>
                                                <tr>
                                                    <td><% =file.Replace(documentDirectory, "") %></td>

                                                    <td><a href="DownloadVendorFile.aspx?applicationNo=<%=vendorNo %>&&fileName=<%=file.Replace(documentDirectory, "")%>" class="btn btn-primary"><i class="fa fa-download"></i>Download</a></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                                </tr>
                                                <%
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
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Submit Application" ID="submitapplication" CausesValidation="false"/>
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="back" CausesValidation="false" />
            <div class="clearfix"></div>
        </div>
    </section>
    <!-- /.content -->
</asp:Content>


