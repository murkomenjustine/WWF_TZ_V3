<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WWF.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>WWF Tanzania
            <small>e-Procurement Portal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Log In</li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Login to acccess more services. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Email Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="email" CssClass="form-control" placeholder="Enter Your Valid Email Address Here" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="email" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Password<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="password" CssClass="form-control" placeholder="Enter Your Password Here" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="password" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Log In" ID="login" OnClick="login_Click" />
                    <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Cancel" ID="cancel" CausesValidation="false" OnClick="cancel_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
