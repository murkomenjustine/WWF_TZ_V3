<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="WWF.HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%@ Import Namespace="WWF" %>
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
        <div class="row">
            <div class="col-md-12">
                <div class="box box-success">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>WELCOME</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p>
                                    WWF works to protect our natural resources - oceans, land and wildlife - so we and our future generations can continue to benefit from food, energy and water.
                                </p>
                                <p>
                                    When you give generously today, you become a part of WWF Tanzania's environmental work. You can enable positive change for our country, your community, your family's future and be a part of the big family that work towards buildling a better tomorrow.
                                </p>
                                <p class="text-center"><strong>Be a change Agent for Nature</strong></p>
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
        <!-- /.row -->
        <div class="row">
                        <!-- /.col -->
            <div class="col-md-6">
                <div class="box box-success">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>QUICK QUIDE</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <ul>
                                    <li>Register yourself and your organisation in the system</li>
                                    <li>Obtain access to the user manuals</li>
                                    <li>View the latest tender publications</li>
                                    <li>Find a specific tender by searching the tender registry</li>
                                    <li>View the details of a tender and navigate through all the avaialble documentation</li>
                                    <li>Download available documentation</li>
                                </ul>
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
            <div class="col-md-6">
                <div class="box box-success">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>WHY REGISTER?</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <ul>
                                    <li>Become an eligible supplier and receive email notifications for new tenders</li>
                                    <li>Obtain full and unrestricted access to documentation of published tenders</li>
                                    <li>To receive reminders and notifications for important tender activities</li>
                                    <li>Participate actively in tenders. Submit your bids and request for clarifications</li>
                                </ul>
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- ./box-body -->
                </div>
                <!-- /.box -->
            </div>
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->
</asp:Content>
