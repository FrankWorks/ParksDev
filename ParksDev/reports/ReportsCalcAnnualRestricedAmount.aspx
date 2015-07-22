<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportsCalcAnnualRestricedAmount.aspx.cs" Inherits="ParksDev.reports.ReportsCalcAnnualRestricedAmount" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h1>Report - Calculation of Annual Restricted Amount</h1><br /><br />


<table border="1">
    <asp:Repeater ID="AGENCYrepeater" runat="server" OnItemDataBound="AgencyRepeatBound" EnableViewState="false">
    <HeaderTemplate>
    Report info heading etc
    </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td valign="top" colspan="5">    
                  <h1><br /><%#DataBinder.Eval(Container.DataItem,"AGENCY") %><br /></h1>
                </td>
            </tr>
            <tr>  
                <th>Calculation of the annual Allocation (Percentage Share * Total HB3 est. Annual Allocation</th>
                <th>Estimated Annual Allocation<br /> (A)</th>
                <th>Calculation of Restriction Rate<br />(Remaining YEG / Remaining M&S AEBD)</th>
                <th>Restriction Rate<br />(B)</th>
                <th>Annual Restricted Amount<br />( A * B )</th>
            </tr>
                <asp:Repeater ID="therest" runat="server">
                    <ItemTemplate>
                    <tr>
                        <td>Fiscal Year: <b><%#DataBinder.Eval(Container.DataItem, "FY") %></b> <br /><%#DataBinder.Eval(Container.DataItem, "CALC_TYPE") %><br /><%#DataBinder.Eval(Container.DataItem, "PCT_BAS","{0:P5}") %> of <%#DataBinder.Eval(Container.DataItem, "ANNUALLY","{0:c}") %></td>
                        <td><%#DataBinder.Eval(Container.DataItem, "MTC_EST", "{0:c}")%></td>
                        <td>(<%#DataBinder.Eval(Container.DataItem, "YEG_TOT", "{0:c}")%> - <%#DataBinder.Eval(Container.DataItem, "YEG_TRA_SUM", "{0:c}")%>) / (<%#DataBinder.Eval(Container.DataItem, "AMTMTC", "{0:c}")%> - <%#DataBinder.Eval(Container.DataItem, "MTC_EST_SUM", "{0:c}")%>)<br /></td>

                        <%--<td><%# Math.Round(((((float)Convert.ToInt32(Eval("YEG_TOT"))) - ((float)Convert.ToInt32(Eval("YEG_TRA_SUM")))) / (((float)Convert.ToInt32(Eval("AMTMTC"))) - ((float)Convert.ToInt32(Eval("MTC_EST_SUM"))))) * 100, 3) %><br /></td>--%>

                        <td><%# getRRate(Convert.ToInt32(DataBinder.Eval(Container.DataItem, "YEG_TOT")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "YEG_TRA_SUM")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "AMTMTC")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "MTC_EST_SUM")))%> %<br /></td>
                        <td align="right"><%# getARAmount(Convert.ToInt32(DataBinder.Eval(Container.DataItem, "MTC_EST")), getRRate(Convert.ToInt32(DataBinder.Eval(Container.DataItem, "YEG_TOT")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "YEG_TRA_SUM")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "AMTMTC")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "MTC_EST_SUM"))))%><br /></td>
                    </tr>
                    </ItemTemplate>
                </asp:Repeater>
           </ItemTemplate>
           <AlternatingItemTemplate>
            <tr>
                <td valign="top" colspan="5">    
                  <h1><br /><%#DataBinder.Eval(Container.DataItem,"AGENCY") %><br /></h1>
                </td>
            </tr>
            <tr>  
                <th>Calculation of the annual Allocation (Percentage Share * Total HB3 est. Annual Allocation</th>
                <th>Estimated Annual Allocation<br /> (A)</th>
                <th>Calculation of Restriction Rate<br />(Remaining YEG / Remaining M&S AEBD)</th>
                <th>Restriction Rate<br />(B)</th>
                <th>Annual Restricted Amount<br />( A * B )</th>
            </tr>
                <asp:Repeater ID="therest" runat="server">
                    <ItemTemplate>
                        <tr>
                        <td>Fiscal Year: <b><%#DataBinder.Eval(Container.DataItem, "FY") %></b> <br /><%#DataBinder.Eval(Container.DataItem, "CALC_TYPE") %><br /><%#DataBinder.Eval(Container.DataItem, "PCT_BAS","{0:P5}") %> of <%#DataBinder.Eval(Container.DataItem, "ANNUALLY","{0:c}") %></td>
                        <td><%#DataBinder.Eval(Container.DataItem, "MTC_EST", "{0:c}")%></td>
                        <td>(<%#DataBinder.Eval(Container.DataItem, "YEG_TOT", "{0:c}")%> - <%#DataBinder.Eval(Container.DataItem, "YEG_TRA_SUM", "{0:c}")%>) / (<%#DataBinder.Eval(Container.DataItem, "AMTMTC", "{0:c}")%> - <%#DataBinder.Eval(Container.DataItem, "MTC_EST_SUM", "{0:c}")%>)<br /></td>

                        <td><%# getRRate(Convert.ToInt32(DataBinder.Eval(Container.DataItem, "YEG_TOT")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "YEG_TRA_SUM")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "AMTMTC")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "MTC_EST_SUM")))%> %<br /></td>
                        <td align="right"><%# getARAmount(Convert.ToInt32(DataBinder.Eval(Container.DataItem, "MTC_EST")), getRRate(Convert.ToInt32(DataBinder.Eval(Container.DataItem, "YEG_TOT")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "YEG_TRA_SUM")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "AMTMTC")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "MTC_EST_SUM"))))%><br /></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
           </AlternatingItemTemplate>  
    </asp:Repeater>
</table>

</asp:Content>
