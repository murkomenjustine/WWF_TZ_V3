<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubmittedEvaluation.aspx.cs" Inherits="WWF.SubmittedEvaluation" %>

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
            <li class="active">Submitted Tender Evaluation</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Submitted Tender Evaluation
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="table-responsive">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Tender No.</th>
                                <th>Tender Name</th>
                                <th>Submitted By?</th>
                                <th>Submitted On?</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var nav = new Config().ReturnNav();
                                int counter = 0;
                                string employeeNo = Convert.ToString(Session["employeeNo"]);

                                var data = nav.ProcurementRequest.Where(x => x.Process_Type == "Tender" && x.Document_Status == "Evaluation" && x.Asigned_User == employeeNo && x.Submitted_On_Portal == true && x.Submitted_By_Evaluator == true).ToList();
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
                                <td><%=member.No %></td>
                                <td><%=member.Title %></td>
                                <td><%=member.Selected_Bidder_Name %></td>
                                <td><%=Convert.ToDateTime(member.Return_Date).ToString("dd-MM-yyyy") %></td>
                                <td>
                                    <label class="btn btn-warning"><i class="fa fa-question-circle"></i>Submitted</label></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
    <!-- /.content -->
</asp:Content>




