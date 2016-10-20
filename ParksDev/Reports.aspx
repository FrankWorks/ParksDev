<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="ParksDev.Reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 40px;
            height: 40px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h1>Reports</h1><br />
<ul>
<li><asp:HyperLink ID="CalARA" runat="server" Text="Calculation of Annual Restricted Amount" NavigateUrl="~/reports/ReportsCalcAnnualRestricedAmount.aspx"></asp:HyperLink> </li>
<li><asp:HyperLink ID="CalYEG" runat="server" Text="Calculation of Youth Employment Goal" NavigateUrl="~/reports/ReportsCalcYouthEmploymentGoal.aspx"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListARA" runat="server" Text="List of Allocate Revenues by Agency" NavigateUrl="~/reports/ReportsListOFAllocatedRevenuesByAgency.aspx"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListBA" runat="server" Text="List of Benefit Assessments"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListMI" runat="server" Text="List of Monthly Interest"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListPay" runat="server" Text="List of Payments" NavigateUrl="http://pksp1/my/personal/fkim/Blog/MoveForward/_layouts/15/ReportServer/RSViewerPage.aspx?rv:RelativeReportUrl=/my/personal/fkim/Blog/MoveForward/Shared%20Documents/HB307D%20DraftB1.rdl&Source=http%3A%2F%2Fpksp1%2Fmy%2Fpersonal%2Ffkim%2FBlog%2FMoveForward%2FSitePages%2FHome%2Easpx" Target="_blank"></asp:HyperLink>
    <img alt="" class="auto-style1" src="img/BestTest.jpg" /></li></asp:HyperLink></li>
<li><asp:HyperLink ID="ListRFA" runat="server" Text="List of Restriced Funds by Agency"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListYEG" runat="server" Text="List of YEG Credits"></asp:HyperLink></li>
<li><asp:HyperLink ID="MSInfoYEG" runat="server" Text="M+S Agency Info - Actual + YEG" NavigateUrl="http://pksp1/my/personal/fkim/Blog/MoveForward/_layouts/15/ReportServer/RSViewerPage.aspx?rv:RelativeReportUrl=/my/personal/fkim/Blog/MoveForward/Shared%20Documents/MS%20Reports/HB3R01CR2.rdl&Source=http%3A%2F%2Fpksp1%2Fmy%2Fpersonal%2Ffkim%2FBlog%2FMoveForward%2FShared%2520Documents%2FForms%2FAllItems%2Easpx%3FRootFolder%3D%252fmy%252fpersonal%252ffkim%252fBlog%252fMoveForward%252fShared%2520Documents%252fMS%2520Reports%26FolderCTID%3D0x012000B8C8DC2671179F4A9196732B2078EDB5" Target="_blank"></asp:HyperLink>
    <img alt="" class="auto-style1" src="img/BestTest.jpg" /></li>
<li><asp:HyperLink ID="MSInfoYEGc" runat="server" Text="M+S Agency Info - Acutal + YEG (Cobining Agencies)"></asp:HyperLink></li>
<li><asp:HyperLink ID="MFB" runat="server" Text="Maintenance Fund Balance"></asp:HyperLink></li>
<li><asp:HyperLink ID="MSFBHB3" runat="server" Text="Maintenance and Servicing Fund Balance - Total HB3"></asp:HyperLink></li>
<li><asp:HyperLink ID="YEGsumA" runat="server" Text="YEG Summary by Agenecy"></asp:HyperLink></li>
<li><asp:HyperLink ID="YEGSMF" runat="server" Text="YEG and M + S Fund Balance"></asp:HyperLink></li>
<li><asp:HyperLink ID="YEGYearB" runat="server" Text="YEG and YEarly Fees Balance - Total HB3"></asp:HyperLink></li>
<li><asp:HyperLink ID="YEGB" runat="server" Text="Youth Employment Goal Balance"></asp:HyperLink></li>
</ul>
</asp:Content>
