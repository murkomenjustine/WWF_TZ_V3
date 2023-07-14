<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsultancyDetails.aspx.cs" Inherits="WWF.ConsultancyDetails" %>

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
            <li class="active">Consultancy Details</li>
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
                        <h3 class="box-title"><strong>CONSULTANCY DETAILS</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p>
                                    The e-Procurement Portal enables the consultants to view all Active consultancies, download the related consultancy documents and allow for online submission of their applications.
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
                        <li class="active"><a href="#tab_1" data-toggle="tab">Consultancy Overview</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Consultancy Documents</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab_1">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Consultancy General Details.
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div5"></div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Consultancy Name</strong>
                                                <asp:TextBox runat="server" ID="name" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Consultancy Status</strong>
                                                <asp:TextBox runat="server" ID="status" CssClass="form-control" placeholder="" ReadOnly="true" />
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
                                    <div class="row">
                                        <div class="col-lg-12 col-sm-12">
                                            <div class="form-group">
                                                <strong>Consultancy Summary</strong>
                                                <asp:TextBox runat="server" ID="summary" CssClass="form-control" Height="80px" TextMode="MultiLine" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_2">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Download Consultancy Document
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div13"></div>
                                    <table id="example4" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Consultancy Document</th>
                                                <th>Download</th>
                                            </tr>
                                        </thead>
                                        <tbody>
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
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Apply for This Consultancy" ID="applyconsultancy" OnClick="applyconsultancy_Click" />
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Cancel Application" ID="cancelapplication" CausesValidation="false" OnClick="cancelapplication_Click" />
            <div class="clearfix"></div>
        </div>
    </section>
    <!-- /.content -->
</asp:Content>

