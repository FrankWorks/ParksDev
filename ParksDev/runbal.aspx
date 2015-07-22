<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
	CodeBehind="backup of runbal.aspx.cs" Inherits="ParksDev.runbal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
	<style type="text/css">
		#jqGridDiv
		{
			position: relative;
			z-index: 1;
		}
	</style>
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
										value: item.AGE_CODE
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

						var selAgencyVal = ui.item.value;

						// grid view of the data                        
						getGrid(selAgencyVal);

						event.preventDefault();
						$("#<%=tbxAgency.ClientID%>").val(ui.item.label);

						$('.ui-jqgrid-bdiv').height('100%');
						$('.ui-jqgrid').css('margin-left', 'auto');
						$('.ui-jqgrid').css('margin-right', 'auto');

						// popup detail screen
						$("#dialog-detail").dialog({
							autoOpen: false,
							show: {
								effect: "fade",
								duration: 400
							},
							title: ui.item.label,
							resizable: false,
							closeOnEscape: true,
							width: 700,
							height: 500,
							modal: true,
							position: "center",
							buttons: {
								'Close': function () {
									$(this).dialog('close');
								}
							}
						});

					}, //end select function
					focus: function (event, ui) {
						event.preventDefault();
						$("#<%=tbxAgency.ClientID%>").val(ui.item.label);
					} // end of focus
				}); //end of auto complete
			} //end function bracket
		 );      //end dollar sign



function getGridDetail(code, year) {
	
	$("#dialog-detail").dialog("open");

	var gridWidth = $("#dialog-detail").width();

	$("#<%=jqGridInterestDetail.ClientID%>").jqGrid({
		url: "DAL/RunBalMonth.ashx?code=" + code + "&year=" + year,
		datatype: "json",
		colNames: ['MONTH', 'YEAR', 'STARTING BALANCE', 'ENDING BALANCE', 'MONTHLY TRANSACTIONS', 'COLLECTED DEBT SERVICE'],
		colModel: [
												{ name: 'MONTH', index: 'MONTH', width: 50, sorttype: 'int', formatter:'date', align:'right',
													formatoptions: {
														srcformat: 'm',
														newformat: 'F'
													}
												},
												{ name: 'YEAR', index: 'YEAR', width: 30, align:'center' },
												{ name: 'AMT_BEG', index: 'AMT_BEG', width: 50, align: 'right', formatter: 'currency',sorttype: 'float',
													formatoptions: { decimalSeparator: ".",
														thousandsSeparator: ",",
														prefix: "$"
													}
												},
												{ name: 'ENDBAL', index: 'ENDBAL', width: 50, align: 'right', formatter: 'currency',sorttype: 'float',
													formatoptions: { decimalSeparator: ".",
														thousandsSeparator: ",",
														prefix: "$"
													}
												},
												{ name: 'AMT_TRA', index: 'AMT_TRA', width: 50, align: 'right', formatter: 'currency',sorttype: 'float',
													formatoptions: { decimalSeparator: ".",
														thousandsSeparator: ",",
														prefix: "$"
													}
												},
												{ name: 'FEE_PAY', index: 'FEE_PAY', width: 50, align: 'right', formatter: 'currency',sorttype: 'float',
													formatoptions: { decimalSeparator: ".",
														thousandsSeparator: ",",
														prefix: "$"
													}
												}
										  ],
		rowNum: 18,
		//rowList: [15, 20, 40, 60],
		width: gridWidth,
		height: '60%',
		pager: '#jqGInterestDetailPager',
		viewrecords: true,
		loadonce: true,
		caption: "Monthly Balance",
        multiSort: true,
        sortname: 'MONTH desc',
       sortorder: 'desc'
});
$("#<%=jqGridInterestDetail.ClientID%>").jqGrid('navGrid', '#jqGInterestDetailPager', { edit: false, add: false, del: false, search: false, refresh: false });
$("#<%=jqGridInterestDetail.ClientID%>").jqGrid('setGridParam', { url: "DAL/RunBalMonth.ashx?code=" + code + "&year=" + year, datatype: "json", page: 1 }).trigger("reloadGrid");
$("#<%=jqGridInterestDetail.ClientID%>").jqGrid('sortGrid', 'YEAR', true, 'desc')
$("#<%=jqGridInterestDetail.ClientID%>").jqGrid('sortGrid', 'YEAR', true, 'desc')
$("#<%=jqGridInterestDetail.ClientID%>").jqGrid('sortGrid', 'MONTH', true, 'desc')
$("#<%=jqGridInterestDetail.ClientID%>").jqGrid('sortGrid', 'MONTH', true, 'desc').trigger("reloadGrid"); 

} //end getGridDetail


