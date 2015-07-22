<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="ParksDev.Reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h1>Reports</h1><br />
<ul>
<li><asp:HyperLink ID="CalARA" runat="server" Text="Calculation of Annual Restirced Amount" NavigateUrl="~/reports/ReportsCalcAnnualRestricedAmount.aspx"></asp:HyperLink> </li>
<li><asp:HyperLink ID="CalYEG" runat="server" Text="Calculation of Youth Employment Goal" NavigateUrl="~/reports/ReportsCalcYouthEmploymentGoal.aspx"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListARA" runat="server" Text="List of Allocate Revenues by Agency" NavigateUrl="~/reports/ReportsListOFAllocatedRevenuesByAgency.aspx"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListBA" runat="server" Text="List of Benefit Assessments"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListMI" runat="server" Text="List of Monthly Interest"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListPay" runat="server" Text="List of Payments"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListRFA" runat="server" Text="List of Restriced Funds by Agency"></asp:HyperLink></li>
<li><asp:HyperLink ID="ListYEG" runat="server" Text="List of YEG Credits"></asp:HyperLink></li>
<li><asp:HyperLink ID="MSInfoYEG" runat="server" Text="M+S Agency Info - Actual + YEG"></asp:HyperLink></li>
<li><asp:HyperLink ID="MSInfoYEGc" runat="server" Text="M+S Agency Info - Acutal + YEG (Cobining Agencies)"></asp:HyperLink></li>
<li><asp:HyperLink ID="MFB" runat="server" Text="Maintenance Fund Balance"></asp:HyperLink></li>
<li><asp:HyperLink ID="MSFBHB3" runat="server" Text="Maintenance and Servicing Fund Balance - Total HB3"></asp:HyperLink></li>
<li><asp:HyperLink ID="YEGsumA" runat="server" Text="YEG Summary by Agenecy"></asp:HyperLink></li>
<li><asp:HyperLink ID="YEGSMF" runat="server" Text="YEG and M + S Fund Balance"></asp:HyperLink></li>
<li><asp:HyperLink ID="YEGYearB" runat="server" Text="YEG and YEarly Fees Balance - Total HB3"></asp:HyperLink></li>
<li><asp:HyperLink ID="YEGB" runat="server" Text="Youth Employment Goal Balance"></asp:HyperLink></li>
</ul>
</asp:Content>
