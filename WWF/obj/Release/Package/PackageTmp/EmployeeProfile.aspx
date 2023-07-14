<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeProfile.aspx.cs" Inherits="WWF.EmployeeProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
            <small>e-Procurement Portal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Profile</li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                My Profile      
            </div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <p><strong>Employee Number</strong></p>
                            <asp:TextBox runat="server" CssClass="form-control" ID="empNo" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <p><strong>Name</strong></p>
                            <asp:TextBox runat="server" CssClass="form-control" ID="name" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <p><strong>Department</strong></p>
                            <asp:TextBox runat="server" CssClass="form-control" ID="department" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <p><strong>Job Title</strong></p>
                            <asp:TextBox runat="server" CssClass="form-control" ID="jobtitle" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <p><strong>Gender</strong></p>
                            <asp:TextBox runat="server" CssClass="form-control" ID="gender" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <p><strong>Date Employed</strong></p>
                            <asp:TextBox runat="server" CssClass="form-control" ID="dateofbirth" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <p><strong>Company Email</strong></p>
                            <asp:TextBox runat="server" CssClass="form-control" ID="email" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <p><strong>Phone Number</strong></p>
                            <asp:TextBox runat="server" CssClass="form-control" ID="phonenumber" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <p><strong>Employee Status</strong></p>
                            <asp:TextBox runat="server" CssClass="form-control" ID="empstatus" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <p><strong>National ID No.</strong></p>
                            <asp:TextBox runat="server" CssClass="form-control" ID="idno" ReadOnly="true" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Back To Dashboard" ID="backtodashboard" OnClick="backtodashboard_Click" />
                    <span class="clearfix"></span>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
