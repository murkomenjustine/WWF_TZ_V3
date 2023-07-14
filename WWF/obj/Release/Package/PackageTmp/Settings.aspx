<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="WWF.Settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>e-Procurement Portal</a></li>
            <li class="active">Change account password</li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Change account password. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Current Password<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="currentpassword" CssClass="form-control" placeholder="Enter Your Current Password Here" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="currentpassword" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>New Password<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="newpassword" CssClass="form-control" placeholder="Enter Your New Password Here" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="newpassword" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Confirm Password<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="confirmpassword" CssClass="form-control" placeholder="Enter Your Confirmation Password Here" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="confirmpassword" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Submit" ID="submit" OnClick="submit_Click" />
                     <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Cancel" ID="cancel" CausesValidation="false" OnClick="cancel_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