function getGrid(code) {
	jQuery("#<%=jQGridDemo.ClientID%>").jqGrid({
		url: "DAL/runningBalG.ashx?ACODE=" + code,
		datatype: "json",
		colNames: ['FISCAL YEAR', 'BEGINING BALANCE', 'ENDING BALANCE', 'YEG BALANCE', 'DEBT SERVICE BALANCE'],
		colModel: [
									{ name: 'YEAR', index: 'YEAR', width: 50, align: 'center' },
									{ name: 'BEGBAL', index: 'BEGBAL', width: 50, align: 'right', formatter: 'currency',sorttype: 'float',
										formatoptions: { decimalSeperator: ".",
											thousandsSeperator: ",",
											prefix: "$"
										}
									},
									{ name: 'ENDBAL', index: 'ENDBAL', width: 50, align: 'right', formatter: 'currency', sorttype: 'float',
										formatoptions: { decimalSeperator: ".",
											thousandsSeperator: ",",
											prefix: "$"
										}
									},
									{ name: 'YEGBAL', index: 'YEGBAL', width: 50, align: 'right', formatter: 'currency', sorttype: 'float',
										formatoptions: { decimalSeperator: ".",
											thousandsSeperator: ",",
											prefix: "$"
										}
									},
									{ name: 'FEEBAL', index: 'FEEBAL', width: 50, align: 'right', formatter: 'currency', sorttype: 'float',
										formatoptions: { decimalSeperator: ".",
											thousandsSeperator: ",",
											prefix: "$"
										}
									}

							  ],
		rowNum: 15,
		rowList: [15, 20, 40, 60],
		width: 800,
		pager: '#jQGPager',
		sortname: 'ENTERED',
		viewrecords: true,
		sortorder: "asc",
		loadonce: true,
		caption: "Selected Account Details (Case Sensitive)",
		onSelectRow: function (ids) {

			selRowId = $("#<%=jQGridDemo.ClientID%>").jqGrid('getGridParam', 'selrow');

			//selMonth = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', selRowId, 'MONTH');
			selYear = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', selRowId, 'YEAR');

			getGridDetail(code, selYear);

		}
	}); //end jqgrid

	$("#<%=jQGridDemo.ClientID%>").jqGrid('navGrid', '#jQGPager', { edit:false, add: false, del: false, search: false, refresh: true }); // end of jqGrid - navGrid
	$("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/runningBalG.ashx?ACODE=" + code, datatype: "json", page: 1 }).trigger("reloadGrid");
	$("#<%=jQGridDemo.ClientID%>").jqGrid('filterToolbar', { stringResult: true, searchOnEnter: false });
} // end getgrid



	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<h1 class="page_head">
		Agency Running Balances</h1>
	<br />
	<div>
		Search by Agencies</div>
	<div>
		<asp:TextBox ID="tbxAgency" runat="server" ToolTip="Begin by entering the Agency  you wish to view" /> </div><br /><br />
	<%--same name in javascript --%>
	<div id="jqGridDiv">
		<asp:Table ID="jQGridDemo" runat="server">
		</asp:Table>
		<div id="jQGPager">
		</div>
	</div>
	<br />
	<!--Detail-->
	<div id="dialog-detail">
		<asp:Table ID="jqGridInterestDetail" runat="server">
		</asp:Table>
		<div id="jqGInterestDetailPager">
		</div>
	</div>
	<%--  <br /><br /><br />

	<asp:DropDownList runat="server" ID="agencydropdownlist" DataSourceID="agenciessource" DataTextField="AGENCY" DataValueField="AGE_CODE" OnSelectedIndexChanged="agencyselect" AutoPostBack="true" CssClass="bold" />
		<asp:SqlDataSource  ID="agenciessource" 
						runat="server" 
						DataSourceMode="DataSet"   
						ConnectionString="<%$ ConnectionStrings:FoxProDevConnectionString %>"
						SelectCommand="SELECT AGENCY, AGE_CODE FROM [AGENCIES] ORDER BY [AGE_CODE]" />

						<%--	<asp:Table ID="dmyTable" runat="server" Height="125px" Width="300px" BorderColor="Transparent" BorderWidth="0" Visible="false" >
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
	
	</asp:GridView>--%>
</asp:Content>
