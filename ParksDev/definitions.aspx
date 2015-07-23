<%@ Page Title="Agencies - Definitions and Calculation Quotas" Language="C#" AutoEventWireup="true" CodeBehind="definitions.aspx.cs"  MasterPageFile="~/Site.master" Inherits="ParksDev.defenitions" %>



<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

	<style type="text/css">
		.style1
		{
			width: 100%;
		}
	</style>

	<script type="text/javascript">
		$(function () {

			getGrid("a", "0");
			getAgGrid("no", "0"); // get detail grid
			getAgencyDropDown();
			getAngencyTypeDropDown();
			getDistrictTypeDropDown();
			getFundingGrid("no", 0);

			// get the Master Grid
			function getGrid(agency, atype) {
				$("#<%=jQGridDemo.ClientID%>").jqGrid({
					url: "DAL/Definitions.ashx?agencies=" + agency + "&agencyType=" + atype,
					datatype: "json",
					colNames: ['Agency', 'Department', 'Type of Agency', 'District', 'Address 1', 'Address 2', 'City', 'Zip', 'Development', 'Maintenance', 'YEG Total', 'AGE_CODE'],
					colModel: [
													{ name: 'AGENCY', index: 'AGENCY', width: 100, search: false, hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true, sorttype:'text'},
													{ name: 'NAME', index: 'NAME', width: 150, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
													{ name: 'ATP_CODE', index: 'ATP_CODE', width: 150, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
													{ name: 'DIS_CODE', index: 'DIS_CODE', width: 150, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
													{ name: 'ADR1', index: 'ADR1', width: 150, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
													{ name: 'ADR2', index: 'ADR2', width: 150, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
													{ name: 'CITY', index: 'CITY', width: 150, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
													{ name: 'ZIP', index: 'ZIP', width: 150, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
													{ name: 'AMTDEV', index: 'AMTDEV', width: 100, search: false, align: 'right', formatter: 'currency', 
														formatoptions: { decimalSeparator: ".",
															thousandsSeparator: ",", prefix: "$"
														}, editable: true , sorttype: 'float'
													},
													{ name: 'AMTMTC', index: 'AMTMTC', width: 100, search: false, align: 'right', formatter: 'currency',
														formatoptions: { decimalSeparator: ".",
															thousandsSeparator: ",",
															prefix: "$"
														}, editable: true, sorttype: 'float'
													},
													{ name: 'AMTYEG', index: 'AMTYEG', width: 150, search: false, align: 'right', formatter: 'currency',
														formatoptions: { decimalSeparator: ".",
															thousandsSeparator: ",",
															prefix: "$"
														}, editable: true, sorttype: 'float'
													},
													{ name: 'AGE_CODE', index: 'AGE_CODE', width: 150, search: false, hidden: true, editable: true, editrules: { edithidden: false }, hidedlg: true }
											  ],
					rowNum: 10,
					rowList: [10, 20, 40, 60],
					ignoreCase: true,
					autowidth: true,
					height: 230,
					pager: '#jQGPager',
					sortname: 'Agency',
					viewrecords: true,
					sortorder: "desc",
					loadonce: true,
					caption: "AGENCY", 

					onSelectRow: function (ids) {
						selRowId = $("#<%=jQGridDemo.ClientID%>").jqGrid('getGridParam', 'selrow');
						selACode = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', selRowId, 'AGE_CODE');
						$("#<%=jqGridInterestDetail.ClientID%>").jqGrid('setGridParam', { url: "DAL/Definitions.ashx?detail=yes&agencies=" + selACode, datatype: "json", page: 1 }).trigger("reloadGrid");
						$("#<%=jqGridFunding.ClientID%>").jqGrid('setGridParam', { url: "DAL/Definitions.ashx?funding=funding&agencies=" + selACode, datatype: "json", page: 1 }).trigger("reloadGrid");
					},
					editurl: "DAL/agenciesCode.ashx"
				});
				$("#<%=jQGridDemo.ClientID%>").jqGrid('navGrid', '#jQGPager', { edit: true, add: true, del: true, search: false, refresh: false },
																			  {jqModal: true,
																				  closeAfterEdit: true,
																				  reloadAfterSubmit: true,
																				  afterSubmit: function (response, postdata) {
																					  $(this).jqGrid("setGridParam", { datatype: 'json' });
																					  return [true, response.responseText];
																				  }, width: 800
																			  },
																			  { jqModal: true,
																				  closeAfterEdit: true,
																				  reloadAfterSubmit: true,
																				  afterSubmit: function (response, postdata) {
																					  $(this).jqGrid("setGridParam", { datatype: 'json' });
																					  return [true, response.responseText];
																				  }, width:800 
																			  },
																			  { jqModal: true,
																				  reloadAfterSubmit: true,
																				  beforeSubmit: function (response, postdata) {
																					  $(this).jqGrid("setGridParam", { datatype: 'json' });
																					  return [true, response.responseText];
																				  },
																				  delData: {
																					  delcode: function () {
																						  var sel_id = $("#<%=jQGridDemo.ClientID%>").jqGrid('getGridParam', 'selrow');
																						  var agevalue = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', sel_id, 'AGE_CODE');
																						  return agevalue;
																					  }
																				  }
																			  }
													  ); // end of jqGrid - navGrid	            
				$("#<%=jQGridDemo.ClientID%>").jqGrid('navButtonAdd', "#jQGPager", { caption: "Reload", title: "Reload Data", buttonicon: "ui-icon-refresh",
					onClickButton: function () { $("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/Definitions.ashx?agencies=a&agencyType=0", datatype: "json", page: 1 }).trigger("reloadGrid"); }
				});

			} //end getgrid function

		    function getAgGrid(detailFlag, ageID) {

		        if (detailFlag == "no")
		            urlString = "";
		        else
		            urlString = "DAL/Definitions.ashx?detail=" + detailFlag + "&agencies=" + ageID;

		        $("#<%=jqGridInterestDetail.ClientID%>").jqGrid({
		            url: urlString,
		            datatype: "json",
		            colNames: ['No. of Parcels', 'MONTH', 'YEAR', 'MONTH', 'YEAR', '% FROM BENEF. ASSESS.', 'EST. MNTCE/FY', 'FY FEES', 'AGE CODE','ACA CODE'],
		            colModel: [
						{ name: 'NO_PARC', index: 'NO_PARC', width: 0, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
						{ name: 'MONTH_FR', index: 'MONTH_FR', width: 20, align: 'center', formatter: 'date',
						    formatoptions: {
						        srcformat: 'm',
						        newformat: 'M'
						    }
						},
						{ name: 'YEAR_FR', index: 'YEAR_FR', width: 20, align: 'center' },
						{ name: 'MONTH_TO', index: 'MONTH_TO', width: 20, align: 'center', formatter: 'date',
						    formatoptions: {
						        srcformat: 'm',
						        newformat: 'M'
						    }
						},
						{ name: 'YEAR_TO', index: 'YEAR_TO', width: 20, align: 'center' },
						//{ name: 'PCT_BAS', index: 'PCT_BAS', width: 50, align: 'right', editable: true, sorttype: 'float', cellsformat: 'p', formatter: 'number', formatoptions: { suffix: '%', decimalSeparator: ".", thousandsSeparator: " ", decimalPlaces: 5} },
                        { name: 'PCT_BAS', index: 'PCT_BAS', width: 50, align: 'right', editable: true, sorttype: 'float', cellsformat: 'p', formatter: PercentageFormatter, unformat: unPercentageFormatter },
						{ name: 'FY_EST', index: 'FY_EST', width: 50, align: 'right', formatter: 'currency',sorttype: 'float',
						    formatoptions: { decimalSeparator: ".",
						        thousandsSeparator: ",",
						        prefix: "$"
						    }
						},
						{ name: 'FY_FEE', index: 'FY_FEE', width: 50, align: 'right', formatter: 'currency',sorttype: 'float',
						    formatoptions: { decimalSeparator: ".",
						        thousandsSeparator: ",",
						        prefix: "$"
						    }
						},
						{ name: 'AGE_CODE', index: 'AGE_CODE', hidden: false, width:10, editable: true },
                        { name: 'ACA_CODE', index: 'ACA_CODE', hidden: false, width:10, editable: true }
		            ],

		            //rowNum: 5,
		            //rowList: [15, 20, 40, 60],
		            ignoreCase: true,
		            autowidth: true,
		            height: 75,
		            pager: '#jqGInterestDetailPager',
		            viewrecords: true,
		            loadonce: true,
		            sortorder: "desc",
		            caption: "AGENCY SELECTED DETAIL",
		            editurl: "DAL/agenInterest.ashx?"
		        });
		        $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('navGrid', '#jqGInterestDetailPager', { edit: true, add: false, del: true, search: false, refresh: false },
			    {},     //Edit Option
                {},     //Add Option    
                {       //Del Option 
                    onclickSubmit: function (postdata) {
                    },
                    delData:  {
                        Age_Code_Value: function()
                        {
                            var sel_id = $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('getGridParam', 'selrow');
                            var value = $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('getCell', sel_id, 'AGE_CODE');
                            return value;
                        },
                        Aca_Code_Value: function ()
                        {
                            var sel_id = $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('getGridParam', 'selrow');
                            var value = $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('getCell', sel_id, 'ACA_CODE');
                            return value;

                        }
                    },
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    bottominfo: "Fields marked with (*) are required."

                }
                
                
                );
				$("#<%=jqGridInterestDetail.ClientID%>").jqGrid('destroyGroupHeader');
				$("#<%=jqGridInterestDetail.ClientID%>").jqGrid('setGroupHeaders', {
					useColSpanStyle: true,
					groupHeaders: [
									  { startColumnName: 'MONTH_FR', numberOfColumns: 2, titleText: '<b>FROM:</b>' },
									  { startColumnName: 'MONTH_TO', numberOfColumns: 2, titleText: '<b>TO:</b>' }
									]
				});


			} // end getAgGrid
		    function PercentageFormatter(cellvalue, options, rowObject) {

		        return cellvalue * 100 + "%";
		    }
		    function unPercentageFormatter(cellvalue, options) {

		        return cellvalue.replace("%", "");
		    }
			function getFundingGrid(fundingFlag, ageID) {

				if (fundingFlag == "no")
					urlString = "";
				else
					urlString = "DAL/Definitions.ashx?funding=" + +"&agencies=" + ageID;

				$("#<%=jqGridFunding.ClientID%>").jqGrid({
					url: urlString,
					datatype: "json",
					colNames: ['FUNDING DESCRIPTION', 'FUNDING AMOUNT', 'AGE CODE', 'COMMENTS', 'Development Funds?'],
					colModel: [
						{ name: 'FUND_TYPE', index: 'FUND_TYPE', width: 100, editable: true,
							editrules: { edithidden: false }, hidedlg: false,
							edittype: 'select', editoptions: { value: '1:1992 Proposition A, Per Parcel;2:1992 Proposition A, Per Parcel Acquisition;3:1992 Proposition A, Specified Development;4:1992 Proposition A, Specified Acquisition;5:1996 Proposition A, Per Parcel Acquisition;6:1996 Proposition A, Per Parcel;7:1996 Proposition A, Specified Development;8:1996 Proposition A, Specified Acquisition;9:Adjustment Transfers;10:Closed Projects as of 08/20/97 - Development (Credit);11:Closed Projects as of 08/20/97 - Acquisition;12:Additional Closed Projects - Development (Credit);13:Additional Closed Projects - Acquisition', defaultValue: 'Adjustment Transfers' }
						},
						{ name: 'FUND_AMT', index: 'FUND_AMT', width: 50, align: 'right', formatter: 'currency', editable: true,sorttype: 'float',
							editoptions: { formatoptions: { decimalSeparator: ".",
								thousandsSeparator: ",",
								prefix: "$"
							}
							}
						},
						{ name: 'AGE_CODE', index: 'AGE_CODE', hidden: true, editable: true, editrules: { edithidden: false }, hidedlg: true,
							editoptions: { defaultValue: function () {
								selRowId = $("#<%=jQGridDemo.ClientID%>").jqGrid('getGridParam', 'selrow');
								selACode = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', selRowId, 'AGE_CODE');
								return selACode;
							}
							}
						},
						{ name: 'COMMENTS', index: 'COMMENTS', width: 150, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
                        { name: 'CALCULATED', index: 'CALCULATED', hidden: false, width: 25, editable: true }
					],
					//	                rowNum: 5,
					//	                rowList: [15, 20, 40, 60],
					ignoreCase: true,
					autowidth: true,
					height: 100,
					pager: '#jqGridFundingPager',
					loadonce: true, // cause the data to be local
					viewrecords: true,
					sortorder: "desc",
					caption: "FUNDING DETAIL",
					editurl: "DAL/agenFunds.ashx?"
				});
				$("#<%=jqGridFunding.ClientID%>").jqGrid('navGrid', '#jqGridFundingPager', { edit: true, add: true, del: false, search: false, refresh: false },
	{ jqModal: true,
		closeAfterEdit: true,
		reloadAfterSubmit: true,
		closeAfterSubmit: true,
		afterSubmit: function (response, postdata) {
			$(this).jqGrid("setGridParam", { datatype: 'json' });
			return [true, response.responseText];
		}, width: 800
	   },
            { jqModal: true,
			  closeAfterEdit: true,
			  closeAfterSubmit: true,
			  reloadAfterSubmit: true,
			  afterSubmit: function (response, postdata) {
			  $(this).jqGrid("setGridParam", { datatype: 'json' });
			  return [true, response.responseText];
			  }, width:800 } );
			} // end getFundingGrid

			function getAgencyDropDown() {
				$.getJSON("DAL/Definitions.ashx?agencies=a&agencyType=0", function (data) {
					var ag_options = $("#agencyType");
					$.each(data, function (name, item) {
						ag_options.append($("<option />").val(item.AGE_CODE).text(item.AGENCY));
					});
				});
			}

			function getAngencyTypeDropDown() {
				$.getJSON("DAL/Definitions.ashx?agencies=0&agencyType=t", function (data) {
					var options = $("#agencyTypeID");
					$.each(data, function (name, item) {
						options.append($("<option />").val(item.ATP_CODE).text(item.AGE_TYPE));
					});
				});
			}

			function getDistrictTypeDropDown() {
				$.getJSON("DAL/Definitions.ashx?distType=d", function (data) {
					var options = $("#districtType");
					$.each(data, function (name, item) {
						options.append($("<option />").val(item.DIS_CODE).text(item.FULLNAME));
					});
				});
			}

			$("#agencyType").change(function () {
				var selValue = $('#agencyType').val();
				$("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/Definitions.ashx?agencies=" + selValue + "&agencyType=0", datatype: "json", page: 1 }).trigger("reloadGrid");
			});

			$("#agencyTypeID").change(function () {
				var selValue = $('#agencyTypeID').val();
				$("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/Definitions.ashx?agencies=0" + "&agencyType=" + selValue + "&distType=0", datatype: "json", page: 1 }).trigger("reloadGrid");
			});

			$("#districtType").change(function () {
				var selValue = $('#districtType').val();
				var selValue2 = $('#agencyTypeID').val();
				$("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/Definitions.ashx?agencies=0" + "&agencyType=0" + "&distType=" + selValue, datatype: "json", page: 1 }).trigger("reloadGrid");
			});


		});
    </script>    


</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">


<h1 class="page_head">Agencies - Definitions and Calculation Quotas</h1><br />



		  <!--Master-->
		  <div id="jqGridDiv"> 
		  
			<div style="width:100%; background-color:#E0E0E0 ; color:Black; padding-top:7px; padding-bottom:5px">
			
			<table width="100%">
				<tr>
					<td width="5%" align="right"><img src="img/binoculars.png" height="20px" width="20px" style="vertical-align:middle" /></td>
					<td width="45%" align="center"><b>Agency Name:</b> <select id='agencyType'></select></td>    
					<td width="25%" align="center"><b>Agency Type:</b> <select id='agencyTypeID'></select></td>
					<td width="25%" align="center"><b>District:</b> <select id='districtType'></select></td>
				</tr>
			</table>
 
					
				
			</div>
			
			<asp:Table ID="jQGridDemo" runat="server"></asp:Table>      
			<div id="jQGPager"></div>
		 </div>

		 <!--Detail-->
		 <br />
		 <div id="AgencyDetail">
			<asp:Table ID="jqGridInterestDetail" runat="server"></asp:Table>
	 
			<div id="jqGInterestDetailPager"></div>                
		 </div>
		 <br />
		 <!--Funding-->
		 <div id="AgencyFunding">
			<asp:Table ID="jqGridFunding" runat="server"></asp:Table>
			<div id="jqGridFundingPager"></div>
		 </div>

<br /><br />
<!--
	<div> <%--first--%>
	<asp:DropDownList runat="server" ID="agencydropdownlist" DataSourceID="agenciessource" DataTextField="AGENCY" DataValueField="AGE_CODE" OnSelectedIndexChanged="agencyselect" AutoPostBack="true" CssClass="bold" />
	<br /><br />
	<div id="secondDiv" runat="server" visible="false"> <%--second--%>


	<asp:Panel runat="server" ID="editPanel" Visible="False"  
		CssClass="editingpanel" BackColor="White" 
		BorderColor="Black" BorderStyle="Groove" Width="900px"
		Height="300px" BorderWidth="2" >
	   <asp:Label runat="server" ID="formAgencyLabel" Text="Agency: " /><asp:TextBox runat="server" ID="formAgency" Width="150px" />
	   <br />
	   <asp:Label runat="server" ID="formDeptLabel" Text="Deaprtment: " /><asp:TextBox runat="server" ID="formDept" Width="150px" />
	   <br />
	   <asp:Label runat="server" ID="formAgencyTypeLabel" Text="Type of Agency: " /><asp:DropDownList runat="server" ID="formAgencyType"  /> to be completed sorry


		<br />    <asp:Button runat="server" ID="editpanelclose" Text="Close" OnClick="closeEditPanel" />
	   </asp:Panel>


	<asp:SqlDataSource  ID="agenciessource" 
						runat="server" 
						DataSourceMode="DataSet"   
						ConnectionString="<%$ ConnectionStrings:FoxProDevConnectionString %>"
						SelectCommand="SELECT AGENCY, AGE_CODE FROM [AGENCIES] ORDER BY [AGE_CODE]" />

		<asp:Label text="here" runat="server" ID="test21" Visible="false"></asp:Label>
		

		<table border="0" width="100%">
			<tr>
				<td>
					<asp:Table ID="Table1" runat="server" Height="125px" Width="300px" BorderColor="Transparent" BorderWidth="0" >
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
			</td>
			<td> 
			<table border="0" width="400px">
				<tr>
					<td>Agency Name: <asp:Label runat="server" ID="AgencyInfo" Visible="true" /></td>
				</tr>
				<tr>
				   <td>Department: <asp:Label runat="server" ID="NameInfo"  /></td>
				</tr>
				<tr>
					<td>Agency Type: <asp:Label runat="server" ID="AgeTypeInfo" /></td>
				</tr>
				<tr>
					<td>District: <asp:Label runat="server" ID="DistrictInfo" /><br /></td>
				</tr>
				<tr>
				   <td>Address: <asp:Label runat="server" ID="ADR1Info" /><br /></td>
				</tr>
<%--                <tr>
					<td><asp:Label runat="server" ID="ADR2Info" /><br /></td>
				</tr>--%>
				<tr>
					<td>City: <asp:Label runat="server" ID="CityInfo" />                ZIP: <asp:Label runat="server" ID="ZipInfo" /></td>
				</tr>
					</table>
			</td>
			</tr>
			</table>
			</div>  <%--second--%>
			</div> <%--first--%>
	<br /> 
	

		<asp:GridView ID="agecalGrid" runat="server" AutoGenerateColumns="false" BorderColor="Transparent"  Width="100%" BorderWidth="0" GridLines="None" >
				  <Columns>
				  <asp:TemplateField HeaderText="From" ItemStyle-HorizontalAlign="Right">
					<ItemTemplate>
						<%#getMonth(Convert.ToInt32(Eval("MONTH_FR")))%> <%#Eval("YEAR_FR")%>
					</ItemTemplate>
				  </asp:TemplateField>

				  <asp:TemplateField Headertext=" "> <%--  hyphen --%>
					<ItemTemplate></ItemTemplate></asp:TemplateField><asp:TemplateField HeaderText="To" ItemStyle-HorizontalAlign="Right"> 
					<ItemTemplate>
						<%#getMonth(Convert.ToInt32(Eval("MONTH_TO")))%> <%#Eval("YEAR_TO")%>
					</ItemTemplate>
					</asp:TemplateField>

				   <asp:TemplateField Headertext="% from benefits ASSESEMNT" ItemStyle-HorizontalAlign="Center">
					<ItemTemplate>
					  <%#(Convert.ToDecimal(Eval("PCT_BAS"))*100).ToString("0.#####")%>%</ItemTemplate>
					  </asp:TemplateField>
						<asp:BoundField HeaderText="est. Maintenence" DataField="FY_EST"  ItemStyle-HorizontalAlign="Center" NullDisplayText="0" DataFormatString="{0:C2}"/>
						<asp:BoundField HeaderText="FY FEE" DataField="FY_FEE" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Center" NullDisplayText="0" />
				  </Columns>   
			 </asp:GridView>
			 <br />
			 
			 
			 

			 <asp:GridView ID="fundingGridView" runat="server" AutoGenerateColumns="false" Width="100%">
				<Columns>
				<asp:TemplateField HeaderText="Funding" ItemStyle-HorizontalAlign="Left">
					<ItemTemplate>
					   <%#Eval("FUND_TYPE")%>
					</ItemTemplate>
				</asp:TemplateField>
				<asp:TemplateField HeaderText="Funding Amount" ItemStyle-HorizontalAlign="Right">
					<ItemTemplate>
						<%#String.Format("{0:C}",(Convert.ToDecimal(Eval("AMT"))))%>
					</ItemTemplate>
				</asp:TemplateField>
				</Columns>
			 </asp:GridView>




			 <br /><br />
			 <asp:Button runat="server" ID="editButton" Text="NEW" OnClick="openEditPanel" />

-->
</asp:Content>
