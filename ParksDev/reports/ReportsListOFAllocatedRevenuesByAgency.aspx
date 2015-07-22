<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportsListOFAllocatedRevenuesByAgency.aspx.cs" Inherits="ParksDev.reports.ReportsListOFAllocatedRevenuesByAgency" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h1>List of Allocated Revenues by Agency</h1><br />

<table border="1" width="800">
    <asp:Repeater ID="FYRepeater" runat="server" OnItemDataBound="FYRepeatBound">
        <HeaderTemplate>

        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td  colspan="5">
                   <h1>Fiscal Year <%# DataBinder.Eval(Container.DataItem, "FY") %> </h1>
                </td>
            </tr>
            <tr>
                <td>Agency</td>
                <td>Benefit Assessment Funds</td>
                <td>Interest Funds</td>
                <td>Total HB3 Funds</td>
            </tr>
                <asp:Repeater ID="innerRepeat" runat="server">
                    <ItemTemplate>
                        <tr>
                           <td> <%#DataBinder.Eval(Container.DataItem, "AGENCY")%></td>
                           <td> <%#DataBinder.Eval(Container.DataItem, "AMT_BAS", "{0:c}")%></td>
                           <td> <%#DataBinder.Eval(Container.DataItem, "AMT_INT", "{0:c}")%></td>
                           <td> <%# totalHB3(Convert.ToInt32(DataBinder.Eval(Container.DataItem, "AMT_BAS")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "AMT_INT")))%></td>
                        </tr>                        
                    </ItemTemplate>
                </asp:Repeater>
        </ItemTemplate>
        <AlternatingItemTemplate>
             <tr>
                <td  colspan="5">
                   <h1>Fiscal Year <%# DataBinder.Eval(Container.DataItem, "FY")%> </h1>
                </td>
            </tr>
            <tr>
                <td>Agency</td>
                <td>Benefit Assessment Funds</td>
                <td>Interest Funds</td>
                <td>Total HB3 Funds</td>
            </tr>
                <asp:Repeater ID="innerRepeat" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td> <%#DataBinder.Eval(Container.DataItem, "AGENCY")%></td>
                           <td> <%#DataBinder.Eval(Container.DataItem, "AMT_BAS", "{0:c}")%></td>
                           <td> <%#DataBinder.Eval(Container.DataItem, "AMT_INT", "{0:c}")%></td>
                           <td> <%# totalHB3(Convert.ToInt32(DataBinder.Eval(Container.DataItem, "AMT_BAS")), Convert.ToInt32(DataBinder.Eval(Container.DataItem, "AMT_INT")))%></td>
                        </tr>                        
                    </ItemTemplate>
                </asp:Repeater>
        </AlternatingItemTemplate>
    </asp:Repeater>
</table>
</asp:Content>
