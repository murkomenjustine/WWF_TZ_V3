<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeDashboard.aspx.cs" Inherits="WWF.EmployeeDashboard" %>
<%@ Import Namespace="WWF" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <% var nav = new Config().ReturnNav();
    %>
     <section class="content-header">
      <h1>
        Dashboard
        <small>Employee Self Service Portal</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>
    <section class="content">
      <!-- Small boxes (Stat box) -->
      <div class="row">
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
             <div class="small-box bg-green">
                <div class="inner">
                    <h3>
                        <% 
                            string employeeNo = Convert.ToString(Session["employeeNo"]);
                            var headers = nav.PurchaseHeader.Where(r => r.Status == "Open" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                            int approvedPurchaseReq = 0;
                            try
                            {
                                foreach (var header in headers)
                                {
                                    approvedPurchaseReq++;

                                }
                            }
                            catch (Exception)
                            {
                                approvedPurchaseReq = 0;
                            }
                        %>
                        <% = approvedPurchaseReq %>
                    </h3>

                    <p>Open Purchase Requisition(s)</p>
                </div>
                <div class="icon">
                    <i class="fa fa-shopping-cart"></i>
                </div>
                <a href="OpenPurchaseRequisitions.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
            <div class="small-box bg-yellow">
                <div class="inner">
                    <h3>
                        <% 
                            var headers1 = nav.PurchaseHeader.Where(r => r.Status == "Pending Approval" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                            int approvedPurchaseReq1 = 0;
                            try
                            {
                                foreach (var header in headers1)
                                {
                                    approvedPurchaseReq1++;

                                }
                            }
                            catch (Exception)
                            {
                                approvedPurchaseReq1 = 0;
                            }
                        %>
                        <% = approvedPurchaseReq1 %>
                    </h3>

                    <p>Pending Purchase Requisition(s)</p>
                </div>
                <div class="icon">
                    <i class="fa fa-shopping-cart"></i>
                </div>
                <a href="OpenPurchaseRequisitions.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
            <div class="small-box bg-aqua">
                <div class="inner">
                    <h3>
                        <% 
                            var headers3 = nav.PurchaseHeader.Where(r => r.Status == "In Progress" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                            int approvedPurchaseReq3 = 0;
                            try
                            {
                                foreach (var header in headers3)
                                {
                                    approvedPurchaseReq3++;

                                }
                            }
                            catch (Exception)
                            {
                                approvedPurchaseReq3 = 0;
                            }
                        %>
                        <% = approvedPurchaseReq3 %>
                    </h3>

                    <p>In Progress Purchase Requisition(s)</p>
                </div>
                <div class="icon">
                    <i class="fa fa-shopping-cart"></i>
                </div>
                <a href="InProgressPurchaseRequisitions.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
            <div class="small-box bg-red">
                <div class="inner">
                    <h3>
                        <% 
                            var headers2 = nav.PurchaseHeader.Where(r => r.Status == "Released" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                            int approvedPurchaseReq2 = 0;
                            try
                            {
                                foreach (var header in headers2)
                                {
                                    approvedPurchaseReq2++;

                                }
                            }
                            catch (Exception)
                            {
                                approvedPurchaseReq2 = 0;
                            }
                        %>
                        <% = approvedPurchaseReq2 %>
                    </h3>

                    <p>Approved Purchase Requisition(s)</p>
                </div>
                <div class="icon">
                    <i class="fa fa-shopping-cart"></i>
                </div>
                <a href="ApprovedPurchaseRequisitions.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <!-- ./col -->
      </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                Open Purchase Requisitions
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <table id="example2" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Document No</th>
                            <th>Date Requested</th>
                            <th>Due Date</th>
                            <th>Description</th>
                            <th>Process Type</th>
                            <th>Requisition Amount</th>
                            <th>Status</th>
                            <th>Edit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var headers5 = nav.PurchaseHeader.Where(r => r.Status == "Open" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                            foreach (var header in headers5)
                            {
                        %>
                        <tr>
                            <td><% =header.No %></td>
                            <td><% = Convert.ToDateTime(header.Order_Date).ToString("dd/MM/yyyy") %></td>
                            <td><% = Convert.ToDateTime(header.Due_Date).ToString("dd/MM/yyyy") %></td>
                            <td><% =header.Description%></td>
                            <td><% =header.Process_Type%></td>
                            <td><% =String.Format("{0:n}", Convert.ToDouble(header.Requisition_Amount)) %></td>
                            <td><% =header.Status%></td>
                             <td> <a href="Requisition.aspx?step=1&&requisitionNo=<%=header.No %>" class="btn btn-primary"><i class="fa fa-pencil"></i>Edit</a></td>                          
                        </tr>
                        <%
                            } %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</asp:Content>
