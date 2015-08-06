<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BenefitsAssessment.aspx.cs" Inherits="ParksDev.BenefitsAssessment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">

    $(
        function () {

            getGrid();

            $('.ui-jqgrid-bdiv').height('100%');
            $('.ui-jqgrid').css('margin-left', 'auto');
            $('.ui-jqgrid').css('margin-right', 'auto');

            $("#dialog-detail").dialog({
                autoOpen: false,
                show: {
                    effect: "fade",
                    duration: 400
                },
                resizable: false,
                closeOnEscape: true,
                width: 700,
                height: 600,
                modal: true,
                position: "center",
                buttons: {
                    'Close': function () {
                        $(this).dialog('close');
                    }
                }
            });

            function getGrid() {

                jQuery("#<%=jQGridDemo.ClientID%>").jqGrid({
                    url: "DAL/BenefitsAssessmentDistribution.ashx",
                    datatype: "json",
                    colNames: ['BASCODE', 'DATE BA ENTERED', 'DATE POSTED', 'DOCUMENT CODE', 'DOCUMENT DEPT', 'DOCUMENT ID', 'AMOUNT POSTED', 'COLLECTED DEBT SERVICE', 'AVERAGE DAILY BALANCE', 'COMMENTS'],
                    colModel: [
                                { name: 'BASCODE', index: 'BASCODE', hidden: true, editable: true, editrules: { edithidden: false }, hidedlg: true },
                                { name: 'ENTERED', index: 'ENTERED', width: 70, sorttype: 'date', formatter: 'date', align: 'right', editable: true,
                                    formatoptions: {
                                        srcformat: 'm/d/Y',
                                        newformat: 'n/j/Y'
                                    },
                                    editoptions: {
                                        size: 10, maxlengh: 10,
                                        dataInit: function (element) {
                                            $(element).datepicker({ dateFormat: 'mm/dd/yy' })
                                        }
                                    }
                                },
                                { name: 'PROCESSED', index: 'PROCESSED', width: 70, sorttype: 'date', formatter: 'date', align: 'right', editable: true,
                                    formatoptions: {
                                        srcformat: 'm/d/Y',
                                        newformat: 'n/j/Y'
                                    },
                                    editoptions: {
                                        size: 10, maxlengh: 10,
                                        dataInit: function (element) {
                                            $(element).datepicker({ dateFormat: 'mm/dd/yy' })
                                        }
                                    }
                                },
                                { name: 'TC', index: 'TC', width: 10, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
                                { name: 'TD', index: 'TD', width: 10, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
                                { name: 'REFERENCE', index: 'REFERENCE', width: 10, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
                                { name: 'BAS', index: 'BAS', width: 100, align: 'right', formatter: 'currency', editable: true, sorttype: 'float',
                                    formatoptions: { decimalSeperator: ".",
                                        thousandsSeperator: ",",
                                        prefix: "$"
                                    },
                                    editoptions:{dataInit:function(el){$(el).maskMoney();}}
                                },
                                { name: 'FEE', index: 'FEE', width: 100, align: 'right', formatter: 'currency', hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true, sorttype: 'float',
                                    formatoptions: { decimalSeperator: ".",
                                        thousandsSeperator: ",",
                                        prefix: "$"
                                    }
                                },
                                { name: 'AVERAGE', index: 'AVERAGE', width: 100, align: 'right', formatter: 'currency', hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true, sorttype: 'float',
                                    formatoptions: { decimalSeperator: ".",
                                        thousandsSeperator: ",",
                                        prefix: "$"
                                    }
                                },
                                { name: 'COMMENTS', index: 'COMMENTS', width: 10, search: false, hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true },
                              ],
                    rowNum: 15,
                    rowList: [15, 20, 40, 60],
                    width: 800,
                    pager: '#jQGPager',
                    sortname: 'ENTERED',
                    viewrecords: true,
                    sortorder: "desc",
                    loadonce: true,
                    caption: "Selected Account Details (Case Sensitive)",
                    onSelectRow: function (ids) {
                        selRowID = $("#<%=jQGridDemo.ClientID%>").jqGrid('getGridParam', 'selrow');
                        selbascode = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', selRowID, 'BASCODE');

                        getGridDetails(selbascode);
                    },
                    editurl: "DAL/benefitADD.ashx"
                });
                $("#<%=jQGridDemo.ClientID%>").jqGrid('sortGrid', 'ENTERED', true, 'desc')
                $("#<%=jQGridDemo.ClientID%>").jqGrid('sortGrid', 'ENTERED', true, 'desc');
                jQuery("#<%=jQGridDemo.ClientID%>").jqGrid('navGrid', '#jQGPager', { edit: true, add: true, del: true, search: true, refresh: true },
                                                                                     { jqModal: true,
                                                                                         closeAfterEdit: true,
                                                                                         reloadAfterSubmit: true,
                                                                                         afterSubmit: function (response, postdata) {
                                                                                             $(this).jqGrid("setGridParam", { datatype: 'json' });
                                                                                             return [true, response.responseText];
                                                                                         }, width: 800
                                                                                     },
																			  { jqModal: true,
																			      closeAfterEdit: true,
																			      closeAfterAdd: true,
																			      reloadAfterSubmit: true,
																			      afterSubmit: function (response, postdata) {
																			          $(this).jqGrid("setGridParam", { datatype: 'json' });
																			          return [true, response.responseText];
																			      }, width: 800
																			  },
																			  { jqModal: true,
																			  reloadAfterSubmit: true,
																			      caption: "Delete Benefit Assesment and it's Distrubution",
																			      width: 400,
																			      beforeShowForm: function (form) {
																			          var sel_id = $("#<%=jQGridDemo.ClientID%>").jqGrid('getGridParam', 'selrow');
																			          var entered = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', sel_id, 'ENTERED');

																			          $("td.delmsg",form).html("Do you really want delete transaction dated on " + entered +
                                                                                      "</b>?");},
																			      beforeSubmit: function (response, postdata) {
																			          $(this).jqGrid("setGridParam", { datatype: 'json' });
																			          return [true, response.responseText];
																			      },
																			      delData: {
																			          delcode: function () {
																			              var sel_id = $("#<%=jQGridDemo.ClientID%>").jqGrid('getGridParam', 'selrow');
																			              var agevalue = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', sel_id, 'BASCODE');
																			              return agevalue;
																			          }
																			      }
																			  }
                ); // end of jqGrid - navGrid
                jQuery("#<%=jQGridDemo.ClientID%>").setGridParam({ datatype: 'json' }).trigger("reloadGrid", [{ current: true}]);
                $("#<%=jQGridDemo.ClientID%>").jqGrid('filterToolbar', { stringResult: true, searchOnEnter: false });

            }

            function getGridDetails(bascode) {
                $("#dialog-detail").dialog("open");
                var gridWidth = $("#dialog-detail").width();

                $("#<%=jqGridInterestDetail.ClientID%>").jqGrid({
                    url: "DAL/BADdetails.ashx?bascode=" + bascode,
                    datatype: "json",
                    colNames: ['ATP_CODE', 'AGENCY', 'AMOUNT POSTED', 'COLLECTED DEBT SERVICE', 'AVERAGE DAILY BALANCE', 'ABA_CODE'],
                    colModel: [
                                    { name: 'ATP_CODE', index: 'ATP_CODE', width: 100, hidden: true },
                                    { name: 'AGENCY', index: 'AGENCY', width: 100 },
                                    { name: 'BAS', index: 'BAS', width: 100, align: 'right', formatter: 'currency', editable: true, sorttype: 'float', formatoptions: { decimalSeparator: ".",
                                        thousandsSeparator: ",",
                                        prefix: "$"
                                    }
                                    },
                                    { name: 'FEE', index: 'FEE', width: 100, align: 'right', formatter: 'currency', editable: true, sorttype: 'float', formatoptions: { decimalSeparator: ".",
                                        thousandsSeparator: ",",
                                        prefix: "$"
                                    }
                                    },
                                    { name: 'AVERAGE', index: 'AVERAGE', width: 100, align: 'right', formatter: 'currency', editable: true, sorttype: 'float', formatoptions: { decimalSeparator: ".",
                                        thousandsSeparator: ",",
                                        prefix: "$"
                                    }
                                    },
                                    { name: 'ABA_CODE', index: 'ABA_CODE', hidden: true, editable: true, editrules: { edithidden: false }, hidedlg: true }
                              ],
                    rowNum: 18,
                    //                    rowList: [15, 20, 40, 60],
                    width: gridWidth,
                    height: '70%',
                    pager: '#jqGInterestDetailPager',
                    viewrecords: true,
                    multiSort: true,
                    sortname: 'ATP_CODE,Agency',
                    sortorder: "asc",
                    loadonce: true,
                    caption: "Agency Distributions",
                    editurl: "DAL/BADedit.ashx"
                });
                $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('navGrid', '#jqGInterestDetailPager', { edit: true, add: false, del: false, search: false, refresh: false },
                                                                                                        { jqModal: true,
                                                                                                            closeAfterEdit: true,
                                                                                                            reloadAfterSubmit: true,
                                                                                                            afterSubmit: function (response, postdata) {
                                                                                                                $(this).jqGrid("setGridParam", { datatype: 'json' });
                                                                                                                return [true, response.responseText];
                                                                                                            }, width: 800
                                                                                                        }
                                                                                                    );
                $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('setGridParam', { url: "DAL/BADdetails.ashx?bascode=" + bascode, datatype: "json", page: 1 }).trigger("reloadGrid");

            }
        }

    );

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <h1 class="page_head">Benefit Assesment and it's Distrubution</h1><br />


           <div id="jqGridDiv"> 
                <asp:Table ID="jQGridDemo" runat="server"></asp:Table>      
                <div id="jQGPager"></div>
         </div>
         <br />
       <%--  details--%>
                  <div id="dialog-detail">
            <asp:Table ID="jqGridInterestDetail" runat="server"></asp:Table>
            <div id="jqGInterestDetailPager"></div>                
         </div>


         <br /><br /><br />

</asp:Content>
