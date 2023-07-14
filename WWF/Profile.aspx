<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WWF.Profile" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="WWF" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>e-Procurement Portal</a></li>
            <li class="active">Supplier Registration</li>
        </ol>
    </section>
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 8 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        string vendorNo = Convert.ToString(Session["vendorNo"]);
        var nav = new Config().ReturnNav();
        if (step == 1)
        {
    %>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                General Details. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 8 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Supplier Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="suppliername" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="suppliername" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Tax Registration No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="taxregistrationno" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="taxregistrationno" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Tax Registration Country<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="taxregistrationcountry" CssClass="form-control select2">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="taxregistrationcountry" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Registration/Incorporation Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Date" ID="registrationdate" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="registrationdate" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Registration/Incorporation No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="registrationincorporationno" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="registrationincorporationno" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Language<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="language" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="language" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Business Type<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="businesstype" CssClass="form-control select2">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="businesstype" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Ownership Type<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="ownershiptype" CssClass="form-control select2">
                                <asp:ListItem>--Select--</asp:ListItem>
                                <asp:ListItem>Sole Ownership.Partnership</asp:ListItem>
                                <asp:ListItem>Registered Company</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="ownershiptype" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Supplier Type<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="suppliertype" CssClass="form-control select2">
                                <asp:ListItem>--Select--</asp:ListItem>
                                <asp:ListItem>Local</asp:ListItem>
                                <asp:ListItem>Foreign</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="suppliertype" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Industry Group<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="industrygroup" CssClass="form-control select2">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="industrygroup" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Vision (Max 200 characters)</strong>
                            <asp:TextBox runat="server" ID="vision" CssClass="form-control" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Mission (Max 200 characters)</strong>
                            <asp:TextBox runat="server" ID="mission" CssClass="form-control" TextMode="MultiLine" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-sm-12">
                        <div class="form-group">
                            <strong>Supplier special Group?</strong>
                            <asp:CheckBox runat="server" ID="specialgroup" CssClass="form-control" AutoPostBack="true" OnCheckedChanged="specialgroup_CheckedChanged" />
                        </div>
                    </div>
                </div>
                <div runat="server" id="divspecialcategory" visible="false">
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Certificate No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="certificateno" CssClass="form-control" />
                                <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="certificateno" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Supplier Category<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:DropDownList runat="server" ID="suppliercategory" CssClass="form-control select2" AppendDataBoundItems="true">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="suppliercategory" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Certifying Agency<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:DropDownList runat="server" ID="certifyingagaency" CssClass="form-control select2" AppendDataBoundItems="true">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="certifyingagaency" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Product/Service<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="productservices" CssClass="form-control" placeholder="Please enter details here..." />
                                <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="productservices" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Cerificate Effective Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" TextMode="Date" ID="certificateeffectivedate" CssClass="form-control" placeholder="Please enter details here..." />
                                <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="certificateeffectivedate" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Certificate Expiry Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" TextMode="Date" ID="certificateexpirydate" CssClass="form-control" placeholder="Please enter details here..." />
                                <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="certificateexpirydate" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="generaldetails" OnClick="generaldetails_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </section>

    <% 
        }
        else if (step == 2)
        {
    %>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Communication, Contact & Location Details. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 8<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="communicationfeedback"></div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title"><strong>Communication & Contact Details</strong></h3>
                            </div>
                        </div>
                        <!-- /.box -->
                    </div>
                    <!-- /.col -->
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Phone<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="phone" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="phone" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Email<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="email" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="email" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title"><strong>Location Details</strong></h3>
                            </div>
                        </div>
                        <!-- /.box -->
                    </div>
                    <!-- /.col -->
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="address" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="address" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Address 2<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="address2" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="address2" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Building/House No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="buildinghouse" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="buildinghouse" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Floor<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="floor" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="floor" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Plot No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="plot" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="plot" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Street<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="street" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="street" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="back" OnClick="back_Click" CausesValidation="false" />
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="communicationcontactdetails" OnClick="communicationcontactdetails_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </section>

    <% 
        }
        else if (step == 3)
        {
    %>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Company/Business Profile. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 8<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="businessprofilefeedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Company Size<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="companysize" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="companysize" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Nominal Capital<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" type="number" ID="nominalcapital" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="nominalcapital" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Dealer Type<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="dealertype" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                                <asp:ListItem>Manufacturer</asp:ListItem>
                                <asp:ListItem>Distributor</asp:ListItem>
                                <asp:ListItem>Partner</asp:ListItem>
                                <asp:ListItem>Reseller</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="dealertype" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Max value of Business<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" type="number" ID="maxvalueofbusiness" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="maxvalueofbusiness" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Supplier Category<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="businesprofilesuppliercategory" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="businesprofilesuppliercategory" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Nature of Business<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="natureofbusiness" CssClass="form-control" TextMode="MultiLine" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="natureofbusiness" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="backtosteptwo" OnClick="back_Click" CausesValidation="false" />
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="businessprofiledetails" OnClick="businessprofiledetails_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </section>
    <% 
        }
        else if (step == 4)
        {
    %>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Bank Profile. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 8<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="bankprofilefeedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Bank Code<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="bankcodes" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="bankcodes" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Bank Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="bankname" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="bankname" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Bank Branch<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="bankbranchs" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="bankbranchs" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Bank Account No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="bankaccountno" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="bankaccountno" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Save Bank Details" ID="savebankdetails" OnClick="savebankdetails_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>Saved Bank List</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <table id="example1" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Bank Code</th>
                                            <th>Bank Name</th>
                                            <th>Bank Branch No.</th>
                                            <th>Bank Account No.</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            int counter = 0;
                                            var bankData = nav.VendorBankAccounts.Where(r => r.Vendor_No == vendorNo);
                                            foreach (var t in bankData)
                                            {
                                                counter++;
                                        %>
                                        <tr>
                                            <td><%=counter %></td>
                                            <td><%=t.Code %></td>
                                            <td><%=t.Name %></td>
                                            <td><%=t.Bank_Branch_No %></td>
                                            <td><%=t.Bank_Account_No %></td>
                                            <td>
                                                <label class="btn btn-primary" onclick="editbank('<%=t.Code %>','<%=t.Name %>','<%=t.Bank_Branch_No %>','<%=t.Bank_Account_No %>');"><i class="fa fa-edit"></i>Edit</label>
                                            </td>
                                            <td>
                                                <label class="btn btn-danger" onclick="removebank('<%=t.Name %>','<%=t.Code %>');"><i class="fa fa-thrash"></i>Remove</label>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
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
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="backtostepthree" OnClick="back_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="nexttostepfive" CausesValidation="false" OnClick="nexttostepfive_Click" />
            <div class="clearfix"></div>
        </div>
    </section>
    <% 
        }
        else if (step == 5)
        {
    %>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Shareholder Details. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 5 of 8<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="shareholderfeedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Shareholder Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="directorname" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="directorname" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>ID Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="idnumber" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="idnumber" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Citizenship Type<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="citizenshiptype" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                                <asp:ListItem>Birth</asp:ListItem>
                                <asp:ListItem>Naturalization</asp:ListItem>
                                <asp:ListItem>Registration</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="citizenshiptype" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Ownership Percentage(%)<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="ownershippercentage" CssClass="form-control" placeholder="Please enter details here..." value="0" DisplayFormatString="00.00" onkeyup="checkTB(this.value)" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="ownershippercentage" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Phone Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="phonenumber" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="phonenumber" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Shareholder Email Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="shareholderemail" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="shareholderemail" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Shareholder Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="shareholderaddress" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="shareholderaddress" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Save Shareholder Details" ID="shareholderdetails" OnClick="shareholderdetails_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>Saved Shareholder List</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <table id="example2" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Director Name</th>
                                            <th>ID Number</th>
                                            <th>Citizenship Type</th>
                                            <th>Ownership Percentage(%)</th>
                                            <th>Phone Number</th>
                                            <th>Email Address</th>
                                            <th>Shareholder Address</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            int counter = 0;
                                            var shareholderdata = nav.VendorShareholderDetails.Where(r => r.Vendor_No == vendorNo);
                                            foreach (var t in shareholderdata)
                                            {
                                                counter++;
                                        %>
                                        <tr>
                                            <td><%=counter %></td>
                                            <td><%=t.Name %></td>
                                            <td><%=t.ID_Passport_No %></td>
                                            <td><%=t.Citizenship_Type %></td>
                                            <td><%=t.Entity_Ownership %></td>
                                            <td><%=t.Phone_No %></td>
                                            <td><%=t.E_Mail %></td>
                                            <td><%=t.Address %></td>
                                            <td>
                                                <label class="btn btn-primary" onclick="editShareholder('<%=t.Entry_No %>','<%=t.Name %>','<%=t.ID_Passport_No %>','<%=t.Citizenship_Type %>','<%=t.Entity_Ownership %>','<%=t.Phone_No %>','<%=t.E_Mail %>','<%=t.Address %>');"><i class="fa fa-edit"></i>Edit</label>
                                            </td>
                                            <td>
                                                <label class="btn btn-danger" onclick="removeshareholder('<%=t.Entry_No %>','<%=t.Name %>');"><i class="fa fa-thrash"></i>Remove</label>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
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
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="backtostepfour" OnClick="back_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="nexttostepsix" OnClick="nexttostepsix_Click" CausesValidation="false" />
            <div class="clearfix"></div>
        </div>
    </section>
    <% 
        }
        else if (step == 6)
        {
    %>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Past Experience. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 6 of 8<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="pastexperiencefeedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Client Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="clientname" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="clientname" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Assignment/Project<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="assignmentproject" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="assignmentproject" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Project Start Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Date" ID="projectstartdate" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="projectstartdate" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Project End Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="projectenddate" TextMode="Date" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="projectenddate" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Project Scope Summary<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="projectscopesummary" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="projectscopesummary" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Project Value<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Number" ID="projectvalue" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="projectvalue" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Contract Ref No<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="contactrefno" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="contactrefno" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="projectaddress" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="projectaddress" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Save Past Experience Details" ID="pastexperiencedetails" OnClick="pastexperiencedetails_Click" />
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Skip Past Experience" ID="skippastexperience" OnClick="skippastexperience_Click" CausesValidation="false" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>Saved Past Experience List</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <table id="example4" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Client Name</th>
                                            <th>Assignment/Project</th>
                                            <th>Project Start Date</th>
                                            <th>Project End Date</th>
                                            <th>Project Scope Summary</th>
                                            <th>Project Value</th>
                                            <th>Contract Ref No</th>
                                            <th>Address</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            int counter = 0;
                                            string sDate = "";
                                            string eDate = "";
                                            var data = nav.VendorPastExperience.Where(r => r.Vendor_No == vendorNo);
                                            foreach (var t in data)
                                            {
                                                sDate = Convert.ToDateTime(t.Assignment_Start_Date).ToString("yyyy-MM-dd");
                                                eDate = Convert.ToDateTime(t.Assignment_End_Date).ToString("yyyy-MM-dd");
                                                counter++;
                                        %>
                                        <tr>
                                            <td><%=counter %></td>
                                            <td><%=t.Client_Name %></td>
                                            <td><%=t.Assignment_Name %></td>
                                            <td><%=Convert.ToDateTime(t.Assignment_Start_Date).ToString("dd-MM-yyyy") %></td>
                                            <td><%=Convert.ToDateTime(t.Assignment_End_Date).ToString("dd-MM-yyyy") %></td>
                                            <td><%=t.Project_Scope_Summary %></td>
                                            <td><%=t.Assignment_Value_LCY %></td>
                                            <td><%=t.Contract_Ref_No %></td>
                                            <td><%=t.Address %></td>
                                            <td>
                                                <label class="btn btn-primary" onclick="editpastexperience('<%=t.Entry_No %>','<%=t.Client_Name %>','<%=t.Assignment_Name %>','<%=sDate %>','<%=eDate %>','<%=t.Project_Scope_Summary %>','<%=t.Assignment_Value_LCY %>','<%=t.Contract_Ref_No %>','<%=t.Address %>');"><i class="fa fa-edit"></i>Edit</label>
                                            </td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deletepastexperience('<%=t.Entry_No %>','<%=t.Assignment_Name %>');"><i class="fa fa-thrash"></i>Remove</label>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
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
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="backtostepsix" OnClick="back_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="nexttostepseven" OnClick="nexttostepseven_Click" CausesValidation="false" />
            <div class="clearfix"></div>
        </div>
    </section>
    <% 
        }
        else if (step == 7)
        {
    %>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Key Staff / Personnel. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 7 of 8<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="keystafffeedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Staff Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="staffnumber" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="staffnumber" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Staff Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="staffname" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="staffname" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Profession<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="profession" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="profession" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Current Designation<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="currentdesignation" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="currentdesignation" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Date of Birth<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Date" ID="dateofbirth" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="dateofbirth" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Joining Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Date" ID="joiningdate" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="joiningdate" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Years In The Firm<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Number" ID="yearsinthefirm" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="yearsinthefirm" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Phone Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Number" ID="staffphonenumber" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="staffphonenumber" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Nationality<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="staffsnationality" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="staffsnationality" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Email Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="staffemail" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="staffemail" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Save Staff Details" ID="staffdetails" OnClick="staffdetails_Click" />
                    <div class="clearfix"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title"><strong>Saved Staff List</strong></h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <table id="example7" class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Staff Number</th>
                                                    <th>Staff Name</th>
                                                    <th>Profession</th>
                                                    <%--                                            <th>Current Designation</th>
                                            <th>Date of Birth</th>
                                            <th>Joining Date</th>
                                            <th>Years in The Firm</th>
                                            <th>Phone Number</th>--%>
                                                    <th>Nationality</th>
                                                    <th>Email Address</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    int counter = 0;
                                                    string bDate = "";
                                                    string jDate = "";
                                                    var data = nav.VendorProffessionalStaff.Where(r => r.Vendor_No == vendorNo);
                                                    foreach (var t in data)
                                                    {
                                                        bDate = Convert.ToDateTime(t.Date_of_Birth).ToString("yyyy-MM-dd");
                                                        jDate = Convert.ToDateTime(t.Joining_Date).ToString("yyyy-MM-dd");
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>
                                                    <td><%=t.Staff_Number %></td>
                                                    <td><%=t.Staff_Name %></td>
                                                    <td><%=t.Proffesion %></td>
                                                    <%--                                            <td><%=t.Current_Designation %></td>
                                            <td><%=Convert.ToDateTime(t.Date_of_Birth).ToString("dd-MM-yyyy") %></td>
                                            <td><%=Convert.ToDateTime(t.Joining_Date).ToString("dd-MM-yyyy") %></td>
                                            <td><%= t.Years_With_the_Firm %></td>
                                            <td><%= t.Phone_No %></td>--%>
                                                    <td><%= t.Nationality %></td>
                                                    <td><%= t.E_Mail %></td>
                                                    <td>
                                                        <label class="btn btn-primary" onclick="editstaff('<%=t.Entry_No %>','<%=t.Staff_Number %>','<%=t.Staff_Name %>','<%=t.Proffesion %>','<%=t.Current_Designation %>','<%=bDate %>','<%=jDate %>','<%=t.Years_With_the_Firm %>','<%=t.Phone_No %>','<%=t.Nationality %>','<%=t.E_Mail %>');"><i class="fa fa-edit"></i>Edit</label>
                                                    </td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletekeystaff('<%=t.Entry_No %>','<%=t.Staff_Name %>');"><i class="fa fa-thrash"></i>Remove</label>
                                                    </td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
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
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="backtostepseven" OnClick="back_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="nexttostepeight" OnClick="nexttostepeight_Click" CausesValidation="false" />
            <div class="clearfix"></div>
        </div>
    </section>
    <% 
        }
        else if (step == 8)
        {
    %>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Document Upload. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 8 of 8<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="documentsfeedback"></div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title"><strong>Required Document List</strong></h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <table id="example8" class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Procurement Document Type</th>
                                                    <th>Description</th>
                                                    <th>Requirement Type</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    int counter = 0;
                                                    var docdata = nav.eProcDocuments.Where(x => x.Procurement_Process == "Registration"  && x.Type == "Vendor").ToList();
                                                    foreach (var member in docdata)
                                                    {
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>
                                                    <td><%=member.Procurement_Document_Type %></td>
                                                    <td><%=member.Description %></td>
                                                    <td><%=member.Requirement_Type %></td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
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
                <div class="row">
                    <div class="col-md-12">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title"><strong>Upload Documents</strong></h3>
                            </div>
                            <!-- ./box-body -->
                        </div>
                        <!-- /.box -->
                    </div>
                    <!-- /.col -->
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Document To Upload<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="documenttoupload" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="documenttoupload" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>External Document (Certificate No)<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="externaldocumentno" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="externaldocumentno" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Issue Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Date" ID="issuedate" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="issuedate" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Expiry Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Date" ID="expirydate" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="expirydate" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Select Document<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:FileUpload runat="server" ID="filetoupload" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="filetoupload" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Save Documents Details" ID="documentuploaddetails" OnClick="documentuploaddetails_Click" />
                    <div class="clearfix"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title"><strong>Saved Documents List</strong></h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <table id="example9" class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Document Name</th>
                                                    <th>File Name</th>
                                                    <th>Certificate No</th>
                                                    <th>Issue Date</th>
                                                    <th>Expiry Date</th>
                                                    <th>Date Uploaded</th>
                                                    <th>Download</th>
                                                    <th>Remove</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    int counter1 = 0;
                                                    var regdocdata = nav.VendorFiledRegDocument.Where(x => x.Vendor_No == vendorNo && x.Procurement_Process == "Registration").ToList();
                                                    foreach (var member in regdocdata)
                                                    {
                                                        counter1++;
                                                %>
                                                <tr>
                                                    <td><%=counter1 %></td>
                                                    <td><%=member.Description %></td>
                                                    <td><%=member.File_Name %></td>
                                                    <td><%=member.Certificate_No %></td>
                                                    <td><%=Convert.ToDateTime(member.Issue_Date).ToString("dd-MM-yyyy") %></td>
                                                    <td><%=Convert.ToDateTime(member.Expiry_Date).ToString("dd-MM-yyyy") %></td>
                                                    <td><%=Convert.ToDateTime(member.Document_Date).ToString("dd-MM-yyyy") %></td>
                                                    <td><a href="DownloadVendorFile.aspx?applicationNo=<%=vendorNo %>&&fileName=<%=member.File_Name %>" class="btn btn-primary"><i class="fa fa-download"></i>Download</a></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletedocDetails('<%=member.Entry_No %>','<%=member.Description %>');"><i class="fa fa-thrash"></i>Remove</label>
                                                    </td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
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
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="backtostepeight" OnClick="back_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Submit Profile Details" ID="submitprofiledetails" OnClick="submitprofiledetails_Click" CausesValidation="false" />
            <div class="clearfix"></div>
        </div>
    </section>
    <%
        }
    %>

    <script>
        function editbank(pmodalbankcode, pmodalbankname, pmodalbankbranch, pmodalbankaccountno) {
            document.getElementById("ContentPlaceHolder1_modalbankcode").value = pmodalbankcode;
            document.getElementById("ContentPlaceHolder1_modalbankname").value = pmodalbankname;
            document.getElementById("ContentPlaceHolder1_modalbankbranch").value = pmodalbankbranch;
            document.getElementById("ContentPlaceHolder1_modalbankaccountno").value = pmodalbankaccountno;
            $("#editbankmodal").modal();
        }
        function removebank(pbanktoremove, pbankcode) {
            document.getElementById("banktoremove").innerText = pbanktoremove;
            document.getElementById("ContentPlaceHolder1_bankcode").value = pbankcode;
            $("#removebankmodal").modal();
        }
        function checkTB(val) {
            var allowedString = /^\d+(\.\d{0,2})?$/; // Allow 2 decimal place with numeric value
            if (allowedString.test(val) == false) {
                alert("The value " + val + " is not allowed, kindly input only numbers or decimal numbers e.g 5 or 5.50");
            }
        }
    </script>
    <div id="removebankmodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Bank Details</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the bank <strong id="banktoremove"></strong>?</p>
                    <asp:TextBox runat="server" ID="bankcode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Remove Bank" ID="removebank" OnClick="removebank_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>

    <div id="editbankmodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Bank Details</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Bank Code<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="modalbankcode" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Bank Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="modalbankname" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Bank Branch<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="modalbankbranch" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Bank Account No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="modalbankaccountno" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Edit Bank Details" ID="editbank" OnClick="editbank_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function editShareholder(Entry_No, Name, ID_Passport_No, Citizenship_Type, Entity_Ownership, Phone_No, E_Mail, Address) {
            document.getElementById("ContentPlaceHolder1_shareEntryNo").value = Entry_No;
            document.getElementById("ContentPlaceHolder1_shareName").value = Name;
            document.getElementById("ContentPlaceHolder1_shareIDPassportNo").value = ID_Passport_No;
            document.getElementById("ContentPlaceHolder1_shareCitizenshipType").value = Citizenship_Type;
            document.getElementById("ContentPlaceHolder1_shareEntityOwnership").value = Entity_Ownership;
            document.getElementById("ContentPlaceHolder1_sharePhoneNo").value = Phone_No;
            document.getElementById("ContentPlaceHolder1_shareEMail").value = E_Mail;
            document.getElementById("ContentPlaceHolder1_shareAddress").value = Address;
            $("#editshareholdermodal").modal();
        }
        function removeshareholder(pshareholderId, pshareholdertoremove) {
            document.getElementById("shareholdertoremove").innerText = pshareholdertoremove;
            document.getElementById("ContentPlaceHolder1_shareholderId").value = pshareholderId;
            $("#removeshareholdermodal").modal();
        }
    </script>
    <div id="removeshareholdermodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Shareholder</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the shareholder <strong id="shareholdertoremove"></strong>?</p>
                    <asp:TextBox runat="server" ID="shareholderId" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Remove Shareholder" ID="removeshareholder" OnClick="removeshareholder_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>

    <div id="editshareholdermodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Bank Details</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="shareEntryNo" type="hidden" />
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Shareholder Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="shareName" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>ID Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="shareIDPassportNo" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Citizenship Type<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:DropDownList runat="server" ID="shareCitizenshipType" CssClass="form-control select2" AppendDataBoundItems="true">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                    <asp:ListItem>Birth</asp:ListItem>
                                    <asp:ListItem>Naturalization</asp:ListItem>
                                    <asp:ListItem>Registration</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Ownership Percentage(%)<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="shareEntityOwnership" CssClass="form-control" placeholder="Please enter details here..." value="0" DisplayFormatString="00.00" onkeyup="checkTB(this.value)" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Phone Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="sharePhoneNo" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Shareholder Email Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="shareEMail" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Shareholder Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="shareAddress" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Edit Shareholder Details" ID="editshareholder" OnClick="editshareholder_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function editpastexperience(Entry_No, Client_Name, Assignment_Name, Assignment_Start_Date, Assignment_End_Date, Project_Scope_Summary, Assignment_Value_LCY, Contract_Ref_No, Address) {
            document.getElementById("ContentPlaceHolder1_peEntryNo").value = Entry_No;
            document.getElementById("ContentPlaceHolder1_peClientName").value = Client_Name;
            document.getElementById("ContentPlaceHolder1_peAssignmentName").value = Assignment_Name;
            document.getElementById("ContentPlaceHolder1_peAssignmentStartDate").value = Assignment_Start_Date;
            document.getElementById("ContentPlaceHolder1_peAssignmentEndDate").value = Assignment_End_Date;
            document.getElementById("ContentPlaceHolder1_peProjectScopeSummary").value = Project_Scope_Summary;
            document.getElementById("ContentPlaceHolder1_peAssignmentValueLCY").value = Assignment_Value_LCY;
            document.getElementById("ContentPlaceHolder1_peContractRefNo").value = Contract_Ref_No;
            document.getElementById("ContentPlaceHolder1_peAddress").value = Address;
            $("#editpastexperiencemodal").modal();
        }
        function deletepastexperience(ppastexpId, ppastexperiencetoremove) {
            document.getElementById("pastexperiencetoremove").innerText = ppastexperiencetoremove;
            document.getElementById("ContentPlaceHolder1_pastexpId").value = ppastexpId;
            $("#deletepastexperiencemodal").modal();
        }
    </script>
    <div id="deletepastexperiencemodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Past Experience</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Past Experience <strong id="pastexperiencetoremove"></strong>?</p>
                    <asp:TextBox runat="server" ID="pastexpId" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Remove Past Experience" ID="removepastexperience" OnClick="removepastexperience_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>

    <div id="editpastexperiencemodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Past Experience Details</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="peEntryNo" type="hidden" />
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Client Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="peClientName" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Assignment/Project<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="peAssignmentName" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Project Start Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" TextMode="Date" ID="peAssignmentStartDate" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Project End Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="peAssignmentEndDate" TextMode="Date" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Project Scope Summary<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="peProjectScopeSummary" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Project Value<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" TextMode="Number" ID="peAssignmentValueLCY" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Contract Ref No<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="peContractRefNo" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="peAddress" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Edit Past Experience Details" ID="editpastexperience" OnClick="editpastexperience_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function editstaff(Entry_No, Staff_Number, Staff_Name, Proffesion, Current_Designation, Date_of_Birth, Joining_Date, Years_With_the_Firm, Phone_No, Nationality, E_Mail) {
            document.getElementById("ContentPlaceHolder1_ksEntryNo").value = Entry_No;
            document.getElementById("ContentPlaceHolder1_ksStaffNumber").value = Staff_Number;
            document.getElementById("ContentPlaceHolder1_ksStaffName").value = Staff_Name;
            document.getElementById("ContentPlaceHolder1_ksProffesion").value = Proffesion;
            document.getElementById("ContentPlaceHolder1_ksCurrentDesignation").value = Current_Designation;
            document.getElementById("ContentPlaceHolder1_ksDateofBirth").value = Date_of_Birth;
            document.getElementById("ContentPlaceHolder1_ksJoiningDate").value = Joining_Date;
            document.getElementById("ContentPlaceHolder1_ksYearsWiththeFirm").value = Years_With_the_Firm;
            document.getElementById("ContentPlaceHolder1_ksPhoneNo").value = Phone_No;
            document.getElementById("ContentPlaceHolder1_ksNationality").value = Nationality;
            document.getElementById("ContentPlaceHolder1_ksEMail").value = E_Mail;
            $("#editkeystaffmodal").modal();
        }
        function deletekeystaff(pkeysatffId, pkstoremove) {
            document.getElementById("kstoremove").innerText = pkstoremove;
            document.getElementById("ContentPlaceHolder1_keysatffId").value = pkeysatffId;
            $("#deletekeystaffmodal").modal();
        }
    </script>
    <div id="deletekeystaffmodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Key Staff</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Key Staff <strong id="kstoremove"></strong>?</p>
                    <asp:TextBox runat="server" ID="keysatffId" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Remove Key Staff" ID="removekeystaff" OnClick="removekeystaff_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>

    <div id="editkeystaffmodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Key Staff Details</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="ksEntryNo" type="hidden" />
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Staff Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="ksStaffNumber" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Staff Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="ksStaffName" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Profession<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="ksProffesion" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Current Designation<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="ksCurrentDesignation" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Date of Birth<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" TextMode="Date" ID="ksDateofBirth" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Joining Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" TextMode="Date" ID="ksJoiningDate" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Years In The Firm<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" TextMode="Number" ID="ksYearsWiththeFirm" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Phone Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" TextMode="Number" ID="ksPhoneNo" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Nationality<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="ksNationality" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Email Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="ksEMail" CssClass="form-control" placeholder="Please enter details here..." />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Edit Key Staff" ID="editkeystaff" OnClick="editkeystaff_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function deletedocDetails(pdocid, pdoctodelete) {
            document.getElementById("doctodelete").innerText = pdoctodelete;
            document.getElementById("ContentPlaceHolder1_docid").value = pdocid;
            $("#deletedocmodal").modal();
        }
    </script>
    <div id="deletedocmodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Document Details</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the document <strong id="doctodelete"></strong>?</p>
                    <asp:TextBox runat="server" ID="docid" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Remove Document" ID="removedocumnebt" OnClick="removedocumnebt_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
