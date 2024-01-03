﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClosedTendersView.aspx.cs" Inherits="WWF.ClosedTendersView" %>

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
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Page</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Closed Tenders
            </div>
            <div class="panel-body">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Tender No</th>
                            <th>Tender Name</th>
                            <th>Submission Startdate</th>
                            <th>Submission StartTime</th>
                            <th>Submission Dateline</th>
                            <th>Submission EndTime</th>
                            <th>Status</th>
                            <%-- <th>View Details</th>--%>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int counter = 0;
                            var nav = new Config().ReturnNav();
                            String vendorNo = Convert.ToString(Session["vendorNo"]);
                            var data = nav.ProcurementRequest.Where(x => x.Process_Type == "Tender" && x.Document_Status == "Closed" && x.Vendor_No == vendorNo && x.Submitted_On_Portal == true).ToList();
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
                            <td><%=Convert.ToDateTime(member.Submission_Start_Date).ToString("dd-MM-yyyy") %></td>
                            <td><%=Convert.ToDateTime(member.Submission_Start_Time).ToString("HH:mm tt") %></td>
                            <td><%=Convert.ToDateTime(member.Submission_End_Date).ToString("dd-MM-yyyy") %></td>
                            <td><%=Convert.ToDateTime(member.Submission_End_Time).ToString("HH:mm tt") %></td>
                            <td><label class="btn btn-success"><i class="fa fa-question-circle"></i>Closed</label></td>
                            <%-- <td><a href="TenderDetails.aspx?TenderNo=<%=clearText %>" class="btn btn-primary"><i class="fa fa-edit"></i>View Details</a> </td>--%>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
    <!-- /.content -->
</asp:Content>

