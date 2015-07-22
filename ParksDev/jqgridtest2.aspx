<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="jqgridtest2.aspx.cs" Inherits="ParksDev.jqgridtest2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>My First Grid</title>

<link rel="stylesheet" type="text/css" media="screen" href="css/ui-lightness/jquery-ui-1.7.3.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/ui.jqgrid.css" />

<style>
html, body {
    margin: 0;
    padding: 0;
    font-size: 75%;
}
.ui-icon-save {
background-position: -96px -112px;
}
</style>

<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="js/grid.common.js" type="text/javascript"></script>
<script src="js/grid.formedit.js" type="text/javascript"></script>
<script src="js/jqDnR.js" type="text/javascript"></script>
<script src="js/jqModal.js" type="text/javascript"></script>
<script type="text/javascript">

    var mydata2 = [
        { id: "12345", Name: "Desktop Computer", Gender: "FedEx" },
        { id: "23456", Name: "Laptop", Gender: "Long text " },
        { id: "34567", Name: "LCD Monitor", Gender: "TNT" },
        { id: "45678", Name: "Speakers", Gender: "ARAMEX" },
        { id: "56789", Name: "Laser Printer", Gender: "FedEx" },
        { id: "67890", Name: "Play Station", Gender: "FedEx" },
        { id: "76543", Name: "Mobile Telephone", Gender: "ARAMEX" },
        { id: "87654", Name: "Server", Gender: "TNT" },
        { id: "98765", Name: "Matrix Printer", Gender: "FedEx" }
        ];

    $(function () {
        $("#list").jqGrid({
            url: 'jqgrid4e.php',
            datatype: 'json',
            mtype: 'GET',
            colNames: ['ID', 'Name', 'Gender'],
            colModel: [
                    { name: 'id', index: 'id', width: 55, editable: true, edittype: 'text' },
                    { name: 'Name', index: 'Name', width: 90, editable: true, edittype: 'text' },
                    { name: 'Gender', index: 'Gender', width: 80, align: 'right', editable: true, edittype: 'text' }
                ],
            pager: '#pager',
            rowNum: 10,
            width: "400",
            rowList: [10, 20, 30],
            //sortname: 'id',
            //sortorder: 'asc',
            loadonce: true,
            viewrecords: true,
            gridview: true,
            jsonReader: {
                page: "page",
                total: "total",
                records: "records",
                root: "d",
                repeatitems: false,
                id: "id"
            },
            caption: 'My first grid',
            onSelectRow: function (id) {
                if (id && id !== this.lastSel) {
                    if (this.lastSel !== undefined) jQuery('#list').restoreRow(this.lastSel);
                    this.lastSel = id;
                }
                jQuery('#list').editRow(id,
                    editparameters = {
                        "keys": true,
                        "oneditfunc": function (id) {
                            //alert(id);
                        },
                        "successfunc": function (response) {
                            var savedrow = $("#list").getGridParam('savedRow'); //shows the JSON obj of the saved row values
                            var r = response;
                            return true;
                        },
                        "url": 'jqgrid4s.php',
                        "extraparam": { param1: "param1", param2: "param2" },
                        "aftersavefunc": function (id, response) {
                            var savedrow = $("#list").getGridParam('savedRow'); //returns nothing
                            var id = id;
                            var responseText = jQuery.jgrid.parse(response.responseText);
                            var r = response;
                            return true;
                        },
                        "errorfunc": function (id, response) {
                            var r = response;
                            return true;
                        },
                        "afterrestorefunc": function (id) {
                            var id = id;
                            return true;
                        },
                        "restoreAfterError": true,
                        "mtype": "POST"
                    });
            },
            gridComplete: function () {
                if (this.x == undefined) {
                    var j = 0;
                    this.x = 1;
                    while (j < mydata2.length) {
                        jQuery("#list").addRowData(mydata2[j].id, mydata2[j]);
                        j++;
                    }
                }
                return true;
            }
        });
        $("#list").jqGrid('navGrid', '#pager',
            { add: true, edit: true, del: true, search: true, refresh: true },
           {//edit
               //recreateForm:true,
               jqModal: false,
               reloadAfterSubmit: true,
               closeOnEscape: true,
               savekey: [true, 13],
               closeAfterEdit: true,
               url: "jqgrid4s.php",
               onclickSubmit: function (params, postdata) {
                   //save edit
                   var p = params;
                   var pt = postdata;
               },
               beforeSubmit: function (postdata, formid) {
                   var p = postdata;
                   var id = formid;
                   var success = true;
                   var message = "continue";
                   return [success, message];
               },
               afterSubmit: function (response, postdata) {
                   var r = response;
                   var p = postdata;
                   var responseText = jQuery.jgrid.parse(response.responseText);
                   var success = true;
                   var message = "continue";
                   return [success, message]
               },
               afterComplete: function (response, postdata, formid) {
                   var responseText = jQuery.jgrid.parse(response.responseText);
                   var r = response;
                   var p = postdata;
                   var f = formid;
               }

           },
{//add
    //recreateForm:true,
    jqModal: false,
    reloadAfterSubmit: false,
    savekey: [true, 13],
    closeOnEscape: true,
    closeAfterAdd: true,
    url: "jqgrid4s.php",
    onclickSubmit: function (params, postdata) {
        //save add
        var p = params;
        var pt = postdata;
    },
    beforeSubmit: function (postdata, formid) {
        var p = postdata;
        var id = formid;
        var success = true;
        var message = "continue";
        return [success, message];
    },
    afterSubmit: function (response, postdata) {
        var r = response;
        var p = postdata;
        var responseText = jQuery.jgrid.parse(response.responseText);
        var success = true;
        var message = "continue";
        return [success, message]
    },
    afterComplete: function (response, postdata, formid) {
        var responseText = jQuery.jgrid.parse(response.responseText);
        var r = response;
        var p = postdata;
        var f = formid;
    }
}
        /*
             
        *editParam = {
        editData:{myparam:function(){return "myval";}},
        reloadAfterSubmit: true,
        editCaption:'Edit Record',
        bSubmit:'Save',
        url:'<%=request.getContextPath()%>/CompanyJqGrid? q=1&action=addData',
        closeAfterEdit:true,
        viewPagerButtons:false
        }*/
    ).jqGrid('navButtonAdd', '#pager',
    {
        caption: "Save",
        buttonicon: "ui-icon-save",
        title: "Save All Records",
        onClickButton: function (x) {
            var x = 1;
            alert("Saving Row");
        },
        position: "first"
    });
        /* $.jgrid = {
        del : {
        caption: "Delete1",
        msg: "Delete selected record(s)123?",
        bSubmit: "Delete2",
        bCancel: "Cancel3"
        }
        }


        parameters = {                    
        edit: {
        addCaption: "Add Record1",
        editCaption: "Edit Record1",
        bSubmit: "Submit",
        bCancel: "Cancel",
        bClose: "Close",
        saveData: "Data has been changed! Save changes?",
        bYes : "Yes",
        bNo : "No",
        bExit : "Cancel"
        },
        editicon: "ui-icon-pencil",
        add: true,
        addicon:"ui-icon-plus",
        addtext:"add text",
        addtitle:"add_title",
        save: true,
        saveicon:"ui-icon-disk",
        cancel: true,
        cancelicon:"ui-icon-cancel",
        addParams : {useFormatter : false},
        editParams : {
        addCaption: "Add Record",
        editCaption: "Edit Record",
        bSubmit: "Submit",
        bCancel: "Cancel",
        bClose: "Close",
        saveData: "Data has been changed! Save changes?",
        bYes : "Yes",
        bNo : "No",
        bExit : "Cancel"
        },
            
        view : {
        caption: "View Record1",
        bClose: "Close"
        }
        }
        *
        *
        *
        */
    });
</script>
</head>
<body>
<table id="list">
<tbody>
<tr>
<td></td>
</tr>
</tbody>
</table>
<div id="pager"></div>
<form name="editForm" style="display:none;"> 
<table>
<tbody>
<tr id="trv_id">
<td>ID</td>
<td id="v_id"></td>
</tr>
<tr id="trv_Name">
<td></td>
<td id="v_Name"><span></span></td>
</tr>
<tr id="trv_Gender">
<td></td>
<td id="v_Gender"><span></span></td>
</tr>
</tbody>
</table>
</form>
</body>
</html>



</asp:Content>
