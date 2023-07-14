<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InProgressPurchaseRequisitions.aspx.cs" Inherits="WWF.InProgressPurchaseRequisitions" %>

<%@ Import Namespace="WWF" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        string employeeNo = Convert.ToString(Session["employeeNo"]);
        var nav = new Config().ReturnNav();
    %>
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
            <small>Employee Self Service Portal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">In Progress Purchase Requisitions</li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                In Progress Purchase Requisitions
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <table id="example2" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Document No</th>
                            <th>Date Requested</th>
                            <th>Description</th>
                            <th>Process Type</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var headers = nav.PurchaseHeader.Where(r => r.Status == "In Progress" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                            foreach (var header in headers)
                            {
                        %>
                        <tr>
                            <td><% =header.No %></td>
                            <td><% = Convert.ToDateTime(header.Order_Date).ToString("dd/MM/yyyy") %></td>
                            <td><% =header.Description%></td>
                            <td><% =header.Process_Type%></td>
                            <td><% =header.Status%></td>
                        </tr>
                        <%
                            } %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</asp:Content>
