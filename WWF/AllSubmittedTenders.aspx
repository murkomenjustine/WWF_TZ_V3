<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AllSubmittedTenders.aspx.cs" Inherits="WWF.AllSubmittedTenders" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="WWF" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<%@ Import Namespace="System.Text" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
            <small>e-Procurement Portal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Dashboard</a></li>
            <li class="active">All Submitted Tenders</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                All Submitted Tenders By Vendors
            </div>
            <div class="panel-body form_select_multiple_users">
                <div runat="server" id="feedback"></div>
                <div class="table-responsive">
                                        <div class="row">
                        <div class="col-md-12">
                            <strong><i style="color: red">Kindly use the navigation bar at the bottom of the table to scroll to left or right of the table to be able to view more table features.</i></strong>
                        </div>
                    </div>
                    <table id="example1" class="table table-bordered table-striped table_select_multiple_users">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>
                                    <input type="checkbox" id="checkBoxAll" name="checkBoxAll" class="custom-checkbox" /></th>
                                <th>Tender No.</th>
                                <th>Tender Name</th>
                                <th>Submitted By?</th>
                                <th>Submitted Date</th>
                                <%--<th>Submitted Time</th>--%>
                                <th>Opening Date</th>
                                <th>Assigned To?</th>
                                <%--<th>Assignment Date</th>--%>
                                <th>View Details</th>
                                <th>Status</th>
                                <th>Assign Tender</th>
                                <th>Evaluation Comments</th>
                                <th>Award / No Award</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var nav = new Config().ReturnNav();
                                int counter = 0;
                                string employeeNo = Convert.ToString(Session["employeeNo"]);
                                string d = Convert.ToDateTime(DateTime.Now).ToString("yyyy-MM-dd");
                                string t = Convert.ToDateTime(DateTime.Now).ToString("HH:mm tt");
                                DateTime ndate = DateTime.ParseExact(d, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                                DateTime ntime = DateTime.ParseExact(t, "HH:mm tt", CultureInfo.InvariantCulture);
                                var data = nav.ProcurementRequest.Where(x => x.Process_Type == "Tender" && x.Document_Status == "Evaluation" && x.Asigned_User == null && x.Submitted_On_Portal == true).ToList();
                                foreach (var member in data)
                                {
                                    string clearText = member.No;
                                    try
                                    {

                                        string EncryptionKey = "@Test";
                                        byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
                                        using (Aes encryptor = Aes.Create())
                                        {
                                            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                                            encryptor.Key = pdb.GetBytes(32);
                                            encryptor.IV = pdb.GetBytes(16);
                                            using (MemoryStream ms = new MemoryStream())
                                            {
                                                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                                                {
                                                    cs.Write(clearBytes, 0, clearBytes.Length);
                                                    cs.Close();
                                                }
                                                clearText = Convert.ToBase64String(ms.ToArray());
                                            }
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        //Log.writeLog(ex);

                                    }

                                    counter++;
                            %>
                            <tr>
                                <td><%=counter %></td>
                                <td>
                                    <input type="checkbox" class="checkboxes" id="selectedactivityrecords1" name="selectedactivityrecords1" value="" /></td>
                                <td><%=member.No %></td>
                                <td><%=member.Title %></td>
                                <td><%=member.Selected_Bidder_Name %></td>
                                <td><%=Convert.ToDateTime(member.Return_Date).ToString("dd-MM-yyyy") %></td>
                                <%--<td><%=Convert.ToDateTime(member.Return_Time).ToString("HH:mm tt") %></td>--%>
                                <td><%=Convert.ToDateTime(member.Tender_Opening_Date).ToString("dd-MM-yyyy") %></td>
                                <td><%=member.First_Name + " "+ member.Last_Name %></td>
                                <%--<td><%=Convert.ToDateTime(member.Date_Assigned_to_Evaluator).ToString("dd-MM-yyyy") %></td>--%>
                                <%
                                    if (member.Tender_Opening_Date <= ndate)
                                    {
                                %>
                                <td><a href="SubmittedTenderDetails.aspx?TenderNov1=<%=clearText %>&&vendorNo=<%=member.Vendor_No %>" class="btn btn-primary"><i class="fa fa-eye"></i>View Details</a> </td>
                                <%
                                    }
                                    else
                                    {
                                %><td>
                                    <label class="btn btn-default"><i class="fa fa-times"></i>View Details</label></td>
                                <%
                                    }
                                %>
                                <%
                                    if (member.Assigned_To_Evaluator == true && member.Qualified == false && member.Submitted_By_Evaluator == false)
                                    {
                                %>
                                <td>
                                    <label class="btn btn-success"><i class="fa fa-check"></i>Assigned</label></td>
                                <%
                                    }
                                    if (member.Assigned_To_Evaluator == false && member.Qualified == false && member.Submitted_By_Evaluator == false)
                                    {
                                %>
                                <td>
                                    <label class="btn btn-danger"><i class="fa fa-check"></i>UnAssigned</label></td>
                                <%
                                    }
                                    if (member.Assigned_To_Evaluator == true && member.Qualified == true && member.Submitted_By_Evaluator == true)
                                    {
                                %>
                                <td>
                                    <label class="btn btn-success"><i class="fa fa-check"></i>Recommended</label></td>
                                <%
                                    }
                                    if (member.Assigned_To_Evaluator == true && member.Qualified == false && member.Submitted_By_Evaluator == true)
                                    {
                                %>
                                <td>
                                    <label class="btn btn-danger"><i class="fa fa-times"></i>Not Recommended</label></td>
                                <%
                                    }

                                %>
                                <%
                                    if (member.Assigned_To_Evaluator == true && member.Submitted_By_Evaluator == false)
                                    {
                                %>
                                <td>
                                    <label class="btn btn-warning" onclick="editbank('<%=member.No %>', '<%=member.Title %>', '<%=member.Asigned_User %>');"><i class="fa fa-edit"></i>Re-Assign To Another Evaluator</label>
                                </td>
                                <%
                                    }
                                    if (member.Assigned_To_Evaluator == false && member.Submitted_By_Evaluator == false)
                                    {
                                %>
                                <td>
                                    <label class="btn btn-primary" onclick="editbank('<%=member.No %>', '<%=member.Title %>', '<%=member.Asigned_User %>');"><i class="fa fa-edit"></i>Assign Tender To Evaluator</label>
                                </td>
                                <%
                                    }
                                    if (member.Assigned_To_Evaluator == true && member.Submitted_By_Evaluator == true && member.Qualified == true)
                                    {
                                %>
                                <td>
                                    <label class="btn btn-primary" onclick="editbank('<%=member.No %>', '<%=member.Title %>', '<%=member.Asigned_User %>');"><i class="fa fa-edit"></i>Engage Negotiation Team</label>
                                </td>
                                <%
                                    }
                                    if (member.Assigned_To_Evaluator == true && member.Submitted_By_Evaluator == true && member.Qualified == false)
                                    {
                                %>
                                <td>
                                    <label class="btn btn-default"><i class="fa fa-edit"></i>Engage Negotiation Team</label>
                                </td>
                                <%
                                    }
                                %>
                                <%
                                    if (member.Submitted_By_Evaluator == true)
                                    {
                                %>
                                <td><a href="TenderComments.aspx?tendorNo=<%=member.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Comments</a></td>
                                <%
                                    }
                                    else
                                    {
                                %>
                                <td>
                                    <label class="btn btn-default"><i class="fa fa-eye"></i>View Comments</label></td>
                                <%
                                    }
                                %>
                                <%
                                    if(member.Qualified == true)
                                    {
                                        %>                                <td>
                                    <label class="btn btn-success" onclick="award('<%=member.No %>', '<%=member.Title %>');"><i class="fa fa-check"></i> Award</label>
                                </td><%
                                         }
                                         else
                                         {
                                        %>                                <td>
                                    <label class="btn btn-warning" onclick="noaward('<%=member.No %>', '<%=member.Title %>');"><i class="fa fa-check"></i> No Award</label>
                                </td><%
                                         }
                                %>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-md-12">
                            <strong><i style="color: red">Kindly use the navigation bar below to scroll to left or right of the table to be able to view more table features.</i></strong>
                        </div>
                    </div>                    
                </div>
                <br />
                <br />
                <div class="row">
                    <div class="col-md-12">
                        <div class="box box-success">
                            <div class="box-header with-border">
                                <h3 class="box-title"><strong>Assign Multiple Tenders to Evaluators</strong></h3>
                            </div>
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>
                                            Use the checkboxes on the table above to select the tenders to assign / Re-Assign to an evaluator  Multiple Tenders to Engagement Team.
                                        </p>
                                        <p>
                                            Then proceed to select the evaluator from the list and assign the tenders using the button (Assign Multiple Tenders to Evaluator / Assign Multiple Tenders to Engagement Team).
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
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Evaluator One</strong>
                            <asp:DropDownList runat="server" ID="evaluatormultiple" AppendDataBoundItems="true" CssClass="form-control select2 evaluatormultiplec">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Evaluator Two</strong>
                            <asp:DropDownList runat="server" ID="evaltwo" AppendDataBoundItems="true" CssClass="form-control select2 evaltwo">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Evaluator Three</strong>
                            <asp:DropDownList runat="server" ID="evalthree" AppendDataBoundItems="true" CssClass="form-control select2 evalthree">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Evaluator Four</strong>
                            <asp:DropDownList runat="server" ID="evalfour" AppendDataBoundItems="true" CssClass="form-control select2 evalfour">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Evaluator Five</strong>
                            <asp:DropDownList runat="server" ID="evalfive" AppendDataBoundItems="true" CssClass="form-control select2 evalfive">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Message To Evaluator (<i>Maximum of 250 characters</i>)</strong>
                            <asp:TextBox runat="server" ID="messagetoeval" TextMode="MultiLine" Height="150" CssClass="form-control messagetoeval" placeholder="Enter Details Here ..." />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-lg-12">
                        <div class="panel-footer">
                            <button type="button" class="btn btn-success pull-right btn_assigntoevaluator" id="btn_assigntoevaluator" name="btn_assigntoevaluator">Assign / Re-Assign Multiple Tenders to Evaluator</button>
                            <%--                            <button type="button" class="btn btn-success pull-right btn_assigntoeengagementteam" id="btn_assigntoeengagementteam" name="btn_assigntoeengagementteam">Assign Multiple Tenders to Engagement Team</button>--%>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        function editbank(emp, title) {
            document.getElementById("ContentPlaceHolder1_tenderno").value = emp;
            document.getElementById("ContentPlaceHolder1_tendertitle").value = emp;
            $("#editbankmodal").modal();
        }
        function award(emp, title) {
            document.getElementById("ContentPlaceHolder1_atenderno").value = emp;
            document.getElementById("ContentPlaceHolder1_atitle").value = title;
            $("#awardmodal").modal();
        }
        function noaward(emp, title) {
            document.getElementById("ContentPlaceHolder1_ntenderno").value = emp;
            document.getElementById("ContentPlaceHolder1_ntendertitle").value = title;
            $("#noawardmodal").modal();
        }
    </script>

    <div id="editbankmodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Assign Tender To Evaluator</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="tenderno" type="hidden" />
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Tender Title<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="tendertitle" CssClass="form-control" ReadOnly="True" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Select Evaluator<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:DropDownList runat="server" ID="evaluator" AppendDataBoundItems="true" CssClass="form-control select2">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                            <div class="form-group">
                                <strong>Message To Evaluator (<i>Maximum of 250 characters</i>)<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="smstoeval" CssClass="form-control" TextMode="MultiLine" Height="150" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Assign Tender To Evaluator" ID="assign" OnClick="assign_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>
        <div id="awardmodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Award Tender</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="atenderno" type="hidden" />
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                            <div class="form-group">
                                <strong>Tender Title<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="atitle" CssClass="form-control" ReadOnly="True" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                            <div class="form-group">
                                <strong>Award Comments(<i>Maximum of 250 characters</i>)<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="acomments" CssClass="form-control" TextMode="MultiLine" Height="150" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Award" ID="award" OnClick="award_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>
            <div id="noawardmodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Award Tender</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="ntenderno" type="hidden" />
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                            <div class="form-group">
                                <strong>Tender Title<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="ntendertitle" CssClass="form-control" ReadOnly="True" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                            <div class="form-group">
                                <strong>Award Comments(<i>Maximum of 250 characters</i>)<span class="text-danger" style="font-size: 25px">*</span></strong>
                                <asp:TextBox runat="server" ID="ncomments" CssClass="form-control" TextMode="MultiLine" Height="150" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="No Award" ID="noaward" OnClick="noaward_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>




