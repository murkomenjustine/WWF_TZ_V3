<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PurchaseRequisitionsApprovalComments.aspx.cs" Inherits="WWF.PurchaseRequisitionsApprovalComments" %>
<%@ Import Namespace="WWF" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% var nav = new Config().ReturnNav(); %>
        <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
            <small>Employee Self Service Portal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Purchase Requisition Approval Comments</li>
        </ol>
    </section>
    <section class="content">
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Approver Comments
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedback"></div>
                    <table id="example2" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Approver</th>
                                <th>Comment(s)</th>
                                <th>Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%

                                string docNo = Request.QueryString["DocumentNo"];
                                string RecordId = "Purchase Header:Purchase Requisition,"+ docNo;
                                var leaves = nav.ApprovalCommentLine.Where(r =>r.Document_Type=="Quote"&& r.Record_ID_to_Approve == RecordId).ToList();
                                foreach (var leave in leaves)
                                {
                            %>
                            <tr>
                                <td><%=leave.User_ID %> </td>
                                <td><%=leave.Comment %> </td>
                                <td><%=leave.Date_and_Time %> </td>
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
</section>
</asp:Content>
