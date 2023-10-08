<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TenderComments.aspx.cs" Inherits="WWF.TenderComments" %>

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
            <li class="active">Tender Comments</li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Tender Comments
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Tender No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="tendorno" CssClass="form-control" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Tender Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="name" CssClass="form-control" ReadOnly="true" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Vendor No. / Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="vendorno" CssClass="form-control" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Evaluation Status<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="status" CssClass="form-control" ReadOnly="true" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-sm-12">
                        <div class="form-group">
                            <strong>Evaluation Comments<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="comments" CssClass="form-control" TextMode="MultiLine" Height="50px" ReadOnly="true" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            var nav = new Config().ReturnNav();
            string tendorNo = Request.QueryString["tendorNo"];
            bool isQualified = false;
            string empNo = "";
            var data = nav.ProcurementRequest.Where(x => x.No == tendorNo).ToList();
            foreach (var item in data)
            {
                empNo = item.Asigned_User;
                isQualified = Convert.ToBoolean(item.Qualified);
            }
            if (isQualified)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel-heading">
                Evaluation Report
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
                                string vendorNo = empNo;
                                vendorNo = vendorNo.Replace('/', '_');
                                vendorNo = vendorNo.Replace(':', '_');
                                String documentDirectory = filesFolder + vendorNo + "/";
                                if (Directory.Exists(documentDirectory))
                                {
                                    foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                    {
                                        String url = documentDirectory;
                                        if (file.Replace(documentDirectory, "").Contains(tendorNo + "EVALUATION_REPORT"))
                                        {
                        %>
                        <tr>
                            <td><%= file.Replace(documentDirectory, "")%></td>
                            <td><a href="DownloadEvaluationReport.aspx?applicationNo=<%=vendorNo %>&&fileName=<%=file.Replace(documentDirectory, "")%>" class="btn btn-success"><i class="fa fa-download"></i>Download</a></td>
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
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Exit This Page" ID="cancel" CausesValidation="false" OnClick="cancel_Click" />
            <div class="clearfix"></div>
        </div>
    </section>
</asp:Content>

