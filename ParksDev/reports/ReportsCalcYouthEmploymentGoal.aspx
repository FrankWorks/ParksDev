<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportsCalcYouthEmploymentGoal.aspx.cs" Inherits="ParksDev.reports.ReportsCalcYouthEmploymentGoal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h1>Report - Calculation of Youth Employment Goal</h1><br /><br />

    <asp:Repeater ID="AgencyRepeater" runat="server" OnItemDataBound="repeatbound" >
        <HeaderTemplate>
      
        </HeaderTemplate>
            <ItemTemplate>
              AGENCY: <%#DataBinder.Eval (Container.DataItem, "AGENCY") %><br />
         
                    <asp:GridView Width="800px" ID="RepeatGrid" runat="server" AutoGenerateColumns="false" DataKeyNames="AGE_CODE" Visible="true">
                    <Columns>
                     <asp:BoundField DataField="AGE_CODE" HeaderText="Age Code" ReadOnly="true" SortExpression="AGE_CODE" Visible="false" />
                     <asp:BoundField DataField="AGENCY" HeaderText="Agency" Visible="false" />
                     <asp:BoundField DataField="HEADER" />
                     <asp:BoundField DataField="FUND_TYPE" HeaderText="Fund" />
                     <asp:BoundField DataField="AMT" HeaderText="Development" />

                    </Columns>
                  </asp:GridView><br /><br /><br />

            </ItemTemplate>

            <AlternatingItemTemplate>
                AGENCY: <%#DataBinder.Eval (Container.DataItem, "AGENCY") %><br />

                  <asp:GridView Width="800px" ID="RepeatGrid" runat="server" AutoGenerateColumns="false" DataKeyNames="AGE_CODE" Visible="true" ShowFooter="true" >
                    <Columns>
                     <asp:BoundField DataField="AGE_CODE" HeaderText="Age Code" ReadOnly="true" SortExpression="AGE_CODE" Visible="false" />
                     <asp:BoundField DataField="AGENCY" HeaderText="Agency" Visible="false" />
                     <asp:BoundField DataField="HEADER" />
                     <asp:BoundField DataField="FUND_TYPE" HeaderText="Fund" />
                     <asp:BoundField DataField="AMT" HeaderText="Development" />
                        <asp:TemplateField>
                        <FooterTemplate>
                        <asp:Label ID="Totaler" runat="server"></asp:Label>
                        </FooterTemplate>
                        
                        </asp:TemplateField>
                    </Columns>
                  </asp:GridView><br /><br /><br />

            </AlternatingItemTemplate>
            <FooterTemplate>
            nothing homes
            </FooterTemplate>
    </asp:Repeater>


</asp:Content>
