<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProfileView.aspx.cs" Inherits="WWF.ProfileView" %>

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
            <li class="active">Supplier Profile</li>
        </ol>
    </section>
    <%
        string vendorNo = Convert.ToString(Session["vendorNo"]);
        var nav = new Config().ReturnNav();
    %>
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-success">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>SUPPLIER PROFILE</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p>
                                    This is the section that contains all your profile details e.g general details, company details, communication details e.t.c. Kindly confirm everything is correct before proceeding to tender application.
                                </p>
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
                <!-- Custom Tabs -->
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_1" data-toggle="tab">General Details</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Contact Details</a></li>
                        <li><a href="#tab_3" data-toggle="tab">Company Profile</a></li>
                        <li><a href="#tab_4" data-toggle="tab">Bank Profile</a></li>
                        <li><a href="#tab_5" data-toggle="tab">Shareholder Details</a></li>
                        <li><a href="#tab_7" data-toggle="tab">Past Experience</a></li>
                        <li><a href="#tab_10" data-toggle="tab">Key Staff</a></li>
                        <li><a href="#tab_11" data-toggle="tab">Documents</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab_1">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    General Details
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="feedback"></div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Supplier Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="suppliername" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Tax Registration No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="taxregistrationno" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Tax Registration Country<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="taxregistrationcountry" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Registration/Incorporation Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="registrationdate" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Registration/Incorporation No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="registrationincorporationno" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Language<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="language" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Business Type<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="businesstype" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Ownership Type<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="ownershiptype" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Supplier Type<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="suppliertype" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Industry Group<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="industrygroup" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Vision (Max 200 characters)</strong>
                                                <asp:TextBox runat="server" ID="vision" CssClass="form-control" TextMode="MultiLine" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Mission (Max 200 characters)</strong>
                                                <asp:TextBox runat="server" ID="mission" CssClass="form-control" TextMode="MultiLine" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12 col-sm-12">
                                            <div class="form-group">
                                                <strong>Supplier special Group?</strong>
                                                <asp:CheckBox runat="server" ID="specialgroup" CssClass="form-control" Enabled="false" />
                                            </div>
                                        </div>
                                    </div>
                                    <div runat="server" id="divspecialcategory" visible="false">
                                        <div class="row">
                                            <div class="col-lg-6 col-sm-6">
                                                <div class="form-group">
                                                    <strong>Certificate No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                    <asp:TextBox runat="server" ID="certificateno" CssClass="form-control" ReadOnly="true" />
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-sm-6">
                                                <div class="form-group">
                                                    <strong>Supplier Category<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                    <asp:TextBox runat="server" ID="suppliercategory" CssClass="form-control" ReadOnly="true" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6 col-sm-6">
                                                <div class="form-group">
                                                    <strong>Certifying Agency<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                    <asp:TextBox runat="server" ID="certifyingagaency" CssClass="form-control" ReadOnly="true" />
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-sm-6">
                                                <div class="form-group">
                                                    <strong>Product/Service<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                    <asp:TextBox runat="server" ID="productservice" CssClass="form-control" ReadOnly="true" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6 col-sm-6">
                                                <div class="form-group">
                                                    <strong>Cerificate Effective Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                    <asp:TextBox runat="server" TextMode="Date" ID="certificateeffectivedate" CssClass="form-control" ReadOnly="true" />
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-sm-6">
                                                <div class="form-group">
                                                    <strong>Certificate Expiry Date<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                    <asp:TextBox runat="server" ID="certificateexpirydate" CssClass="form-control" ReadOnly="true" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_2">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Communication & Contact Details
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Ccommunicationfeedback"></div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="address" CssClass="form-control" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Address 2<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="address2" CssClass="form-control" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Phone<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="phone" CssClass="form-control" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Email<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="email" CssClass="form-control" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Building/House No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="buildinghouse" CssClass="form-control" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Floor<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="floor" CssClass="form-control" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Plot No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="plot" CssClass="form-control" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Street<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="street" CssClass="form-control" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_3">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Company Profile
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="businessprofilefeedback"></div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Company Size<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="companysizex" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Nominal Capital<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" type="number" ID="nominalcapital" CssClass="form-control" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Dealer Type<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="dealertypex" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Max value of Business<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" type="number" ID="maxvalueofbusiness" CssClass="form-control" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Supplier Category<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="businesprofilesuppliercategoryx" CssClass="form-control" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Nature of Business<span class="text-danger" style="font-size: 25px">*</span></strong>
                                                <asp:TextBox runat="server" ID="natureofbusiness" CssClass="form-control" TextMode="MultiLine" placeholder="Please enter details here..." ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_4">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Bank Profile
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div9"></div>
                                    <table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Bank Code</th>
                                                <th>Bank Name</th>
                                                <th>Bank Branch No.</th>
                                                <th>Bank Account No.</th>
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
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_5">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Shareholder Details
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div12"></div>
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
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter1 = 0;
                                                var shareholderdata = nav.VendorShareholderDetails.Where(r => r.Vendor_No == vendorNo);
                                                foreach (var t in shareholderdata)
                                                {
                                                    counter1++;
                                            %>
                                            <tr>
                                                <td><%=counter1 %></td>
                                                <td><%=t.Name %></td>
                                                <td><%=t.ID_Passport_No %></td>
                                                <td><%=t.Citizenship_Type %></td>
                                                <td><%=t.Entity_Ownership %></td>
                                                <td><%=t.Phone_No %></td>
                                                <td><%=t.E_Mail %></td>
                                                <td><%=t.Address %></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_7">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Past Experience
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div1"></div>
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
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter2 = 0;
                                                var data = nav.VendorPastExperience.Where(r => r.Vendor_No == vendorNo);
                                                foreach (var t in data)
                                                {
                                                    counter2++;
                                            %>
                                            <tr>
                                                <td><%=counter2 %></td>
                                                <td><%=t.Client_Name %></td>
                                                <td><%=t.Assignment_Name %></td>
                                                <td><%=Convert.ToDateTime(t.Assignment_Start_Date).ToString("dd-MM-yyyy") %></td>
                                                <td><%=Convert.ToDateTime(t.Assignment_End_Date).ToString("dd-MM-yyyy") %></td>
                                                <td><%=t.Project_Scope_Summary %></td>
                                                <td><%=t.Assignment_Value_LCY %></td>
                                                <td><%=t.Contract_Ref_No %></td>
                                                <td><%=t.Address %></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_10">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Key Staff
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div4"></div>
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
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter4 = 0;
                                                var ksdata = nav.VendorProffessionalStaff.Where(r => r.Vendor_No == vendorNo);
                                                foreach (var t in ksdata)
                                                {
                                                    counter4++;
                                            %>
                                            <tr>
                                                <td><%=counter4 %></td>
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
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_11">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Document List
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div6"></div>
                                    <table id="example9" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Document Name</th>
                                                <th>File Name</th>
                                                <th>Certificate No</th>
                                                <th>Issue Date</th>
                                                <th>Expiry Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter5 = 0;
                                                var regdocdata = nav.VendorFiledRegDocument.Where(x => x.Vendor_No == vendorNo && x.Procurement_Process == "Registration").ToList();
                                                foreach (var member in regdocdata)
                                                {
                                                    counter5++;
                                            %>
                                            <tr>
                                                <td><%=counter5 %></td>
                                                <td><%=member.Description %></td>
                                                <td><%=member.File_Name %></td>
                                                <td><%=member.Certificate_No %></td>
                                                <td><%=Convert.ToDateTime(member.Issue_Date).ToString("dd-MM-yyyy") %></td>
                                                <td><%=Convert.ToDateTime(member.Expiry_Date).ToString("dd-MM-yyyy") %></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.tab-content -->
                </div>
                <!-- nav-tabs-custom -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->
</asp:Content>

