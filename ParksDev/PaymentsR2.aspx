<%@ Page Title="" Language="C#" CodeBehind="PaymentsR2.aspx.cs" MasterPageFile="~/Site.Master" Inherits="ParksDev.PaymentsR2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
		.style1
		{
			width: 100%;
		}
	</style>

	<script type="text/javascript">
		$(function () {

			getGrid("", "","Step1");
			//getAgGrid("no", "0"); // get detail grid
			getAgencyDropDown();
			getAngencyTypeDropDown();
			getDistrictTypeDropDown();
			//getFundingGrid("no", 0);
			getagencyFiscalYearDropDown()
			// get the Master Grid
			function getGrid(agency, agencyFiscalYear, flag) {
				$("#<%=jQGridDemo.ClientID%>").jqGrid({
				    url: "DAL/PaymentsR2.ashx?agencies=" + agency + "&agencyFiscalYear=" + agencyFiscalYear + "&switch=" + flag,
					datatype: "json",
					colNames: ['TC', 'TD', 'Reference', 'Processed', 'Transferred', 'Trans. Amount', 'ADB', 'MinObj', 'Last Updated By', 'Last UpDate', 'Code'],
					colModel: [
													{ name: 'TC', index: 'TC', width: 100, search: false, hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true, sorttype:'text'},
													{ name: 'TD', index: 'TD', width: 150, search: false, hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true },
													{ name: 'Reference', index: 'Reference', width: 150, search: false, hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true },
													{
													    name: 'Processed', index: 'Processed', width: 150, search: false, hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true, formatter: 'date',
													    formatoptions: {
													        srcformat: 'm/d/Y', newformat: 'ShortDate'

                                                        },
													},
													{
													    name: 'Transferred', index: 'Transferred', width: 150, search: false, hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true, formatter: 'date',
													    formatoptions: {
													        srcformat: 'm/d/Y',
													        newformat: 'ShortDate',
													        defaultValue: null // does nothing!
													    },
													},
													{ name: 'TRA', index: 'TRA', width: 150, search: false, hidden: false, editable: true, editrules: { edithidden: true },formatter: 'currency', 


													    formatoptions: { prefix: '$', suffix: '', thousandsSeparator: ',' },



													hidedlg: true
													},
											
													{ name: 'Average', index: 'Average', width: 150, search: false, hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true, formatter: 'currency', 
																		formatoptions:{prefix:'$',suffix:'',thousandsSeparator:','},hidedlg: true },
													{ name: 'MinObj', index: 'MinObj', width: 150, search: false, hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true },
                                                    { name: 'LUPD_USER', index: 'LUPD_USER', width: 150, search: false, hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true },
													{
													    name: 'LUPD_DATE', index: 'LUPD_DATE', width: 100, search: false, align: 'right', formatter: 'date', hidden: false,
													    formatoptions: {
													        srcformat: 'm/d/Y',
													        newformat: 'ShortDate',
													        defaultValue: null // does nothing!
													    },
													},
													{ name: 'TRA_CODE', index: 'TRA_CODE', width: 100, search: false, align: 'right', editable: false, sorttype: 'float'}
													
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
                    //footerrow: true,
                    //loadComplete: function () {
                    //    var $self = $(this),
                    //        sum = $self.jqGrid("getCol", "TRA", false, "sum");

                    //    $self.jqGrid("footerData", "set", { Transferred: "Total:", TRA: sum });
                    //},
					caption: "Payments Lookup", 

					onSelectRow: function (ids) {
					    selRowId = $("#<%=jQGridDemo.ClientID%>").jqGrid('getGridParam', 'selrow');
					    //alert(selRowId);
					    tra_codevalue = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', selRowId, 'TRA_CODE');

					    if (tra_codevalue != '') {
					        //alert(tra_codevalue);
					        window.location.href = 'Payments.aspx?TransID=' + tra_codevalue;
					    }
					    else {
					        alert("Please select the correct records!")
					        return false;
					    }
					    
					},
					editurl: "DAL/agenciesCode.ashx"
				});
				$("#<%=jQGridDemo.ClientID%>").jqGrid('navGrid', '#jQGPager', { edit: false, add: false, del: false, search: false, refresh: false },
																			  {
																			      jqModal: true,
																				  closeAfterEdit: true,
																				  reloadAfterSubmit: true,
																				  afterSubmit: function (response, postdata) {
																					  $(this).jqGrid("setGridParam", { datatype: 'json' });
																					  return [true, response.responseText];
																				  }, width: 800
																			  },
																			  {
																			      jqModal: true,
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
			    $("#<%=jQGridDemo.ClientID%>").jqGrid('navGrid', '#jQGPager').navButtonAdd('#jQGPager', {
			        caption: "Add Record",
			        buttonicon: "ui-icon-add",
			        onClickButton: function () {
			            window.location.href = 'Payments.aspx'
			        },
			        position: "last"
			    });

			    $("#<%=jQGridDemo.ClientID%>").jqGrid('navGrid', '#jQGPager').navButtonAdd('#jQGPager', {
			        caption: "Delete Record",
			        buttonicon: "ui-icon-add",
			        onClickButton: function () {
			            var sel_id = $("#<%=jQGridDemo.ClientID%>").jqGrid('getGridParam', 'selrow');
			            var tra_codevalue = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', sel_id, 'TRA_CODE');
			            if (tra_codevalue !='') {
			                //alert(tra_codevalue);
			                window.location.href = 'Payments.aspx?TransID='+ tra_codevalue;
			            }
			            else {
			                alert("Please select the correct records!")
			                return false;
			            }
			            
			        },
			        position: "last"
			    });


<%--				$("#<%=jQGridDemo.ClientID%>").jqGrid('navButtonAdd', "#jQGPager", { caption: "Reload", title: "Reload Data", buttonicon: "ui-icon-refresh",
					onClickButton: function () { $("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/Definitions.ashx?agencies=a&agencyType=0", datatype: "json", page: 1 }).trigger("reloadGrid"); }
				});--%>

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
			    {
			        jqModal: true,
			        closeAfterEdit: true,
			        reloadAfterSubmit: true,
			        afterSubmit: function (response, postdata) {
			            $(this).jqGrid("setGridParam", { datatype: 'json' });
			            return [true, response.responseText];
			        }, width: 800
			    },     //Edit Option
                {
                    jqModal: true,
                    closeAfterEdit: true,
                    reloadAfterSubmit: true,
                    afterSubmit: function (response, postdata) {
                        $(this).jqGrid("setGridParam", { datatype: 'json' });
                        return [true, response.responseText];
                    }, width: 800
                },     //Add Option    
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
                    closeOnEscape: true
                    

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

		        return (cellvalue * 100).toFixed(5) + "%";
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
				    ag_options.append($("<option />").val('ALL').text('ALL'));
					$.each(data, function (name, item) {
						ag_options.append($("<option />").val(item.AGE_CODE).text(item.AGENCY));
					});
					//$("#agencyFiscalYear").val = 2015
					//getagencyFiscalYearDropDown();
				});
			}
			function getagencyFiscalYearDropDown()
			{
			    $.getJSON("DAL/PaymentsR2.ashx?agencies=null&agencyFiscalYear=null&switch=Step2",function(data){
			        var fiscalYear_options = $("#agencyFiscalYear");
			        fiscalYear_options.append($("<option />").val('ALL').text('ALL'));
			        $.each(data,function (name,item) {
			            fiscalYear_options.append($("<option />").val(item.FiscalYear).text(item.FiscalYear));
    
			        });
			    });
			}
			function getAngencyTypeDropDown() {
				//$.getJSON("DAL/Definitions.ashx?agencies=0&agencyType=t", function (data) {
				//	var options = $("#agencyTypeID");
				//	$.each(data, function (name, item) {
				//		options.append($("<option />").val(item.ATP_CODE).text(item.AGE_TYPE));
				//	});
				//});
			}

			function getDistrictTypeDropDown() {
				//$.getJSON("DAL/Definitions.ashx?distType=d", function (data) {
				//	var options = $("#districtType");
				//	$.each(data, function (name, item) {
				//		options.append($("<option />").val(item.DIS_CODE).text(item.FULLNAME));
				//	});
				//});
			}

			$("#agencyType").change(function () {
			    var selValue = $('#agencyType').val();
			    var selagencyFiscalYear = $("#agencyFiscalYear").val();
			    //$("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/PaymentsR2.ashx?agencies=" + selValue + "&agencyFiscalYear=+&flag=Step1", datatype: "json", page: 1 }).trigger("reloadGrid");
			    $("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/PaymentsR2.ashx?agencies=" + selValue + "&agencyFiscalYear=" + selagencyFiscalYear + "&flag=Step1", datatype: "json", page: 1 }).trigger("reloadGrid");
			});

		    $("#agencyFiscalYear").change(function () {
		        var selValue = $('#agencyType').val();
		        var selagencyFiscalYear = $("#agencyFiscalYear").val();
		        $("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/PaymentsR2.ashx?agencies=" + selValue + "&agencyFiscalYear=" + selagencyFiscalYear + "&flag=Step1", datatype: "json", page: 1 }).trigger("reloadGrid");
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

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page_head">Payments</h1><br />
    
		  <div id="jqGridDiv"> 
		  
			<div style="width:100%; background-color:#E0E0E0 ; color:Black; padding-top:7px; padding-bottom:5px">
			
			<table width="100%">
				<tr>
					<td width="5%" align="right"><img src="img/binoculars.png" height="20px" width="20px" style="vertical-align:middle" /></td>
					<td width="45%" align="center"><b>Agency Name:</b> <select id='agencyType'></select></td>    
					<td width="25%" align="center"><b>Fiscal Year:</b> <select id='agencyFiscalYear'></select></td>
					<%--<td width="25%" align="center"><b>District:</b> <select id='districtType'></select></td>--%>
				</tr>
			</table>
 
					
				
			</div>
			
			<asp:Table ID="jQGridDemo" runat="server"></asp:Table>      
			<div id="jQGPager"></div>
		 </div>

		 <!--Detail-->
		 <br />
		 <div id="AgencyDetail">
			<asp:Table ID="jqGridInterestDetail" runat="server" visible="false"></asp:Table>
	 
			<div id="jqGInterestDetailPager" runat="server" visible="false"></div>                
		 </div>
		 <br />
		 <!--Funding-->
		 <div id="AgencyFunding">
			<asp:Table ID="jqGridFunding" runat="server" Visible="false"></asp:Table>
			<div id="jqGridFundingPager"></div>
		 </div>

  </asp:Content>


