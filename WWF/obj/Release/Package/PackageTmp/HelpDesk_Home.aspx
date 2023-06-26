<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="HelpDesk_Home.aspx.cs" Inherits="WWF.HelpDesk_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
            <small>e-Procurement Portal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Help Desk</li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Help Desk - Share your challenges and we will give a feedback. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Full Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="fullname" CssClass="form-control" placeholder="Enter Your Full Name" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="fullname" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Email Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="email" CssClass="form-control" placeholder="Enter Your Valid Email Address" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="email" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-sm-12">
                        <div class="form-group">
                            <strong>Description of Issue (Maximum 200 Characters)<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Multiline" ID="issue" CssClass="form-control" Height="200px" placeholder="Enter Description of Issue" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="issue" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Submit Request" ID="register" />
                    <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Cancel Request" ID="cancel" CausesValidation="false" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
