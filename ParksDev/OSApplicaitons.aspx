<%@ Page Title="Open Space Applications" MasterPageFile="~/Site.master" 
    Language="C#" AutoEventWireup="true" CodeBehind="OSApplicaitons.aspx.cs" Inherits="ParksDev.OSApplicaitons" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 407px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">




    <div>
                                    <table class="style1">
                                    <tr>
                                            <td class="style2">
                                    <asp:GridView ID="DistrictGridView" runat="server"
                                     DataSourceID="testsource"
                                     AutoGenerateColumns="false" AutoGenerateSelectButton="true"
                                    allowpaging="true" SelectedIndex="1"
                                    OnSelectedIndexChanged="DistrictselectChange"
                                    OnSelectedIndexChanging="DistrictselectChanging"
                                     DataKeyNames="AGE_CODE" >

                                     <Columns>
                                        <asp:BoundField DataField="AGE_CODE"
                                             HeaderText="Agency Code"
                                              InsertVisible="false" ReadOnly="true"
                                               SortExpression="AGE_CODE" />
                                        <asp:BoundField DataField="AGENCY"
                                         HeaderText="Agency"
                                          SortExpression="AGENCY" />
                                      </Columns>
                                    </asp:GridView>
                                            </td>
                                            <td> <%--grid for agency balance fy--%><asp:Label Text="agency bal for the year" runat="server" Visible="true"/>
                                                <asp:GridView ID="agebalfy" runat="server"></asp:GridView>
                                            </td>
                                     </tr>
                                     <tr>
                                         <td>blank
                                            </td>
                                            <td>agency balance month
                                            <asp:GridView ID="agebalmgrid" runat="server">
                                            </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>

        <asp:Label runat="server" Text="agency benefits" />
        <asp:GridView runat="server" ID="AGB" AutoGenerateColumns="true" AutoGenerateSelectButton="true" AllowPaging="false"
             OnSelectedIndexChanged="agb_change" OnSelectedIndexChanging="agb_changing" DataKeyNames="ABA_CODE" AllowSorting="false"
              SelectedIndex="1">
             </asp:GridView>

             <asp:label runat="server" Text="Benefits" />
        <asp:GridView runat="server" ID="benefitsGrid" AutoGenerateColumns="true" AutoGenerateSelectButton="true" AllowPaging="false"
             DataKeyNames="BAS_CODE" OnSelectedIndexChanging="benefitschanging" Visible="True" SelectedIndex="1" AllowSorting="false">
             </asp:GridView> 
    </div>
    <asp:SqlDataSource ID="testsource" SelectCommand="SELECT AGE_CODE, AGENCY FROM dbo.AGENCIES" ConnectionString="<%$ ConnectionStrings:FoxProDevConnectionString %>" runat="server"  />


</asp:Content>
