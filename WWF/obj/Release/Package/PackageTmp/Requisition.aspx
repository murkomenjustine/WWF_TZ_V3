<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Requisition.aspx.cs" Inherits="WWF.Requisition" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="WWF" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>World Wide Fund for Nature (WWF) Tanzania
            <small>e-Procurement Portal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Purchase Requisition</li>
        </ol>
    </section>
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 3 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step == 1)
        {
    %>

    <!-- Main content -->
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Requisition General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div id="generalFeedback" runat="server"></div>

                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label class="control-label">Employee Number</label>
                            <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label class="control-label">Employee Name</label>
                            <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label class="control-label">Employee Name</label>
                            <asp:Label runat="server" class="form-control" readonly="true"> <%=Convert.ToDateTime(DateTime.Now).ToString("dd/MM/yyyy") %></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label class="control-label">Status</label>
                            <asp:Label runat="server" class="form-control" readonly="true"> <%="Open" %></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Process Type</strong>
                            <asp:DropDownList runat="server" ID="tprocesstype" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="tprocesstype" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Currency<span class="text-danger" style="font-size: 15px">*</span></strong>
                            <asp:DropDownList runat="server" ID="currency" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="currency" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Description<span class="text-danger" style="font-size: 15px">*</span></strong>
                            <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="Please Enter Description" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="description" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Location<span class="text-danger" style="font-size: 15px">*</span></strong>
                            <asp:DropDownList runat="server" ID="location" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="location" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Project<span class="text-danger" style="font-size: 15px">*</span></strong>
                            <asp:DropDownList runat="server" ID="project" CssClass="form-control select2" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="project" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Due Date<span class="text-danger" style="font-size: 15px">*</span></strong>
                            <asp:TextBox runat="server" ID="prof_endDate" CssClass="form-control" placeholder="Please Enter Due Date" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="prof_endDate" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="next" OnClick="next_Click" />
                <div class="clearfix"></div>
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
                Requisition Line Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="linesFeedback"></div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Transaction Code<span class="text-danger" style="font-size: 15px">*</span></strong>
                        <asp:DropDownList runat="server" ID="transactionDesc" CssClass="form-control select2" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" InitialValue="--Select--" ControlToValidate="transactionDesc" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Description<span class="text-danger" style="font-size: 15px">*</span></strong>
                        <asp:TextBox runat="server" ID="txtdescription" CssClass="form-control" placeholder="Enter Description" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="txtdescription" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>

                <div class="col-lg-6 col-sm-6" style="display: none">
                    <div class="form-group">
                        <strong>Number of Staff<span class="text-danger" style="font-size: 15px">*</span></strong>
                        <asp:TextBox runat="server" ID="staff" CssClass="form-control" TextMode="Number" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Quantity Requested<span class="text-danger" style="font-size: 15px">*</span></strong>
                        <asp:TextBox runat="server" ID="quantityRequested" CssClass="form-control" TextMode="Number" placeholder="Enter Quantity" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="quantityRequested" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Direct Unit Cost<span class="text-danger" style="font-size: 15px">*</span></strong>
                        <asp:TextBox runat="server" ID="directUnitCost" CssClass="form-control" TextMode="Number" placeholder="Enter Unit Cost" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="directUnitCost" ErrorMessage="Please fill this field, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>


                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-primary btn-block" Text="Add Requisition Lines" ID="addrequisitionlines" OnClick="addrequisitionlines_Click" />
                    </div>
                </div>
                <table class="table table-bordered table-striped" id="example2">
                    <thead>
                        <tr>
                            <th>Transaction Code</th>
                            <th>Transaction Description</th>
                            <th>Type</th>
                            <th>Quantity Requested </th>
                            <th>Description </th>
                            <th>Unit Cost</th>
                            <th>Total Line Amount </th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String requisitionNo = Request.QueryString["requisitionNo"];
                            var nav = new Config().ReturnNav();
                            var purhaseLines = nav.PurchaseLines.Where(r => r.Document_No == requisitionNo);
                            foreach (var line in purhaseLines)
                            {
                        %>
                        <tr>
                            <td><% =line.Transaction_Code1 %></td>
                            <td><% =line.Transaction_Description %></td>
                            <td><% =line.Type %></td>
                            <td><% =line.Qty_Requested %></td>
                            <td><% =line.Description %></td>
                            <td><%=String.Format("{0:n}", Convert.ToDouble(line.Direct_Unit_Cost)) %></td>
                            <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>

                            <td>
                                <label class="btn btn-danger" onclick="removeLine('<% =line.Description %>','<%=line.Line_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Previous" ID="backtostepone" OnClick="backtostepone_Click" CausesValidation="false" />
                <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Next" ID="nexttostepthree" OnClick="nexttostepthree_Click" CausesValidation="false" />

                <div class="clearfix"></div>
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
                Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="documentsfeedback"></div>
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                        <div class="form-group">
                            <strong>Select file to upload:</strong>
                            <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                        <div class="form-group">
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-primary" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click" CausesValidation="false" />
                        </div>
                    </div>
                </div>
                <table class="table table-bordered table-striped" id="example3">
                    <thead>
                        <tr>
                            <th>Document Title</th>
                            <th>Download</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try
                            {
                                String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Purchase Requisition Header/";
                                String imprestNo = Request.QueryString["requisitionNo"];
                                String documentDirectory = filesFolder + imprestNo + "/";
                                if (Directory.Exists(documentDirectory))
                                {
                                    foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                    {
                                        String url = documentDirectory;
                        %>
                        <tr>
                            <td><% =file.Replace(documentDirectory, "") %></td>
                            <td><a href="<%=filesFolder %><% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                        </tr>
                        <%
                                    }
                                }
                            }
                            catch (Exception)
                            {

                            }%>
                    </tbody>
                </table>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Previous" ID="backtosteptwo" OnClick="backtosteptwo_Click" CausesValidation="false" />
                <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="sendApproval_Click" CausesValidation="false" /><div class="clearfix"></div>
            </div>
        </div>
    </section>

    <%
        }
    %>
    <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainBody_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>

    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Delete File" ID="deletefilebtn" OnClick="deletefilebtn_Click" CausesValidation="false" />
                </div>
            </div>

        </div>
    </div>

    <script>
        function removeLine(itemName, lineNo) {
            document.getElementById("itemName").innerText = itemName;
            document.getElementById("MainBody_lineNo").value = lineNo;
            $("#removeLineModal").modal();
        }
    </script>
    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the item <strong id="itemName"></strong>from the Purchase Requisition?</p>
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Delete Line" ID="removelinebtn" OnClick="removelinebtn_Click" CausesValidation="false" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
