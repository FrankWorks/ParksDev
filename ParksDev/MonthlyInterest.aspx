<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MonthlyInterest.aspx.cs" Inherits="ParksDev.MonthlyInterest" %>
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
                    url: "DAL/MonthlyInterest.ashx",
                    datatype: "json",
                    colNames: ['Date Entered', 'MONTH NUMBER', 'MONTH','YEAR', 'AMOUNT POSTED', 'COMMENTS'],
                    colModel: [
                                    { name: 'ENTERED', index: 'ENTERED', width: 100, sorttype: 'date', formatter: 'date', align: 'center', editable:true,
                                        formatoptions: {
                                            srcformat: 'm/d/Y',
                                            newformat: 'n/j/Y'
                                        }
                                    },
                                    { name: 'MONTH', index: 'MONTH', width: 100, align: 'center', hidden: true },
                                    { name: 'MONTH', index: 'MONTH', width: 100, align: 'right', formatter: 'date', hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true,
                                        formatoptions: {
                                            srcformat: 'm',
                                            newformat: 'F'
                                        }
                                    },
                                    { name: 'YEAR', index: 'YEAR', width: 50, sorttype: 'float', align: 'left', hidden: false, editable: true, editrules: { edithidden: true }, hidedlg: true },
                                    { name: 'INT', index: 'INT', width: 150, sorttype: 'float', align: 'right', formatter: 'currency', editable: true, formatoptions: { decimalSeparator: ".",
                                        thousandsSeparator: ",",
                                        prefix: "$" }
                                },
                                    { name: 'COMMENTS', index: 'COMMENTS', hidden: true, editable: true, editrules: { edithidden: true }, hidedlg: true }
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
                        selMonth = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', selRowId, 'MONTH');
                        selYear = $("#<%=jQGridDemo.ClientID%>").jqGrid('getCell', selRowId, 'YEAR');

                        getGridDetail(selMonth, selYear);
                    },
                    editurl:"DAL/monthIadd.ashx"
                });
                $("#<%=jQGridDemo.ClientID%>").jqGrid('navGrid', '#jQGPager', { edit: true, add: false, del: false, search: false, refresh: true },
                {jqModal: true,
																			      closeAfterEdit: true,
																			      reloadAfterSubmit: true,
																			      afterSubmit: function (response, postdata) {
																			          $(this).jqGrid("setGridParam", { datatype: 'json' });
																			          return [true, response.responseText];
																			      }
																			  }); // end of jqGrid - navGrid
                //$("#<%=jQGridDemo.ClientID%>").setGridParam({ datatype: 'json' }).trigger("reloadGrid", [{ current: true}]);
                //$("#<%=jQGridDemo.ClientID%>").jqGrid('filterToolbar', { stringResult: true, searchOnEnter: false });
            }

            function getGridDetail(month, year) {
                $("#dialog-detail").dialog("open");
                var gridWidth = $("#dialog-detail").width();

                $("#<%=jqGridInterestDetail.ClientID%>").jqGrid({
                    url: "DAL/MonthlyInterestDetail.ashx?month=" + month + "&year=" + year,
                    datatype: "json",
                    colNames: ['AGENCY', 'STARTING BALANCE', 'AMOUNT POSTED'],
                    colModel: [
                                    { name: 'AGENCY', index: 'AGENCY', width: 100 },
                                    { name: 'AMT_BEG', index: 'AMT_BEG', width: 50, align: 'right', formatter: 'currency', sorttype: 'float',
                                    formatoptions: { decimalSeparator: ".",
                                        thousandsSeparator: ",",
                                        prefix: "$"} 
                                    },
                                    { name: 'AMT_INT', index: 'AMT_INT', width: 50, align: 'right', formatter: 'currency', sorttype: 'float',
                                    formatoptions: { decimalSeparator: ".",
                                        thousandsSeparator: ",",
                                        prefix: "$"} 
                                    }
                              ],
                    rowNum: 18,
//                    rowList: [15, 20, 40, 60],
                    width: gridWidth,
                    height: '70%',
                    pager: '#jqGInterestDetailPager',
                    sortname: 'AGENCY',
                    viewrecords: true,
                    sortorder: "desc",
                    loadonce: true,
                    caption: "Agency Distribution:"
                });
                $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('navGrid', '#jqGInterestDetailPager', { edit: false, add: false, del: false, search: false, refresh: true });
                $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('setGridParam', { url: "DAL/MonthlyInterestDetail.ashx?month=" + month + "&year=" + year, datatype: "json", page: 1 }).trigger("reloadGrid");

            } //end function
        }
    );

</script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <h1 class="page_head">Monthly Interest</h1><br />
            <!--Master-->
          <div id="jqGridDiv"> 
            <asp:Table ID="jQGridDemo" runat="server"></asp:Table>      
            <div id="jQGPager"></div>
         </div>
         <br />
            <!--Detail-->
         <div id="dialog-detail">
            <asp:Table ID="jqGridInterestDetail" runat="server"></asp:Table>
            <div id="jqGInterestDetailPager"></div>                
         </div>

         <!--

 <asp:Button ID="showgridss" OnClick="showoldgrid" Text="toggle old grid" Visible="true" runat="server" />
 <br />
        <asp:Panel ID="MIG" runat="server" ScrollBars="Auto" Height="300px" >

        <asp:GridView ID="MonthlyINTGrid" runat="server" AutoGenerateColumns="false" Width="800"
        AllowSorting="false" DataSourceID="MIgriddatasource" AllowPaging="false" 
        AutoGenerateSelectButton="True"  RowStyle-HorizontalAlign="Right"  EnablePersistedSelection="true" DataKeyNames="INT_CODE" OnSelectedIndexChanged="distGridSelected" OnSelectedIndexChanging="distGridSelecting">
        <Columns>
        <asp:BoundField DataField="ENTERED" DataFormatString="{0:d}" HeaderText="BA Entered" />
        <asp:BoundField DataField="YEAR" HeaderText="Year" />
        <asp:BoundField DataField="MONTH" Headertext="month number" Visible="true" />
        <asp:TemplateField HeaderText="Month">
            <ItemTemplate>
                <asp:Label runat="server" ID="MonthYear" Text='<%=/*#getMonth(Convert.ToInt32(Eval("MONTH")))*/%>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="INT" DataFormatString="{0:C2}" HeaderText="Amount Posted"/>
        </Columns>
        </asp:GridView>
        </asp:Panel>

        <asp:SqlDataSource 
            ID="MIgriddatasource" 
            runat="server" 
            DataSourceMode="DataReader"
            ConnectionString="<%$ ConnectionStrings:FoxProDevConnectionString %>"
            SelectCommand="select * from [FOXPRODEV].[dbo].[INTEREST] order by [YEAR] desc, [MONTH] desc">
        </asp:SqlDataSource>
        
        <br /><br />
      <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" Height="300px">
      <asp:GridView ID="MonthDistGrid" runat="server" AutoGenerateColumns="false" Visible="true">
      <Columns>
        <asp:BoundField HeaderText="Agency Distribution:" DataField="AGENCY" />
        <asp:BoundField HeaderText="Starting Balance" DataField="AMT_BEG" DataFormatString="{0:c}" ItemStyle-HorizontalAlign="Right" />
        <asp:BoundField HeaderText="Amounted Posted" DataField="AMT_INT" DataFormatString="{0:c}" ItemStyle-HorizontalAlign="Right" />
      </Columns>
      </asp:GridView>
     </asp:Panel>
-->
</asp:Content>
