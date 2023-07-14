<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsultantProfile.aspx.cs" Inherits="WWF.ConsultantProfile" %>

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
            <li class="active">Consultant Registration</li>
        </ol>
    </section>
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 5 || step < 1)
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
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="generalfeedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Consultant Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="consultantname" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="consultantname" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Email Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="emailaddress" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="emailaddress" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Phone Number<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="phoneno" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="phoneno" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Physical Address<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="physicaladdress" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="physicaladdress" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Country of Origin<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:DropDownList runat="server" ID="countryoforigin" CssClass="form-control select2">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="countryoforigin" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Tax Registration No.<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="taxno" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="taxno" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
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
                Qualifications & Skills. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 5<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="qualificationfeedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Qualification / Skill<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="qualification" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="qualification" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Year Attained<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Number" ID="yearattained" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="yearattained" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Duration<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" TextMode="Number" ID="duration" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="duration" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Save Qualification Details" ID="savequalification" OnClick="savequalification_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>Saved Qualifications</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <table id="example1" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Qualification / Skill</th>
                                            <th>Year Obtained</th>
                                            <th>Duration</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            int counter = 0;
                                            var qualData = nav.ConsultantQualification.Where(r => r.VendoNo == vendorNo);
                                            foreach (var t in qualData)
                                            {
                                                counter++;
                                        %>
                                        <tr>
                                            <td><%=counter %></td>
                                            <td><%=t.Qualification %></td>
                                            <td><%=t.Year_Obtained %></td>
                                            <td><%=t.Duration %></td>
                                            <td>
                                                <label class="btn btn-primary" onclick="editqualification('<%=t.EntryNo %>','<%=t.Qualification %>','<%=t.Year_Obtained %>','<%=t.Duration %>');"><i class="fa fa-edit"></i>Edit</label>
                                            </td>
                                            <td>
                                                <label class="btn btn-danger" onclick="removequalification('<%=t.EntryNo %>','<%=t.Qualification %>');"><i class="fa fa-thrash"></i>Remove</label>
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
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="back" OnClick="back_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="nexttostep3" OnClick="nexttostep3_Click" CausesValidation="false" />
            <div class="clearfix"></div>
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
                Past Experience. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 5<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Save Past Experience Details" ID="pastexperiencedetails" />
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Skip Past Experience" ID="skippastexperience" />
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
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="backtostep3" OnClick="back_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="nexttostep4" OnClick="nexttostep4_Click" CausesValidation="false" />
            <div class="clearfix"></div>
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
                Referees. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 5<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="refereeFeedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Name<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="refname" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="refname" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Phone<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="refphone" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="refphone" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Email<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:TextBox runat="server" ID="refemail" CssClass="form-control" placeholder="Please enter details here..." />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="refemail" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Save Referee Details" ID="savereferee" OnClick="savereferee_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>Saved Referees</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <table id="example6" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Name</th>
                                            <th>Phone</th>
                                            <th>Email</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            int counter = 0;
                                            var refereeData = nav.ConsultantReferee.Where(r => r.VendorNo == vendorNo);
                                            foreach (var t in refereeData)
                                            {
                                                counter++;
                                        %>
                                        <tr>
                                            <td><%=counter %></td>
                                            <td><%=t.Name %></td>
                                            <td><%=t.Phone %></td>
                                            <td><%=t.Email %></td>
                                            <td>
                                                <label class="btn btn-primary" onclick="editbank('<%=t.EntryNo %>','<%=t.Name %>','<%=t.Phone %>','<%=t.Email %>');"><i class="fa fa-edit"></i>Edit</label>
                                            </td>
                                            <td>
                                                <label class="btn btn-danger" onclick="removebank('<%=t.EntryNo %>','<%=t.Name %>');"><i class="fa fa-thrash"></i>Remove</label>
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
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Back" ID="backtostep4" OnClick="back_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="nexttostep5" OnClick="nexttostep5_Click" CausesValidation="false" />
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
                Document Upload. Kindly note that fields marked with asterisk (<span class="text-danger" style="font-size: 25px">*</span>) are mandatory.
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 5 of 5<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
                                                    <th>Description</th>
                                                    <th>Requirement Type</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    int counter = 0;
                                                    var docdata = nav.eProcDocuments.Where(x => x.Procurement_Process == "Registration" && x.Type == "Consultant").ToList();
                                                    foreach (var member in docdata)
                                                    {
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>
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
                            <strong>Select Document<span class="text-danger" style="font-size: 25px">*</span></strong>
                            <asp:FileUpload runat="server" ID="filetoupload" CssClass="form-control" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="filetoupload" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Upload Document" ID="documentuploaddetails" OnClick="documentuploaddetails_Click" />
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
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Submit Details" ID="submitprofiledetails" OnClick="submitprofiledetails_Click" CausesValidation="false" />
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
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Remove Bank" ID="removebank" CausesValidation="false" />
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
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Edit Bank Details" ID="editbank" CausesValidation="false" />
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
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Remove Past Experience" ID="removepastexperience" CausesValidation="false" />
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
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Edit Past Experience Details" ID="editpastexperience" CausesValidation="false" />
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

