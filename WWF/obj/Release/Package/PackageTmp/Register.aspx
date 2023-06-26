<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WWF.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
            <small>e-Procurement Portal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Register as a Supplier</li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Register as a Supplier. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Applicant/Business Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="applicantbusinessname" CssClass="form-control" placeholder="Enter Applicant/Business Name" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="applicantbusinessname" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Tax Registration No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="taxno" CssClass="form-control" placeholder="Tax Registration No." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="taxno" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Email Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="email" CssClass="form-control" placeholder="Enter Your Valid Email Address" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="email" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Phone Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" type="number" ID="phone" CssClass="form-control" placeholder="Enter Phone Number" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="phone" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Contact Person</strong>
                            <asp:TextBox runat="server" ID="contactperson" CssClass="form-control" placeholder="Enter Contact Person" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Submit Registration" ID="register" OnClick="register_Click" />
                    <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Cancel Registration" ID="cancel" CausesValidation="false" OnClick="cancel_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
