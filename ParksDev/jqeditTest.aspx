<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="jqeditTest.aspx.cs" Inherits="ParksDev.jqeditTest" %>
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
                    url: "DAL/getTest.ashx",
                    datatype: "json",
                    colNames: ['ID', 'FIRSTNAME', 'LASTNAME', 'SCOREA', 'SCOREB', 'SCOREC'],
                    colModel: [
                                    { name: 'ID', index: 'ID', width: 100, sorttype: 'date', align: 'center', editable: false },
                                    { name: 'FIRSTNAME', index: 'FIRSTNAME', width: 100, align: 'center', editable: true },
                                    { name: 'LASTNAME', index: 'LASTNAME', width: 100, align: 'right', editable: true },
                                    { name: 'SCOREA', index: 'SCOREA', width: 50, align: 'left', editable: true },
                                     { name: 'SCOREB', index: 'SCOREB', width: 50, align: 'left', editable: true },
                                      { name: 'SCOREC', index: 'SCOREC', width: 50, align: 'left', editable: true },

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
                    editurl: "DAL/postTest.ashx"


                    //end
                });
                //$("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/getTest.ashx", datatype: "json", page: 1 }).trigger("reloadGrid");
                $("#<%=jQGridDemo.ClientID%>").jqGrid('navGrid', '#jQGPager', { edit: true, add: true , del: true, search: false, refresh: false },
                                                                              { jqModal: true,
                                                                                closeAfterEdit: true,
                                                                                reloadAfterSubmit: true,
                                                                                afterSubmit: function (response, postdata) {
                                                                                      $(this).jqGrid("setGridParam", { datatype: 'json' });
                                                                                      return [true, response.responseText];} 
                                                                              },
                                                                              { jqModal: true,
                                                                                  closeAfterEdit: true,
                                                                                  reloadAfterSubmit: true,
                                                                                  afterSubmit: function (response, postdata) {
                                                                                      $(this).jqGrid("setGridParam", { datatype: 'json' });
                                                                                      return [true, response.responseText];
                                                                                  }
                                                                              },
                                                                              { jqModal: true,
                                                                                  closeAfterEdit: true,
                                                                                  reloadAfterSubmit: true,
                                                                                  afterSubmit: function (response, postdata) {
                                                                                      $(this).jqGrid("setGridParam", { datatype: 'json' });
                                                                                      return [true, response.responseText];
                                                                                  }
                                                                              }
                                                       ); // end of jqGrid - navGrid
                $("#<%=jQGridDemo.ClientID%>").jqGrid('navButtonAdd', "#jQGPager", { caption: "Reload", title: "Reload Data", buttonicon: "ui-icon-refresh",
                 onClickButton: function () { $("#<%=jQGridDemo.ClientID%>").jqGrid('setGridParam', { url: "DAL/getTest.ashx", datatype: "json", page: 1 }).trigger("reloadGrid"); }
               });

            } //end function
        }
    );

</script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <h1>Monthly Interest</h1><br />
            <!--Master-->
          <div id="jqGridDiv"> 
            <asp:Table ID="jQGridDemo" runat="server"></asp:Table>      
            <div id="jQGPager"></div>
         </div>
         <br />
<%--            <!--Detail-->
         <div id="dialog-detail">
            <asp:Table ID="jqGridInterestDetail" runat="server"></asp:Table>
            <div id="jqGInterestDetailPager"></div>                
         </div>--%>
    </asp:Content>