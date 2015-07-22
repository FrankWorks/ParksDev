<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="backup of runbal.aspx.cs" Inherits="ParksDev.runbal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<meta http-equiv="Page-Enter" content="BlendTrans(Duration=.01)" /> 
<meta http-equiv="Page-Exit" content="BlendTrans(Duration=.01)" />
	 <script type="text/javascript">
	     $(
			function () {
			    $("#<%=tbxAgency.ClientID%>").autocomplete({
			        source: function (request, response) {
			            $.ajax({
			                url: "DAL/Agency.ashx?code=" + request.term,
			                dataType: "json",
			                type: "POST",
			                success: function (data) {
			                    response($.map(data, function (item) {
			                        return {
			                            label: item.AGENCY,
			                            value: item.AGENCY
			                        }
			                    })//map
							   )//response
			                }, //success
			                error: function (msg) {
			                    alert(msg.responseText);
			                }
			            });
			        },
			        select: function (event, ui) {

			        }
			    });
			}
		 );
	 </script> 

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h1>Running Balances</h1><br />

	<div>Search by Agencies</div> <div><asp:TextBox ID="tbxAgency" runat="server" /></div>
	
	










	 








	 <br /><br /><br />

	<asp:DropDownList runat="server" ID="agencydropdownlist" DataSourceID="agenciessource" DataTextField="AGENCY" DataValueField="AGE_CODE" OnSelectedIndexChanged="agencyselect" AutoPostBack="true" CssClass="bold" />
		<asp:SqlDataSource  ID="agenciessource" 
						runat="server" 
						DataSourceMode="DataSet"   
						ConnectionString="<%$ ConnectionStrings:FoxProDevConnectionString %>"
						SelectCommand="SELECT AGENCY, AGE_CODE FROM [AGENCIES] ORDER BY [AGE_CODE]" />

							<asp:Table ID="dmyTable" runat="server" Height="125px" Width="300px" BorderColor="Transparent" BorderWidth="0" Visible="false" >
		<asp:TableRow ID="TableRow1" runat="server" BorderColor="Transparent" BorderWidth="0" Width="100%">
						<asp:TableCell ID="TableCell1" runat="server" BorderColor="Transparent" BorderWidth="2">Development
						</asp:TableCell>
						<asp:TableCell ID="TableCell2" runat="server" BorderColor="Transparent" BorderWidth="2" HorizontalAlign="Right"><asp:Label runat="server" ID="DEVAMT" />
						</asp:TableCell>
		</asp:TableRow>
		<asp:TableRow>
						<asp:TableCell ID="TableCell3" runat="server" BorderColor="Transparent" BorderWidth="2">Maintenance
						</asp:TableCell>
						<asp:TableCell ID="TableCell4" runat="server" BorderColor="Transparent" BorderWidth="2" HorizontalAlign="Right"><asp:Label runat="server" ID="MTCAMT" />
						</asp:TableCell>

		</asp:TableRow>
		<asp:TableRow>
						<asp:TableCell ID="TableCell5" runat="server" BorderColor="Transparent" BorderWidth="2">YEG Total
						</asp:TableCell>
						<asp:TableCell ID="TableCell6" runat="server" BorderColor="Transparent" BorderWidth="2" HorizontalAlign="Right"><asp:Label runat="server" ID="YEGAMT" />	
						</asp:TableCell>
		</asp:TableRow>            
	</asp:Table>
	<asp:Panel ID="FYpanel" runat="server" ScrollBars="Auto" Height="260px">
	<asp:GridView ID="FYGrid" runat="server" Width="98%" AutoGenerateColumns="false" SelectedIndex="3" DataKeyNames="FY" EnablePersistedSelection="true" AutoGenerateSelectButton="true" OnSelectedIndexChanged="showMonth" RowStyle-HorizontalAlign="Right">
		<Columns>
			<asp:TemplateField HeaderText="Fiscal Year">
			<ItemTemplate>
				<asp:Label runat="server" ID="FiscalYearFYGrid" Text='<%#Eval("FY") + "/" + (Convert.ToDecimal(Eval("FY"))+1) %>'  />
			</ItemTemplate>
			</asp:TemplateField>

			<asp:TemplateField HeaderText="Begining Balance">
			<ItemTemplate>
				<asp:Label runat="server" ID="BeginBal" Text='<%#Eval("AMT_BEG", "{0:C2}")%>' />
			</ItemTemplate>
			</asp:TemplateField>

			<asp:TemplateField HeaderText="Ending Balance">
			<ItemTemplate>
				<asp:Label runat="server" ID="EndBal" Text='<%#Eval("AMT_BAS", "{0:C2}")%>' />
			</ItemTemplate>
			</asp:TemplateField>

			<asp:TemplateField HeaderText="YEG Balance">
			<ItemTemplate>
				<asp:Label runat="server" ID="YEGBal" Text='<%#Eval("YEG_BEG", "{0:C2}")%>' />
			</ItemTemplate>
			</asp:TemplateField>

			<asp:TemplateField HeaderText="FY Debt Service Balance">
			<ItemTemplate>
				<asp:Label runat="server" ID="DebtSvcBal" Text='<%#Eval("FEE_CAL", "{0:C2}")%>' />
			</ItemTemplate>
			</asp:TemplateField>
		</Columns>
	</asp:GridView>
	</asp:Panel>
	<br /><br />
	<asp:GridView ID="MonthBalGrid" runat="server"  AutoGenerateColumns="false" RowStyle-HorizontalAlign="Right">
	<Columns>
		<asp:TemplateField HeaderText="Month/Year">
			<ItemTemplate><asp:Label runat="server" ID="MonthYear" Text='<%#getMonth(Convert.ToInt32(Eval("MONTH"))) + "/" + Eval("YEAR")%>' /></ItemTemplate>
		</asp:TemplateField>
		<asp:TemplateField HeaderText="Starting Balance">
			<ItemTemplate><asp:Label runat="server" ID="BeginBal" Text='<%#Eval("AMT_BEG", "{0:C2}") %>' /></ItemTemplate>
		</asp:TemplateField>
	  <asp:TemplateField HeaderText="Montly Transactions">
			<ItemTemplate><asp:Label runat="server" ID="A" Text='<%#Eval("AMT_TRA", "{0:C2}") %>' /></ItemTemplate>
		</asp:TemplateField>
	  <asp:TemplateField HeaderText="Collected Debt Services">
			<ItemTemplate><asp:Label runat="server" ID="Feepay" Text='<%#Eval("FEE_PAY", "{0:C2}") %>' /></ItemTemplate>
		</asp:TemplateField>
	</Columns>
	
	</asp:GridView>
</asp:Content>
