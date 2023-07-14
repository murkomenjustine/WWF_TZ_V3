<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TenderDetails.aspx.cs" Inherits="WWF.TenderDetails" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="WWF" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<%@ Import Namespace="System.Text" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>e-Procurement Portal</a></li>
            <li class="active">Tender Details</li>
        </ol>
    </section>
    <%
        var nav = new Config().ReturnNav();
        string cipherText = Request.QueryString["TenderNo"];
        try
        {
            string EncryptionKey = "@Test";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
        }
        catch (Exception ex)
        {

        }

    %>
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-success">
                    <div class="box-header with-border">
                        <h3 class="box-title"><strong>TENDER DETAILS</strong></h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p>
                                    The e-Bidding Portal enables the tenderers to view all Active Invitation For Supply (IFS) Notices, download the related tender documents and allow for online submission of their bid responses.
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
                <div class="box box-success">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Apply for This Tender" ID="apply" OnClick="apply_Click" />
                                <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Cancel Application" ID="cancel" CausesValidation="false" OnClick="cancel_Click" />
                                <div class="clearfix"></div>
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
                        <li class="active"><a href="#tab_1" data-toggle="tab">Tender Overview</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Purchase Items/Services</a></li>
                        <li><a href="#tab_3" data-toggle="tab">Tender Requirements</a></li>
                        <li><a href="#tab_4" data-toggle="tab">Project Works</a></li>
                        <li><a href="#tab_5" data-toggle="tab">Evaluation Criteria</a></li>
                        <li><a href="#tab_6" data-toggle="tab">Tender Documents</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab_1">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Tender General Details.
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div5"></div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Tender Description</strong>
                                                <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Tender Notice No</strong>
                                                <asp:TextBox runat="server" ID="tenderno" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Procurement Method</strong>
                                                <asp:TextBox runat="server" ID="procurementmethod" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Mandatory Prebid Meeting</strong>
                                                <asp:TextBox runat="server" ID="mandatorymeeting" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Document Date</strong>
                                                <asp:TextBox runat="server" ID="documentdate" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Envelope Type</strong>
                                                <asp:TextBox runat="server" ID="bidenvelopetype" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>External Document No</strong>
                                                <asp:TextBox runat="server" ID="externaldocumentno" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Tender Validity Duration (In Days)</strong>
                                                <asp:TextBox runat="server" ID="tendervalidityduration" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Location</strong>
                                                <asp:TextBox runat="server" ID="location" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Tender Validity Expiry Date</strong>
                                                <asp:TextBox runat="server" ID="tenderexpirydate" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Requisition Product Group</strong>
                                                <asp:TextBox runat="server" ID="requisitionprodgroup" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Mandatory Special Group Reserve?</strong>
                                                <asp:TextBox runat="server" ID="manspecialgroupreserv" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Target Bidder Group</strong>
                                                <asp:TextBox runat="server" ID="targetbiddergroup" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Selection Method</strong>
                                                <asp:TextBox runat="server" ID="bidselectionmethod" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Critical Submission Details.
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div3"></div>
                                                                        <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Submission Start Date</strong>
                                                <asp:TextBox runat="server" ID="submissionstartdate" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Submission Start Time</strong>
                                                <asp:TextBox runat="server" ID="submissionstarttime" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Submission End Date</strong>
                                                <asp:TextBox runat="server" ID="submissiondate" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Submission End Time</strong>
                                                <asp:TextBox runat="server" ID="submissiontime" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Address 2</strong>
                                                <asp:TextBox runat="server" ID="address2" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Address</strong>
                                                <asp:TextBox runat="server" ID="address" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Pre Bid Meeting Date</strong>
                                                <asp:TextBox runat="server" ID="prebidmeetingdate" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Pre-Bid Meeting Address</strong>
                                                <asp:TextBox runat="server" ID="prebidmeetingaddress" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Country</strong>
                                                <asp:TextBox runat="server" ID="country" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>City</strong>
                                                <asp:TextBox runat="server" ID="city" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Opening Date</strong>
                                                <asp:TextBox runat="server" ID="bidopeningdate" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Opening Time</strong>
                                                <asp:TextBox runat="server" ID="bidopeningtime" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                         <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Phone Number</strong>
                                                <asp:TextBox runat="server" ID="phonenum" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Opening Venue</strong>
                                                <asp:TextBox runat="server" ID="bidopeningvunue" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Tender Box Location</strong>
                                                <asp:TextBox runat="server" ID="tenderboxlocation" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Procuring Entity Name</strong>
                                                <asp:TextBox runat="server" ID="procurringentityname" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Primary Tender Submission Address</strong>
                                                <asp:TextBox runat="server" ID="primarytendersubmissionaddress" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Postal Code</strong>
                                                <asp:TextBox runat="server" ID="postalcode" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Tender Addendum Notices
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div4"></div>
                                    <table id="example2" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Addendum Notice No</th>
                                                <th>Addendum Date</th>
                                                <th>Description</th>
                                                <th>Addendum Instructions</th>
                                                <th>View Details</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                                                                 <%
                                                int counter1 = 0;
                                                var queryA = nav.tenderAddendums.Where(x => x.Invitation_Notice_No == cipherText).ToList();
                                                foreach (var member in queryA)
                                                {

                                                    counter1++;
                                            %>
                                            <tr>
                                                <td><%=counter1 %></td>
                                                <td><%=member.Addendum_Notice_No %></td>
                                                <td><%=Convert.ToDateTime(member.Document_Date).ToString("dd/MM/yyyy") %></td>
                                                <td><%=member.Description %></td>
                                                <td><%=member.Addendum_Instructions %></td>
                                                <td><a href="ElectricityLines_New.aspx?docNo=<%="" %>" class="btn btn-success"><i class="fa fa-eye"></i> View Details</a> </td>

                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_2">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box box-success">
                                        <div class="box-header with-border">
                                            <h3 class="box-title"><strong>KEY NOTES</strong></h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <p>
                                                        The bidder shall be required to provide pricing information for the Goods and Services listed below. Please note the following:
                                                    </p>
                                                    <ul>
                                                        <li>The bidder must quote for the full quantity on each line.</li>
                                                        <li>The Price Quote Model is used to determine how the pricing for each line shall be done.</li>
                                                        <li>Bidder Pricing-This means that the bidder is allowed to set their best price for each line. There is no restriction on the amount that the bidder can quote in this case.</li>
                                                        <li>Flat Amount from Buyer-This option is used when the Procuring Entity (The Buyer) has defined a specific standard amount that all bidders shall adopt for a specific purchase line. In this case, the bidder cannot quote more than the set standard amount/limit.</li>
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
                            </div>
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Purchase Items/Services
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div2"></div>
                                    <table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Type</th>
                                                <th>Description</th>
                                                <th>Quantity Required</th>
                                                <th>Unit of Measure</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter = 0;
                                                var query = nav.purchaseCodeLines.Where(x => x.Standard_Purchase_Code == cipherText).ToList();
                                                foreach (var member in query)
                                                {

                                                    counter++;
                                            %>
                                            <tr>
                                                <td><%=counter %></td>
                                                <td><%=member.Type %></td>
                                                <td><%=member.Description %></td>
                                                <td><%=member.Quantity %></td>
                                                <td><%=member.Unit_of_Measure_Code %></td>

                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_3">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Key Tender Requirements
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div1"></div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid security Required</strong>
                                                <asp:TextBox runat="server" ID="TextBox4" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Performance Security Required</strong>
                                                <asp:TextBox runat="server" ID="TextBox5" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Security Percentage</strong>
                                                <asp:TextBox runat="server" ID="TextBox33" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Performance Security Percentage</strong>
                                                <asp:TextBox runat="server" ID="TextBox34" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Advance Payment security Required</strong>
                                                <asp:TextBox runat="server" ID="TextBox35" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Security Validity Duration</strong>
                                                <asp:TextBox runat="server" ID="TextBox36" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Advance Payment security</strong>
                                                <asp:TextBox runat="server" ID="TextBox37" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Security Validity Expiry Date</strong>
                                                <asp:TextBox runat="server" ID="TextBox38" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Advance Amount Limit</strong>
                                                <asp:TextBox runat="server" ID="TextBox39" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Insurance Cover Required</strong>
                                                <asp:TextBox runat="server" ID="TextBox40" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Appointer of Bidder Arbitrator</strong>
                                                <asp:TextBox runat="server" ID="TextBox41" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box box-success">
                                        <div class="box-header with-border">
                                            <h3 class="box-title"><strong>KEY NOTES</strong></h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <p>
                                                        The section below lists the accepted forms of Bid/Tender security that the tenderer can submit. Please take note of the validity dates, mimimum value/Amount (In local currency) and the issuing institutions that are acceptable.
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
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Bid/Tender Security Requirements
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div6"></div>
                                    <table id="example5" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Forms of Security</th>
                                                <th>Security Type</th>
                                                <th>Nature of Security</th>
                                                <th>Description</th>
                                                <th>Minimum Bid Security Amounts (TZ)</th>
                                                <th>Bid Security Validity Expiry Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Tender Processing Fees
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div7"></div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Charge Code</strong>
                                                <asp:TextBox runat="server" ID="TextBox42" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bank Account Name</strong>
                                                <asp:TextBox runat="server" ID="TextBox43" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Charge</strong>
                                                <asp:TextBox runat="server" ID="TextBox44" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Charge bank Branch</strong>
                                                <asp:TextBox runat="server" ID="TextBox45" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Charge Bank Code</strong>
                                                <asp:TextBox runat="server" ID="TextBox46" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bid Charge Bank Account No</strong>
                                                <asp:TextBox runat="server" ID="TextBox47" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Bank Name</strong>
                                                <asp:TextBox runat="server" ID="TextBox48" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Tender Required Documents
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div8"></div>
                                    <table id="example6" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Document Type</th>
                                                <th>Description</th>
                                                <th>Requirement Type</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_4">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box box-success">
                                        <div class="box-header with-border">
                                            <h3 class="box-title"><strong>PERSONNEL SPECIFICATIONS</strong></h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <p>
                                                        This section summarizes the personnel requirements for this Tender. Please take note of the minimum number of staff required for each Project Role and their minimum qualification and experience requirements.
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
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Personnel Specifications List
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div9"></div>
                                    <table id="example7" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Staff No.</th>
                                                <th>Description</th>
                                                <th>Staff Category</th>
                                                <th>Minimum No. of Staff Required</th>
                                                <th>Required Type</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter2 = 0;
                                                var queryB = nav.ifsKeyStaff.Where(x => x.IFS_Code == cipherText).ToList();
                                                foreach (var member in queryB)
                                                {

                                                    counter2++;
                                            %>
                                            <tr>
                                                <td><%=counter2 %></td>
                                                <td><%=member.Staff_Role_Code %></td>
                                                <td><%=member.Title_Designation_Description %></td>
                                                <td><%=member.Staff_Category %></td>
                                                <td><%=member.Min_No_of_Recomm_Staff %></td>
                                                <td><%=member.Requirement_Type %></td>

                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box box-success">
                                        <div class="box-header with-border">
                                            <h3 class="box-title"><strong>EQUIPMENT SPECIFICATIONS</strong></h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <p>
                                                        This section provides the details of the equipment that a contractor is required to provide for the Project Works. Please take note of the minimum quantity for each equipment type. The contractor is required to provide documents that support the ownership or lease of each equipment, as part of their bid response.
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
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Equipment Specifications List
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div10"></div>
                                    <table id="example8" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Equipment Type Code</th>
                                                <th>Category</th>
                                                <th>Description</th>
                                                <th>Minimum Required Quantity</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int counter3 = 0;
                                                var queryC = nav.ifsEquipspecs.Where(x => x.Document_No == cipherText).ToList();
                                                foreach (var member in queryC)
                                                {

                                                    counter3++;
                                            %>
                                            <tr>
                                                <td><%=counter3 %></td>
                                                <td><%=member.Equipment_Type_Code %></td>
                                                <td><%=member.Category %></td>
                                                <td><%=member.Description %></td>
                                                <td><%=member.Minimum_Required_Qty %></td>
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
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box box-success">
                                        <div class="box-header with-border">
                                            <h3 class="box-title"><strong>KEY NOTES</strong></h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <p>
                                                        Kindly take note of the following:
                                                    </p>
                                                    <ul>
                                                        <li>The evaluation of all tender responses shall be based on weighted average scoring of technical & financial proposals.</li>
                                                        <li>Preliminary evaluation, technical evaluation and financial evaluation shall strictly be done as per the guidelines provided in the Public Procurement & Assets Disposal Act (PPADA).</li>
                                                        <li>Unless stated otherwise, the default bid selection method applicable to this Tender shall be the Quality and Cost Based Selection method (QCBS).</li>
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
                            </div>
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Bid Scoring Template
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div11"></div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Template ID</strong>
                                                <asp:TextBox runat="server" ID="TextBox49" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Description</strong>
                                                <asp:TextBox runat="server" ID="TextBox50" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Total Technical Evaluation Core %</strong>
                                                <asp:TextBox runat="server" ID="TextBox51" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Total Financial Evaluation Core %</strong>
                                                <asp:TextBox runat="server" ID="TextBox52" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Total Preliminary (Mandatory Checks Score %)</strong>
                                                <asp:TextBox runat="server" ID="TextBox53" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-sm-6">
                                            <div class="form-group">
                                                <strong>Total Weighted Score</strong>
                                                <asp:TextBox runat="server" ID="TextBox54" CssClass="form-control" placeholder="" ReadOnly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Summarized Evaluation Criteria
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div12"></div>
                                    <table id="example9" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Preliminary Evaluation</th>
                                                <th>Technical Evaluation</th>
                                                <th>Financial Evaluation</th>
                                                <th>Total Weighted Score (%)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%

                                                var tenderquery = nav.invitetoTenders.Where(x => x.Code == cipherText && x.Published == true && x.Document_Status == "Published" && x.Procurement_Method == "Open Tender").ToList();
                                                int counter4 = 0;
                                                var BidTemplateID = "";
                                                foreach (var tenders in tenderquery)
                                                {
                                                    BidTemplateID = tenders.Bid_Scoring_Template;
                                                }
                                                if (BidTemplateID != null)
                                                {
                                                    var queryD = nav.bidscoringTemplate.Where(x => x.Document_No == BidTemplateID).ToList();
                                                    foreach (var member in queryD)
                                                    {

                                                        counter4++;
                                            %>
                                            <tr>
                                                <td><%=counter4 %></td>
                                                <td><%=member.Total_Preliminary_Checks_Score %></td>
                                                <td><%=member.Total_Technical_Evaluation %></td>
                                                <td><%=member.Total_Financial_Evaluation %></td>
                                                <td><%=member.Total_Assigned_Score_Weight %></td>
                                            </tr>

                                            <%
                                                    }
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_6">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    View/Download Tender Document
                                </div>
                                <div class="panel-body">
                                    <div runat="server" id="Div13"></div>
                                    <table id="example4" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Tender Document</th>
                                                <th>Download</th>
                                            </tr>
                                        </thead>
                                        <tbody>
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
