<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeDashboard.aspx.cs" Inherits="WWF.EmployeeDashboard" %>

<%@ Import Namespace="System.Runtime.InteropServices" %>
<%@ Import Namespace="WWF" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
    <% var nav = new Config().ReturnNav();
        String employeeNo = Convert.ToString(Session["employeeNo"]);
    %>
<section class="content">
    <div class="main">
        <div class="main-inner">
            <div class="container" style="max-width: 1050px;">
                <div class="row" style="width: 98%;">
                    <div class="col-md-6 col-lg-6">


                        <div class="widget">
                            <div class="widget-header">
                                <i class="icon-file"></i>
                                <h3>Welcome <%=Session["name"]%></h3>
                            </div>
                            <div runat="server" id="photosize"></div>
                            <!-- /widget-header -->
                            <div class="widget-content">
                                <div style="width: 100%; display: block; margin: auto;">
                                    <img id="passportimage" runat="server" />
                                </div>
                                <div runat="server" id="documentsfeedback"></div>
                                <button type="button" class="btn btn-primary pull-right" data-toggle="modal" data-target="#myModal">Upload Image</button>
                                <br />
                                <table class="table table-striped table-bordered">

                                    <tbody>
                                        <%

                                            var employees = nav.Employees.Where(r => r.No == (String)Session["employeeNo"]);
                                            foreach (var employee in employees)
                                            {

                                        %>
                                        <tr>
                                            <td>Employee Number:</td>
                                            <td><%= employee.No %></td>
                                        </tr>
                                        <tr>
                                            <td>Name:</td>
                                            <td><%= Session["name"] %></td>
                                        </tr>
                                        <!--<tr><td> ID Number:</td><td> <%--= employee.ID_Number --%> </td></tr> -->
                                        <tr>
                                            <td>Email:</td>
                                            <td><%= employee.Company_E_Mail %> </td>
                                        </tr>
                                        <tr>
                                            <td>Phone Number:</td>
                                            <td><%= employee.Phone_No %> </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /widget-content -->
                        </div>
                        <!-- /widget -->
                    </div>
                    <div class="col-md-6 col-lg-6">

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-aqua">
                                <div class="inner">
                                    <h3>
                                        <% 
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
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-green">
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
                        <!-- ./col -->
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-yellow">
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
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
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
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /main-inner -->
    </div>
</section>
    <div id="myModal" class="modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Upload your passport Size Photo</h4>
                </div>
                <div class="modal-body">
                    <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Image" ID="uploadimage" OnClick="UPloadImage_Click" />
                </div>
            </div>

        </div>
    </div>
    <!-- /main -->
</asp:Content>
