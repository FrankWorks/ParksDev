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
                    colNames: ['ATP_CODE', 'AGENCY', 'AMOUNT POSTED', 'COLLECTED DEBT SERVICE', 'AVERAGE DAILY BALANCE', 'ABA_CODE', 'UNIT_CODE'],
                    colModel: [
                                    { name: 'ATP_CODE', index: 'ATP_CODE', width: 100, hidden: true },
                                    { name: 'AGENCY', index: 'AGENCY', width: 200 },
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
                                    { name: 'ABA_CODE', index: 'ABA_CODE', hidden: true, editable: true, editrules: { edithidden: false }, hidedlg: true },
                                    { name: 'Unit_Code', index: 'Unit_Code', width: 100, hidden: false, editable: true, editrules: { edithidden: false }, hidedlg: true }

                              ],
                    //rowNum: 18,
                    rowNum: 100,
                    //                    rowList: [15, 20, 40, 60],
                    width: gridWidth,
                    height: '70%',
                    pager: '#jqGInterestDetailPager',
                    viewrecords: true,
                    //multiSort: true,
                    //sortname: 'Unit_Code',
                    //sortorder: "asc",
                    loadonce: true,
                    caption: "Agency Distributions",
                    footerrow: true,
                    loadComplete: function () {
                        var $self = $(this),
                            sum = $self.jqGrid("getCol", "BAS", true, "sum");

                        $self.jqGrid("footerData", "set", { AGENCY: "Total:", BAS: sum });
                    },
                    editurl: "DAL/BADedit.ashx"
                });
                $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('navGrid', '#jqGInterestDetailPager', { edit: true, add: false, del: false, search: false, refresh: false, excel:true },
                                                                                                        { jqModal: true,
                                                                                                            closeAfterEdit: true,
                                                                                                            reloadAfterSubmit: true,
                                                                                                            afterSubmit: function (response, postdata) {
                                                                                                                $(this).jqGrid("setGridParam", { datatype: 'json' });
                                                                                                                return [true, response.responseText];
                                                                                                            }, width: 800
                                                                                                        }
                                                                                                    );
                // Below is custom Button on 8/10/2015 Frank Kim


  //              $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('navButtonAdd', '#jqGInterestDetailPager',
  //               {
  //                   caption: "", buttonicon: "ui-icon-calculator", title: "Export",
  //                   onClickButton: function () {
  //                       exportGrid();
  //                       //ExportDataToExcel("#<%=jqGridInterestDetail.ClientID%>")
  //                       <%--                         var renderstring = "";
  //                       var name = 'Total';
  //                       var value = '10000';
  //                                  // $("#<%=jqGridInterestDetail.ClientID%>").jqGrid('GridUnload');
  //                       alert("The GRAND Total Amount:  " + value);
  //                       $('.ui-icon-calculator').remove();
  //                       //renderstring += '<div style="position: relative; margin: 4px; overflow: hidden;">' + name + ': ' + value + '</div>'; --%>
  //                       $('.ui-icon-calculator').remove();
  //                  }

  //              });

                function exportGrid() {

                    mya = $("#<%=jqGridInterestDetail.ClientID%>").getDataIDs(); // Get All IDs

                    var data = $("#<%=jqGridInterestDetail.ClientID%>").getRowData(mya[0]); // Get First row to get the

                    // labels

                    var colNames = new Array();

                    var ii = 0;

                    for (var i in data) {

                        colNames[ii++] = i;

                    } // capture col names

                    var html = "<html><head>"

                            + "<style script=&quot;css/text&quot;>"

                            + "table.tableList_1 th {border:1px solid black; text-align:center; "

                            + "vertical-align: middle; padding:5px;}"

                            + "table.tableList_1 td {border:1px solid black; text-align: left; vertical-align: top; padding:5px;}"

                            + "</style>"

                            + "</head>"

                            + "<body style=&quot;page:land;&quot;>";

                    for (var k = 0; k < colNames.length; k++) {

                        html = html + "<th>" + colNames[k] + "</th>";

                    }

                    html = html + "</tr>"; // Output header with end of line

                    for (i = 0; i < mya.length; i++) {

                        html = html + "<tr>";

                        data = $("#<%=jqGridInterestDetail.ClientID%>").getRowData(mya[i]); // get each row

                        for (var j = 0; j < colNames.length; j++) {

                            html = html + "<td>" + data[colNames[j]] + "</td>"; // output each Row as

                            // tab delimited

                        }

                        html = html + "</tr>"; // output each row with end of line

                    }

                    html = html + "</table></body></html>"; // end of line at the end

                    alert(html);

                    html = html.replace(/'/g, '&apos;');

                    //  var form = "<form name='pdfexportform' action='generategrid' method='post'>";

                    //  form = form + "<input type='hidden' name='pdfBuffer' value='" + html + "'>";

                    //  form = form + "</form><script>document.pdfexportform.submit();</sc"

                    //      + "ript>";

                    //  OpenWindow = window.open('', '');

                    //  OpenWindow.document.write(form);

                    //  OpenWindow.document.close();

                }
                function ExportDataToExcel(tableCtrl) {
                    ExportJQGridDataToExcel(tableCtrl,"sample.xlsx");
                }
 
                function ExportJQGridDataToExcel(tableCtrl, excelFilename) {
                    var allJQGridData = $(tableCtrl).jqGrid('getGridParam', 'data');
                    // var allJQGridData = $(tableCtrl).jqGrid('getRowData');
                    var jqgridRowIDs = $(tableCtrl).getDataIDs(); // Fetch the RowIDs for this grid
                    var headerData = $(tableCtrl).getRowData(jqgridRowIDs[0]);
                }

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
