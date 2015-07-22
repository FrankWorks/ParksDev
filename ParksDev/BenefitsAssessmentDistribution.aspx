<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BenefitsAssessmentDistribution.aspx.cs" Inherits="ParksDev.BenefitsAssessmentDistribution" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

<style type="text/css">

</style>
<script type="text/javascript">
    $(
        function () {

            getGrid();

            $('.ui-jqgrid-bdiv').height('100%');
            $('.ui-jqgrid').css('margin-left', 'auto');
            $('.ui-jqgrid').css('margin-right', 'auto');

            function getGrid() {

                jQuery("#<%=jQGridDemo1.ClientID%>").jqGrid({
                    url: "DAL/BenefitsAssessmentDistribution.ashx",
                    datatypes: "json",
                    colNames: ['AVERAGE'],
                    colModel: [
//                                    { name: 'ENTERED', index: 'ENTERED', width: 100, formatter: 'date',
//                                        formatoptions: {
//                                            srcformat: 'm/d/Y',
//                                            newformat: 'n/j/Y'
//                                        }
//                                    },
//                                    { name: 'PROCESSED', index: 'PROCESSED', width: 100, formatter: 'date',
//                                        formatoptions: {
//                                            srcformat: 'm/d/Y',
//                                            newformat: 'n/j/Y'
//                                        }
//                                    },
//                                    { name: 'BAS', index: 'BAS', width: 100, align: 'center', formatter: 'currency',
//                                        formatoptions: { decimalSeperator: ".",
//                                            thousandsSeperator: ",",
//                                            prefix: "$"
//                                        }
//                                    },
//                                    { name: 'FEE', index: 'FEE', width: 100, align:'center', formatter: 'currency',
//                                        formatoptions: { decimalSeperator: ".",
//                                            thousandsSeperator: ",",
//                                            prefix: "$"
//                                        }
//                                    },
//                                    { name: 'AVERAGE', index: 'AVERAGE', width: 100, align: 'center', formatter: 'currency',
//                                        formatoptions: { decimalSeperator: ".",
//                                            thousandsSeperator: ",",
//                                            prefix: "$"
//                                        }
//                                    }



                                    ],
                    rowNum: 15,
                    rowList: [15, 20, 40, 60],
                    width: 800,
                    height: 500,
                    pager: '#jQGPager1',
                    sortname: 'AVERAGE',
                    viewrecords: true,
                    sortorder: "desc",
                    loadonce: true,
                    caption: "Selected Account Details (Case Sensitive)"
                });
                jQuery("#<%=jQGridDemo1.ClientID%>").jqGrid('navGrid', '#jQGPager1', { edit: false, add: false, del: false, search: false, refresh: true }); // end of jqGrid - navGrid
                jQuery("#<%=jQGridDemo1.ClientID%>").setGridParam({ datatype: 'json' }).trigger("reloadGrid", [{ current: true}]);
                $("#<%=jQGridDemo1.ClientID%>").jqGrid('filterToolbar', { stringResult: true, searchOnEnter: false });
            }
        }
);
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <h1>Benefit Assesment and it's Distrubution</h1><br />

 <div id="jqGridDiv1">
    <asp:Table ID="jQGridDemo1" runat="server" ></asp:Table>
            <div id="jQGPager1"></div>
 </div>


 <!--
 <asp:Panel ID="BADpanel" runat="server" ScrollBars="Auto" Height="300px" Visible="false">
        <asp:GridView ID="BenAssDisGrid" runat="server" AutoGenerateColumns="false" DataSourceID="BADsource" AutoGenerateSelectButton="true"
       DataKeyNames="BAS_CODE" Width="98%"  OnSelectedIndexChanged="badselected" OnSelectedIndexChanging="badselectchanging" SelectedIndex="1" se  >
         <Columns>
         <asp:BoundField DataField="BAS_CODE" HeaderText="Bas Code" Visible="false" />
         <asp:BoundField DataField="ENTERED" HeaderText="BA Entered" SortExpression="ENTERED" DataFormatString="{0:MM/dd/yyyy}" />
         <asp:BoundField DataField="PROCESSED" HeaderText="Date Posted" DataFormatString="{0:MM/dd/yyyy}" />
         <asp:BoundField DataField="BAS" HeaderText="Amount Posted" DataFormatString="{0:c}" ItemStyle-HorizontalAlign="Right" />
         <asp:BoundField DataField="FEE" HeaderText="Collected Debt Service" DataFormatString="{0:c}" ItemStyle-HorizontalAlign="Right" />
         <asp:BoundField DataField="AVERAGE" HeaderText="Avg Daily Balance" DataFormatString="{0:c}" ItemStyle-HorizontalAlign="Right" />
         </Columns>
         </asp:GridView>
         </asp:Panel>
         <asp:SqlDataSource ID="BADsource" runat="server" DataSourceMode="DataSet" ConnectionString="<%$ ConnectionStrings:FoxProDevConnectionString %>"
          SelectCommand="Select * from  [FOXPRODEV].[dbo].[BENEFITS] order by [ENTERED] desc" />

          <br />
           <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" Height="300px">
          <asp:GridView ID="AgencyDistGrid" runat="server" AutoGenerateColumns="false" >
           <Columns>
           <asp:BoundField HeaderText="Agency Distribution:" DataField="AGENCY" />
           <asp:BoundField HeaderText="Amount Posted" DataField="BAS" DataFormatString="{0:c}" ItemStyle-HorizontalAlign="Right" />
           <asp:BoundField HeaderText="Collected Debt Service" DataField="FEE" DataFormatString="{0:c}"  ItemStyle-HorizontalAlign="Right" />
           <asp:BoundField HeaderText="Average Daily Balance" DataField="AVERAGE" DataFormatString="{0:c}" ItemStyle-HorizontalAlign="Right" />   
           </Columns>
          </asp:GridView>
</asp:Panel>
-->
        
        
  </asp:Content>
  