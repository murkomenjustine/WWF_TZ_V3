<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedPurchaseRequisitions.aspx.cs" Inherits="WWF.ApprovedPurchaseRequisitions" %>
<%@ Import Namespace="WWF" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <%

        string employeeNo = Convert.ToString(Session["employeeNo"]);
        var nav = new Config().ReturnNav();
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Approved Purchase Requisitions
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
                        <th>Requisition Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var headers = nav.PurchaseHeader.Where(r => r.Status == "Released" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                        foreach (var header in headers)
                        {
                    %>
                    <tr>
                        <td><% =header.No %></td>
                        <td><% = Convert.ToDateTime(header.Order_Date).ToString("dd/MM/yyyy") %></td>
                        <td><% =header.Description%></td>
                        <td><% =header.Process_Type%></td>
                        <td><% =String.Format("{0:n}", Convert.ToDouble(header.Requisition_Amount)) %></td>
                        <td><% ="Approved"%></td>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
