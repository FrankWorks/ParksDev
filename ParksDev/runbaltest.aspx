<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="runbaltest.aspx.cs" Inherits="ParksDev.runbaltest" %>
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


            function getGrid() {

                jQuery("#<%=jQGridDemo.ClientID%>").jqGrid({
                    url: "DAL/runningBalG.ashx?ACODE=2",
                    datatype: "json",
                    colNames: ['YEAR', 'BEGINING BALANCE', 'ENDING BALANCE', 'YEG BALANCE', 'DEBT SERVICE BALANCE'],
                    colModel: [
                                    { name: 'YEAR', index: 'YEAR', width: 50, align: 'center' },
                                    { name: 'BEGBAL', index: 'BEGBAL', width: 50, align: 'right', formatter: 'currency',
                                        formatoptions: { decimalSeperator: ".",
                                            thousandsSeperator: ",",
                                            prefix: "$"
                                        }
                                    },
                                    { name: 'ENDBAL', index: 'ENDBAL', width: 50, align: 'right', formatter: 'currency',
                                        formatoptions: { decimalSeperator: ".",
                                            thousandsSeperator: ",",
                                            prefix: "$"
                                        }
                                    },
                                    { name: 'YEGBAL', index: 'YEGBAL', width: 50, align: 'right', formatter: 'currency',
                                        formatoptions: { decimalSeperator: ".",
                                            thousandsSeperator: ",",
                                            prefix: "$"
                                        }
                                    },
                                    { name: 'FEEBAL', index: 'FEEBAL', width: 50, align: 'right', formatter: 'currency',
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
                    sortorder: "desc",
                    loadonce: true,
                    caption: "Selected Account Details (Case Sensitive)"
                });
                jQuery("#<%=jQGridDemo.ClientID%>").jqGrid('navGrid', '#jQGPager', { edit: false, add: false, del: false, search: false, refresh: true }); // end of jqGrid - navGrid
                jQuery("#<%=jQGridDemo.ClientID%>").setGridParam({ datatype: 'json' }).trigger("reloadGrid", [{ current: true}]);
                $("#<%=jQGridDemo.ClientID%>").jqGrid('filterToolbar', { stringResult: true, searchOnEnter: false });

            }
        }
    );

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <h1>Running Balance Totals for Fiscal Year and it's Months </h1><br /><br />

           <div id="jqGridDiv"> 
                <asp:Table ID="jQGridDemo" runat="server"></asp:Table>      
                <div id="jQGPager"></div>
         </div>

         <br />

    <%--<asp:GridView ID="totals" runat="server" OnLoad="loadTotalGrid" AutoGenerateColumns="true" Visible="true"  ></asp:GridView>--%>


</asp:Content>