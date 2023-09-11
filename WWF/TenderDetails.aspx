<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TenderDetails.aspx.cs" Inherits="WWF.TenderDetails" %>

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
            <li class="active">Tender Details</li>
        </ol>
    </section>
    <%
        var nav = new Config().ReturnNav();
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
                        <h3 class="box-title"><strong>TENDER DETAILS</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p>
                                    The e-Bidding Portal enables the tenderers to view all Active Invitation For Supply (IFS) Notices, download the related tender documents and allow for online submission of their bid responses.
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
                <div class="box box-success">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Apply for This Tender" ID="apply" OnClick="apply_Click" />
                                <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Cancel Application" ID="cancel" CausesValidation="false" OnClick="cancel_Click" />
                                <div class="clearfix"></div>
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
                        <li class="active"><a href="#tab_1" data-toggle="tab">Tender Overview</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Schedule of Specification Requirement</a></li>
                        <li><a href="#tab_3" data-toggle="tab">Mandatory Evaluation List</a></li>
                        <li><a href="#tab_4" data-toggle="tab">Technical Evaluation List</a></li>
                        <li><a href="#tab_5" data-toggle="tab">Tender Documents</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab_1">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box box-success">
                                        <div class="box-header with-border">
                                            <h3 class="box-title"><strong>KEY NOTES</strong></h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <p>
                                                        Below are the general details of the tender with submission timelines
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
                                    Tender General Details
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div5"></div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Tender Description</strong>
                                                <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Proposal Type</strong>
                                                <asp:TextBox runat="server" ID="proposaltype" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Supplier Category</strong>
                                                <asp:TextBox runat="server" ID="suppliercategory" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Validity Period (In Months)</strong>
                                                <asp:TextBox runat="server" ID="validperiod" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Submission Start Date</strong>
                                                <asp:TextBox runat="server" ID="startdate" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Submission Start Time</strong>
                                                <asp:TextBox runat="server" ID="starttime" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Submission End Date</strong>
                                                <asp:TextBox runat="server" ID="enddate" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Submission End Time</strong>
                                                <asp:TextBox runat="server" ID="endtime" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_2">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box box-success">
                                        <div class="box-header with-border">
                                            <h3 class="box-title"><strong>KEY NOTES</strong></h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <p>
                                                        WWF Tanzania now invites applications from eligible registered suppliers based on the requirement below
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
                                    Schedule of Specification Requirement
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div2"></div>
                                    <table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Item</th>
                                                <th>Specifications</th>
                                                <th>Quantity</th>
                                                <th>Unit of Measure</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter = 0;
                                                var query = nav.ProcurementRequestLines.Where(x => x.Requisition_No == cipherText).ToList();
                                                foreach (var member in query)
                                                {

                                                    counter++;
                                            %>
                                            <tr>
                                                <td><%=counter %></td>
                                                <td><%=member.No %></td>
                                                <td><%=member.Description %></td>
                                                <td><%=member.Quantity %></td>
                                                <td><%=member.Unit_of_Measure %></td>

                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_3">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box box-success">
                                        <div class="box-header with-border">
                                            <h3 class="box-title"><strong>KEY NOTES</strong></h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <p>
                                                        The section below lists all the mandatory evaluation list required.
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
                                    Mandatory Evaluation List
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div8"></div>
                                    <table id="example6" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Description</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter01 = 0;
                                                var query01 = nav.RFQEvaluationLists.Where(x => x.RFP_No == cipherText && x.Evaluation_Type == "Mandatory").ToList();
                                                foreach (var member in query01)
                                                {

                                                    counter01++;
                                            %>
                                            <tr>
                                                <td><%=counter01 %></td>
                                                <td><%=member.Description %></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_4">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box box-success">
                                        <div class="box-header with-border">
                                            <h3 class="box-title"><strong>KEY NOTES</strong></h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <p>
                                                        The section below lists all the Technical evaluation list required.
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
                                    Technical Evaluation List
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div1"></div>
                                    <table id="example8" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Description</th>
                                                <th>Score</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter02 = 0;
                                                var query02 = nav.RFQEvaluationLists.Where(x => x.RFP_No == cipherText && x.Evaluation_Type == "Mandatory").ToList();
                                                foreach (var member in query02)
                                                {

                                                    counter02++;
                                            %>
                                            <tr>
                                                <td><%=counter02 %></td>
                                                <td><%=member.Description %></td>
                                                <td><%=member.Score %></td>
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
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box box-success">
                                        <div class="box-header with-border">
                                            <h3 class="box-title"><strong>KEY NOTES</strong></h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <p>
                                                        The section below lists all the tender documents.
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
                                    View/Download Tender Document
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div13"></div>
                                    <table id="example4" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Tender Document</th>
                                                <th>Download</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                                                    <%
                            try
                            {
                                                                            int counterx = 0;
                                String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Tender Documents/";
                                String imprestNo = cipherText;
                                String documentDirectory = filesFolder + imprestNo + "/";
                                if (Directory.Exists(documentDirectory))
                                {
                                    foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                    {
                                                                                    counterx++;
                                        String url = documentDirectory;
                        %>
                        <tr>
                            <td><%=counterx %></td>
                            <td><% =file.Replace(documentDirectory, "") %></td>
                             <td><a href="DownloadTenderDocument.aspx?applicationNo=<%=imprestNo %>&&fileName=<%=file.Replace(documentDirectory, "") %>" class="btn btn-success"><i class="fa fa-download"></i> Download</a></td>
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
                            </div>
                        </div>
                    </div>
                    <!-- /.tab-content -->
                </div>
                <!-- nav-tabs-custom -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->
</asp:Content>
