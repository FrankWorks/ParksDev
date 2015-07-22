<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="ParksDev._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h1 class="page_head">
       Maintenance & Servicing
    </h1>
    
    <br />
        
    <div style="margin-left:auto; margin-right:auto; width:70%;"> 

            <table>
                <tr>
                    <td style="height:50px"><img src="img/go.png" style="vertical-align:sub"></img> </td>
                    <td style="height:50px"> <asp:HyperLink NavigateUrl="~/definitions.aspx" Text="Agencies" runat="server"/></td>
                </tr>
                <tr>
                    <td style="height:50px"><img src="img/go.png" style="vertical-align:sub"></img> </td>
                    <td style="height:50px"> <asp:HyperLink NavigateUrl="~/runbal.aspx" Text="Agency Running Balances" runat="server" /></td>
                </tr>
                <tr>
                    <td style="height:50px"><img src="img/go.png" style="vertical-align:sub"></img> </td>
                    <td style="height:50px"> <asp:HyperLink NavigateUrl="~/BenefitsAssessment.aspx" Text="Benefit Assessment Distribution" runat="server" /></td>
                </tr>
                <tr>
                    <td style="height:50px"><img src="img/go.png" style="vertical-align:sub"></img> </td>
                    <td style="height:50px"> <asp:HyperLink NavigateUrl="~/MonthlyInterest.aspx" Text="Monthly Interest"  runat="server"/></td>
                </tr>
                <tr>
                    <td style="height:50px"><img src="img/go.png" style="vertical-align:sub"></img> </td>
                    <td style="height:50px"> <asp:HyperLink NavigateUrl="~/Payments.aspx" Text="Payments"  runat="server"/></td>
                </tr>
                <tr>
                    <td style="height:50px"><img src="img/go.png" style="vertical-align:sub"></img> </td>
                    <td style="height:50px"> <asp:HyperLink NavigateUrl="~/Totals.aspx" Text="Yearly/Monthly Running Balance Totals"  runat="server"/> </td>
                </tr>
                <tr>
                    <td style="height:50px"><img src="img/go.png" style="vertical-align:sub"></img> </td>
                    <td style="height:50px"> <asp:HyperLink NavigateUrl="~/YEG.aspx" Text="Youth Employment Credits"  runat="server"/></td>
<%--                </tr>
                                <tr>
                    <td style="height:50px"><img src="img/go.png" style="vertical-align:sub"></img> </td>
                    <td style="height:50px"> <asp:HyperLink ID="HyperLink1" NavigateUrl="~/jqeditTest.aspx" Text="jqgridtest"  runat="server"/></td>
                </tr>--%>
            </table>
                               

    <br /><br /><br />
    </div>


</asp:Content>
