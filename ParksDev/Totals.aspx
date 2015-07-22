<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Totals.aspx.cs" Inherits="ParksDev.Totals" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

<style type="text/css">

#jqGridDiv
{
    position:relative;
    z-index:1;
}

</style>

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
                    url: "DAL/Totals.ashx",
                    datatype: "json",
                    colNames: ['YEAR', 'BEGINING BALANCE', 'ENDING BALANCE', 'YEG BALANCE', 'DEBT SERVICE BALANCE', 'FY'],
                    colModel: [
                                    { name: 'YEAR', index: 'YEAR', width: 50, align: 'center' },
                                    { name: 'BEGBAL', index: 'BEGBAL', width: 50, align: 'right', formatter: 'currency', sorttype: 'float',
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
                                    },
                                    { name: 'FY', index: 'FY', hidden: true }
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
                        selRowId = $("#<%=jQGridDemo.ClientID%>").jqGrid('getGridParam', 'selrow');
                        selYear = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', selRowId, 'FY');

                        getGridDetail(selYear);
                    }
                });
                jQuery("#<%=jQGridDemo.ClientID%>").jqGrid('navGrid', '#jQGPager', { edit: false, add: false, del: false, search: false, refresh: true }); // end of jqGrid - navGrid
                jQuery("#<%=jQGridDemo.ClientID%>").setGridParam({ datatype: 'json' }).trigger("reloadGrid", [{ current: true}]);
                $("#<%=jQGridDemo.ClientID%>").jqGrid('filterToolbar', { stringResult: true, searchOnEnter: false });

            }
            function getGridDetail(year) {
                $("#dialog-detail").dialog("open");
                var gridWidth = $("#dialog-detail").width();

                $("#<%=jqGridInterestDetail.ClientID%>").jqGrid({
                    url: "DAL/totalMonths.ashx?fy=" + year,
                    datatype: "json",
                    colNames: ['Month', 'Year', 'Starting Balance', 'Ending Balance', 'Collected Debt Services', 'Monthly Interest'],
                    colModel: [
                                    { name: 'MONTH', index: 'MONTH', width: 70, formatter: 'date', align: 'right',
                                        formatoptions: {
                                            srcformat: 'm',
                                            newformat: 'F'
                                        }
                                    },
                                    { name: 'YEAR', index: 'YEAR', align:'center', width: 50 },
                                    { name: 'BEG_SUM', index: 'BEG_SUM', width: 100, align: 'right', formatter: 'currency', sorttype: 'float',
                                        formatoptions: { decimalSeparator: ".",
                                            thousandsSeparator: ",",
                                            prefix: "$"
                                        }
                                    },
                                    { name: 'END_BAL', index: 'END_BAL', width: 100, align: 'right', formatter: 'currency', sorttype: 'float',
                                        formatoptions: { decimalSeparator: ".",
                                            thousandsSeparator: ",",
                                            prefix: "$"
                                        }
                                    },
                                    { name: 'DEBT', index: 'DEBT', width: 130, align: 'right', formatter: 'currency', sorttype: 'float',
                                        formatoptions: { decimalSeparator: ".",
                                            thousandsSeparator: ",",
                                            prefix: "$"
                                        }
                                    },
                                    { name: 'INTR', index: 'INTR', width: 100, align: 'right', formatter: 'currency', sorttype: 'float',
                                        formatoptions: { decimalSeparator: ".",
                                            thousandsSeparator: ",",
                                            prefix: "$"
                                        }
                                    }
                              ],
                    rowNum: 18,
                    //                    rowList: [15, 20, 40, 60],
                    width: gridWidth,
                    height: '70%',
                    pager: '#jqGInterestDetailPager',
                    sortname: 'MONTH',
                    viewrecords: true,
                    sortorder: "desc",
                    loadonce: true,
                    caption: "Monthly Totals:"
                });
                jQuery("#<%=jqGridInterestDetail.ClientID%>").jqGrid('navGrid', '#jqGInterestDetailPager', { edit: false, add: false, del: false, search: false, refresh: true });
                $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('setGridParam', { url: "DAL/totalMonths.ashx?fy=" + year, datatype: "json", page: 1 }).trigger("reloadGrid");

            } //end function
        }
    );

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <h1 class="page_head">Running Balance Totals for Fiscal Year and it's Months </h1><br /><br />

           <div id="jqGridDiv"> 
                <asp:Table ID="jQGridDemo" runat="server"></asp:Table>      
                <div id="jQGPager"></div>
         </div>

         <br />
                  <div id="dialog-detail">
            <asp:Table ID="jqGridInterestDetail" runat="server"></asp:Table>
            <div id="jqGInterestDetailPager"></div>                
         </div>

    <%--<asp:GridView ID="totals" runat="server" OnLoad="loadTotalGrid" AutoGenerateColumns="true" Visible="true"  ></asp:GridView>--%>


</asp:Content>
