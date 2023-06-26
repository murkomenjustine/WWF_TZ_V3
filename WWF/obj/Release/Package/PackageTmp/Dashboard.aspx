<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WWF.Dashboard" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="WWF" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<%@ Import Namespace="System.Text" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>Welcome <% =Session["name"] %>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>e-Procurement Portal</a></li>
            <li class="active">Dashboard</li>
        </ol>
    </section>

    <section class="content">
        <%
            var nav = new Config().ReturnNav();
            bool isregistered = false;
            var vend = nav.eProVendorQT.Where(x => x.No == Session["vendorNo"].ToString()).ToList().Take(1);
            foreach (var user in vend)
            {
                isregistered = Convert.ToBoolean(user.Registered);
            }
            if (!isregistered)
            {
        %>
        <div class="row">
            <div class="col-md-12">
                <div class="alert alert-danger alert-dismissable">
                    <h4><i class="icon fa fa-warning"></i>Alert!</h4>
                    Dear  <% =Session["name"] %>, your profile is not complete. Kinldy complete your profile to access all the services.             
                </div>
            </div>
        </div>
        <%
            }
        %>
        <!-- Small boxes (Stat box) -->
        <div class="row">
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-aqua">
                    <div class="inner">
                        <h3>5</h3>
                        <p>Active Tenders</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-bag"></i>
                    </div>
                    <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-green">
                    <div class="inner">
                        <h3>2</h3>
                        <p>Closed Tenders</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-stats-bars"></i>
                    </div>
                    <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-yellow">
                    <div class="inner">
                        <h3>4</h3>
                        <p>Awarded Contracts</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-person-add"></i>
                    </div>
                    <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-red">
                    <div class="inner">
                        <h3>0</h3>
                        <p>Announcements</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-pie-graph"></i>
                    </div>
                    <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
        </div>
        <!-- /.row -->
                <div class="panel panel-primary">
            <div class="panel-heading">
                Current Tenders
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="table-responsive">
                                    <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Tender No</th>
                            <th>External Document No</th>
                            <th>Tender Name</th>
                            <th>Description</th>
                            <th>Tender Submission Startdate</th>
                            <th>Tender Submission Dateline</th>
                            <th>Status</th>
                            <th>View Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int counter = 0;
                           
                            //var data = nav.invitetoTenders.Where(x => x.Published == true && x.Document_Status == "Published" && x.Procurement_Method == "Open Tender" /*&& x.Submission_End_Date >= today*/).ToList();
                            var data = nav.invitetoTenders;
                            foreach (var member in data)
                            {
                                string clearText = member.Code;
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
                            <td><%=member.Code %></td>
                            <td><%=member.External_Document_No %></td>
                            <td><%=member.Tender_Name %></td>
                            <td><%=member.Description %></td>
                            <td><%=member.Submission_Start_Date %></td>
                            <td><%=member.Submission_End_Date %></td>
                            <td><%="Open" %></td>
                            <td><a href="TenderDetails.aspx?TenderNo=<%=clearText %>" class="btn btn-info"><i class="fa fa-edit"></i>View Details</a> </td>

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
</asp:Content>
