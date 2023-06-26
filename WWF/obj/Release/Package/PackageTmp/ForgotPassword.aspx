<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="WWF.ForgotPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
            <small>e-Procurement Portal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Forgot Password</li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Insert your email address to receive instructions on how to get a new password. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="row">
                    <div class="col-lg-12 col-sm-12">
                        <div class="form-group">
                            <strong>Email Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="email" CssClass="form-control" placeholder="Enter Your Valid Email Address Here" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="email" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit" ID="forgotpassword" OnClick="forgotpassword_Click" />
                    <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Cancel" ID="cancel" CausesValidation="false" OnClick="cancel_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
