<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CancelledTendersView.aspx.cs" Inherits="WWF.CancelledTendersView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
            <small>e-Procurement Portal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Page</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Current Tenders
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Tender No</th>
                            <th>Description</th>
                            <th>Bid Submission Dateline</th>
                            <th>Status</th>
                            <th>View Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%="1" %></td>
                            <td><%="TEND0001" %></td>
                            <td><%="Distribution of 1000 bags of rice"%></td>
                            <td><%="31/6/2023" %></td>
                            <td><%="Open" %></td>
                            <td><a href="TenderDetails.aspx?docNo=<%="TEND0001" %>" class="btn btn-success"><i class="fa fa-eye"></i> View Details</a> </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
    <!-- /.content -->
</asp:Content>
