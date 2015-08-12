<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Payments.aspx.cs" Inherits="ParksDev.Payments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 368px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

            function EndRequestHandler(sender, args) {
                $('.mydatepickerclasser').datepicker({ dateFormat: 'mm-dd-yy', changeYear: true , changeMonth: true});
            }

        });
        function saveddiao() {
            $(function () {
                $("#dialog").dialog({
                    modal: true,
                    width: 'auto',
                    resizable: false,
                    draggable: false,
                    buttons: { 'OK': function () { $(this).dialog('close'); }
                    }
                }).dialog("open");
            })
        }
        function faileddiao() {
            $(function () {
                $("#dialog2").dialog({
                    modal: true,
                    width: 'auto',
                    resizable: false,
                    draggable: false,
                    buttons: { 'OK': function () { $(this).dialog('close'); }
                    }
                }).dialog("open");
            })
        }
        function savededit() {
            $(function () {
                $("#dialog3").dialog({
                    modal: true,
                    width: 'auto',
                    resizable: false,
                    draggable: false,
                    buttons: { 'OK': function () { $(this).dialog('close'); }
                    }
                }).dialog("open");
            })
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page_head">
        Payments (Adjustments, Transfers)
    </h1>
    <br />

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>


    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
<%--        buttons begin--%>
<asp:TextBox ID="grantscontroler" runat="server" Visible="false" />
    <asp:TextBox ID="TransCode1" runat="server" Visible="false" />
    <asp:TextBox ID="yearlabel" runat="server" Visible="false" />
    <asp:TextBox ID="fisYear" runat="server" Visible="false" />
    <asp:TextBox ID="agecodeshow" runat="server" Visible="false" /><br />
    <asp:TextBox ID="yegRemainer" runat="server" Visible="false" />
    <asp:TextBox ID="ms1" runat="server" Visible="false" />
    <asp:TextBox ID="ms2" runat="server" Visible="false" />
    <asp:TextBox ID="showrowindex" runat="server" Visible="false" />
    <asp:Button ID="button2" runat="server" Text="First" Width="75" OnClick="buttonClickFirst" />
    <asp:Button ID="button3" runat="server" Text="Previous" Width="75" OnClick="buttonPrev" />
    <asp:Button ID="button1" runat="server" Text="Next" Width="75" OnClick="buttonClickNext" />
    <asp:Button ID="button4" runat="server" Text="Last" Width="75" OnClick="buttonlast" />
    <asp:Button ID="button5" runat="server" Text="Edit" Width="75" OnClick="buttonedit" />
    <asp:Button ID="buttonnew" runat="server" Text="New" Width="75" OnClick="buttonnewclicked" />
        <asp:Button ID="javatest" runat="server" Text="javatest" Width="75" OnClick="javatester" Visible="false"/>

    <br />
    <br />
<%--    end of buttons--%>
            <asp:TextBox ID="rowLimitLab" runat="server" Visible="false"></asp:TextBox><asp:TextBox ID="rowIndexLab" runat="server" Visible="false"/>

            <asp:Panel ID="newPanel" runat="server" BorderColor="Red" BorderStyle="Ridge" Visible="false"
                Style="z-index: 2; position: relative;">
                NEW:

                <table width="100%" align="center" border="0" >
                    <tr valign="top">
                        <td width="431">
                            <table border="0" width="430">
                                <tr>
                                    <td align="left" width="70px">
                                        TC:
                                    </td>
                                    <td width="90px">                                        
                                        <asp:DropDownList runat="server" ID="TC_Dropdown">
                                        <asp:ListItem selected="False" Value="GAX" Text="GAX">GAX</asp:ListItem>
                                        <asp:ListItem selected="False" Value="PFY" Text="PFY">PFY</asp:ListItem>
                                        <asp:ListItem selected="False" Value="ITARV" Text="ITARV">ITARV</asp:ListItem>
                                        <asp:ListItem selected="False" Value="JV" Text="JV">JV</asp:ListItem>
                                        <asp:ListItem selected="False" Value="Misc" Text="Misc">Misc</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        TD:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox2" runat="server" Text="OS" />
                                    </td>
                                </tr>

                                <tr>
                                    <td align="left">
                                        Document #
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox4" runat="server" />
                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                        Payment Request No:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="newpayrequestno" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>

                                <tr>
                                    <td align="left">
                                        Agency:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="newAgencySource"
                                           autopostback="true" DataTextField="AGENCY" DataValueField="AGE_CODE" OnSelectedIndexChanged="newagencychange"    >
                                        </asp:DropDownList>

                                        <asp:RequiredFieldValidator ID="rfvLanguage" runat="server" EnableClientScript="false" ControlToValidate="DropDownList2" InitialValue="0" TabIndex="1" Text="*" ErrorMessage="<b>Please Select Language</b>" Display="None"></asp:RequiredFieldValidator>
                        <%--                fixes dropdown autopostback in chrome--%>
                                        <asp:SqlDataSource ID="newAgencySource" runat="server" DataSourceMode="DataSet" ConnectionString="<%$ConnectionStrings:FoxProDevConnectionString%>"
                                            SelectCommand="Select * from AGENCIES order by AGENCY"></asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                       Payee:
                                    </td>
                                    <td>
                                        <b>
                                           <%-- <asp:TextBox ID="ALabel" runat="server" ForeColor="Purple" /></b>--%>
                                        <asp:DropDownList ID="newpayee" runat="server" DataSourceID="SqlDataSource1"
                                            DataTextField="AGENCY" DataValueField="AGE_CODE">
                                        </asp:DropDownList><%-- <asp:CheckBox ID="CheckBox1" runat="server" Text="Filter" AutoPostBack="true" ToolTip="Filter Results"  OnCheckedChanged="buttonClickFirst"  />
                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" DataSourceMode="DataSet" ConnectionString="<%$ConnectionStrings:FoxProDevConnectionString%>"
                                            SelectCommand="Select * from AGENCIES order by AGENCY"></asp:SqlDataSource> //commented out because its same list as above --%>
   
<a href="http://win-b7o3hk7ooqq.parks.co.la.ca.us/hb3.kendo.mvc.web/payee/",
                                                       onclick="window.open(this.href,'mywindow','menubar=0,resizable=1, height=' + screen.height - 50 + ',width= ' + screen.width - 50);return false;">Create</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Transaction Date:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox6" runat="server" CssClass="mydatepickerclasser" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Ecaps Processed Date:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox7" runat="server" CssClass="mydatepickerclasser" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table width="100%" border="0">
                             <tr>
                                     <td align="left">
                                       Unit:<asp:TextBox ID="NewUnit" runat="server"  />
                                    </td>
                                    <td align="left">
                                      Fund: <asp:TextBox ID="Label4" runat="server" text="HB3"  />
                                    </td>
                                    </tr>
                                <tr>
                                    <td width="200">
                                        <asp:DropDownList ID="DropDownList3" runat="server" OnSelectedIndexChanged="DisableGrants" AutoPostBack="true">
                                            <asp:ListItem Selected="True" Value="1" Text="Payment">Payment</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="2" Text="Transfer OUT">Transfer OUT</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="3" Text="Transfer IN">Transfer IN</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="4" Text="Adjustment OUT">Adjustment OUT</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="5" Text="Adjustment IN">Adjustment IN</asp:ListItem>
                                        </asp:DropDownList> of:
                                    </td>
                                    <td>
                                       <asp:TextBox ID="TextBox5" runat="server"  Style="text-align: right" readonly="true"/>
                                    </td>
                                    </tr>
                                    <tr>
                                    <td align="left">
                                        Dept Object:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox3" runat="server"  />
                                    </td>
                                </tr>
                                   <tr>
                                    <td align="left">
                                        Sub Fund:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox80" runat="server" />
                                    </td>
                                    </tr>
                                    <tr>
                                    <td align="left" >
                                        Location Code:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="newLocCode" runat="server" />
                                    </td>
                                    </tr>
                                  <tr>
                                    <td align="left">
                                        Supervisory District:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="newsupdist" runat="server" /> <asp:TextBox ID="textboxt" runat="server" visible="false"/>
                                    </td>
                                </tr>
                                                                    <tr>
                                    <td>Entered Date: <asp:Label ID="NewEnteredDate" runat="server"  /></td>
                                    </tr>
                                    <tr>
                                    <td><asp:Button ID="eg" runat="server" Text="Enter Grants" OnClick="buttongrantsclicked" /></td>
                                    </tr>

                                
                                <%--<tr>
<td>Average Daily Balance of:</td>
<td><asp:TextBox ID="TextBox9" runat="server" style="text-align:right"/></td>
</tr>
<tr>
<td>Previously Restricted Amount:</td>
<td><asp:TextBox ID="TextBox10" runat="server" style="text-align:right"/></td>
</tr>
<tr>
<td>Rate of Restriction:</td>
<td><asp:TextBox ID="TextBox11" runat="server" style="text-align:right"/></td>
</tr>
<tr>
<td>FY Collected Benefits Assessment:</td>
<td><asp:TextBox ID="TextBox12" runat="server" style="text-align:right"/></td>
</tr>
<tr>
<td>Current FY Restriction:</td>
<td><asp:TextBox ID="TextBox13" runat="server" style="text-align:right"/></td>
</tr>
<tr>
<td>Total Restriction Amount:</td>
<td><asp:TextBox ID="TextBox14" runat="server" style="text-align:right"/></td>
</tr>
<tr>
<td>Total Fund;</td>
<td><asp:TextBox ID="TextBox15" runat="server" style="text-align:right"/></td>
</tr>
<tr>
<td>Unrestricted Fund:</td>
<td><asp:TextBox ID="TextBox16" runat="server" style="text-align:right" /></td>
</tr>--%>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" >
                            Comments:<br /><asp:TextBox ID="newComments" runat="server" Height="40" Width="400" Wrap="true"></asp:TextBox>
                        </td>
                        <td>
                                            
                        </td>
                        
                    </tr>
                    <tr>
                    <td><asp:Button ID="newsave" runat="server" Text="Save" OnClick="newsaveclick" />
                <asp:Button ID="newcancel" runat="server" Text="Cancel" OnClick="buttonnewcancel" /></td></tr>
                </table>
            </asp:Panel>
            <%--end of new panel--%>

            <asp:Panel ID="viewPanel" runat="server" style="z-index: 1; position:relative;" visible="true">
                <table width="100%" align="center" border="0" style="border: red;">
                    <tr valign="top">
                        <td width="500">
                            <table border="0" width="499" style="border:blue;">
                                <tr><td colspan="4">
                                <table>
                                    <td align="left" width="135px">
                                        TC:
                                    </td>
                                    <td width="120px" style="background-color:#c6c6c6">
                                        <asp:Label ID="TCLabel" runat="server" style="background-color:#c6c6c6;" />
                                    </td>
                                    <td align="left" width="20px">
                                        TD:
                                    </td>
                                    <td style="background-color:#c6c6c6" width="120px" >
                                        <asp:Label ID="TDLabel" runat="server" style="background-color:#c6c6c6;"  />
                                    </td>
                                </table>
                                </td>
                                </tr>

                                <tr>
                                    <td align="left">
                                        Document #
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="RLabel" runat="server" style="background-color:#c6c6c6;"  />
                                    </td>
                                </tr>
                                 <tr>
                                    <td align="left">
                                        Payment Request No:
                                    </td>
                                    <td  style="background-color:#c6c6c6">
                                        <asp:Label ID="viewPaymentReq" runat="server" Style="background-color:#c6c6c6;"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Dept Obj:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="MOLabel" runat="server" style="background-color:#c6c6c6;"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Agency:
                                    </td>
                                    <td>
                                        <b>
                                           <%-- <asp:TextBox ID="ALabel" runat="server" ForeColor="Purple" /></b>--%>
                                        <asp:DropDownList ID="AgencyViewScrolldown" runat="server" DataSourceID="SqlDataSource1" 
                                            DataTextField="AGENCY" DataValueField="AGE_CODE" BackColor="#c6c6c6">
                                        </asp:DropDownList> <asp:CheckBox ID="ageFilter" runat="server" Text="Filter" AutoPostBack="true" ToolTip="Filter Results"  OnCheckedChanged="buttonClickFirst"  />
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" DataSourceMode="DataSet" ConnectionString="<%$ConnectionStrings:FoxProDevConnectionString%>"
                                            SelectCommand="Select * from Payees order by AGENCY"></asp:SqlDataSource>
                                    </td>
                                </tr>
                                 <tr>
                                    <td align="left">
                                       Payee:
                                    </td>
                                    <td>
                                        <b>
                                           <%-- <asp:TextBox ID="ALabel" runat="server" ForeColor="Purple" /></b>--%>
                                        <asp:DropDownList ID="payeeViewScrollDown" runat="server" DataSourceID="SqlDataSource1"
                                            DataTextField="AGENCY" DataValueField="AGE_CODE" BackColor="#c6c6c6">
                                        </asp:DropDownList><%-- <asp:CheckBox ID="CheckBox1" runat="server" Text="Filter" AutoPostBack="true" ToolTip="Filter Results"  OnCheckedChanged="buttonClickFirst"  />
                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" DataSourceMode="DataSet" ConnectionString="<%$ConnectionStrings:FoxProDevConnectionString%>"
                                            SelectCommand="Select * from AGENCIES order by AGENCY"></asp:SqlDataSource> //commented out because its same list as above --%>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Transaction Date:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="TranDate" runat="server" style="background-color:#c6c6c6;"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Ecaps Processed Date:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="ProDate" runat="server"  style="background-color:#c6c6c6;" />
                                    </td>
                                </tr> 
                                   <tr>
                                   <td colspan="2">
                                   <table>
                                   <tr>
                                    <td align="left" width="132px">
                                        Sub-Fund:
                                    </td>
                                    <td>
                                        <asp:Label ID="SUBFUND" runat="server" style="background-color:#c6c6c6;"  />
                                    </td>
                                    <td align="left" width="132px" style="padding-left:50px">
                                       Location Code:
                                    </td>
                                    <td style="background-color:#c6c6c6;">
                                        <asp:Label ID="LOCC" runat="server" style="background-color:#c6c6c6;"  />
                                    </td>
                                    </tr>
                                    </table>
                                    </td>
                                </tr>
                                   <tr>
                                    <td align="left">
                                       Supervisory District:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="SUPDIST" runat="server" style="background-color:#c6c6c6;"  />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table width="100%" border="0">
                                <tr><td colspan="3">
                                <table width="100%" border="0">
                                    <tr>
                                       <td align="left" colspan="1" width="20px">
                                       Unit:
                                    </td>
                                    <td style="background-color:#c6c6c6;width:30px;">
                                        <asp:Label ID="vunitcode" runat="server" style="background-color:#c6c6c6;"  />
                                    </td>
                                    <td align="left" width="24px">
                                      Fund:
                                    </td>
                                    <td style="background-color:#c6c6c6;width:98px;">
                                        <asp:Label ID="Label1" runat="server" style="background-color:#c6c6c6;" text="HB3"  />
                                   </td>
                                  </tr>
                                </table>
                                    </td>
                                    </tr>
                                <tr>
                                    <td width="200">
                                        <asp:DropDownList ID="tranTypeDropdownView" runat="server" BackColor="#c6c6c6">
                                            <asp:ListItem Selected="True" Value="1" Text="Payment">Payment</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="2" Text="Transfer OUT">Transfer OUT</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="3" Text="Transfer IN">Transfer IN</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="4" Text="Adjustment OUT">Adjustment OUT</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="5" Text="Adjustment IN">Adjustment IN</asp:ListItem>
                                        </asp:DropDownList> of:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="PayLabel" runat="server" Style="text-align: right; background-color:#c6c6c6;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Average Daily Balance of:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="AVGLabel" runat="server" Style="text-align: right; background-color:#c6c6c6;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Previously Restricted Amount:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="PRLabel" runat="server" Style="text-align: right; background-color:#c6c6c6;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Rate of Restriction:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="ResLabel" runat="server" Style="text-align: right; background-color:#c6c6c6;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        FY Collected Benefits Assessment:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="fycollected" runat="server" Style="text-align: right; background-color:#c6c6c6;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Current FY Restriction:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="currentFylabel" runat="server" Style="text-align: right; background-color:#c6c6c6;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Total Restriction Amount:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="totalResAmount" runat="server" Style="text-align: right; background-color:#c6c6c6;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Total Fund:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="TotalLabel" runat="server" Style="text-align: right; background-color:#c6c6c6;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Unrestricted Fund:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="URLabel" runat="server" Style="text-align: right; background-color:#c6c6c6;" />
                                    </td>
                                </tr>
                                                                <tr>
                                    <td>
                                        User:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="viewUser" runat="server" Style="text-align: right; background-color:#c6c6c6;" />
                                    </td>
                                </tr>
                                   <tr>
                                    <td>
                                        Entered Date:
                                    </td>
                                    <td style="background-color:#c6c6c6">
                                        <asp:Label ID="viewDate" runat="server" Style="text-align: right; background-color: #c6c6c6;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Comments:<br /><asp:TextBox ID="viewComments" runat="server" Height="30" Width="600" Wrap="true" TextMode="MultiLine"  Rows="10"
                                ReadOnly="true"></asp:TextBox><br /><br />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <%--end of view panel--%>

            <asp:Panel ID="editPanel" runat="server" BorderColor="Red" BorderStyle="Dashed" Visible="false"
                Style="z-index: 1; position: relative;">
                EDIT:<br /> <asp:Button ID="grantstester00z" runat="server" OnClick="checkgrant" Text="z"  Visible="false" />
           <%--<asp:Label id="reftest" runat="server"></asp:Label>--%>
                 <table width="100%" align="center" border="0">
                    <tr valign="top">
                        <td width="431">
                            <table border="0" width="430" >
                                <tr>
                                    <td align="left" width="70px">
                                        TC:
                                    </td>
                                    <td width="90px">
                                        <asp:TextBox ID="editTC" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        TD:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editTD" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                       Dept Object:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editMO" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Document #
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editREF" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Agency:
                                    </td>
                                    <td>
                                        <b>
                                            <asp:DropDownList ID="editAGENCY" runat="server" DataSourceID="SqlDataSource1" AutoPostBack="true"
                                            DataTextField="AGENCY" DataValueField="AGE_CODE" OnSelectedIndexChanged="editAgencyChange">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td align="left">
                                       Payee:
                                    </td>
                                    <td>
                                        <b>
                                           <%-- <asp:TextBox ID="ALabel" runat="server" ForeColor="Purple" /></b>--%>
                                        <asp:DropDownList ID="editpayeedropdown" runat="server" DataSourceID="SqlDataSource1"
                                            DataTextField="AGENCY" DataValueField="AGE_CODE">
                                        </asp:DropDownList><%-- <asp:CheckBox ID="CheckBox1" runat="server" Text="Filter" AutoPostBack="true" ToolTip="Filter Results"  OnCheckedChanged="buttonClickFirst"  />
                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" DataSourceMode="DataSet" ConnectionString="<%$ConnectionStrings:FoxProDevConnectionString%>"
                                            SelectCommand="Select * from AGENCIES order by AGENCY"></asp:SqlDataSource> //commented out because its same list as above --%>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Transfer Date:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editTRANSFERD" runat="server" CssClass="mydatepickerclasser" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Ecaps Processed Date:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editPROCESSED" runat="server" CssClass="mydatepickerclasser" />
                                    </td>
                                </tr>
                                 <tr>
                                    <td align="left">
                                        Sub Fund:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editSubfund" runat="server" />
                                    </td>
                                </tr>
                                 <tr>
                                    <td align="left">
                                        Location Code:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editloccode" runat="server" />
                                    </td>
                                </tr>
                                                                <tr>
                                    <td align="left">
                                        Supervisory District:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editsupdist" runat="server" />
                                    </td>
                                </tr>

                            </table>
                        </td>
                        <td>
                            <table width="100%" border="0">
                            <tr>
                                    <td>
                                        Payment Request No:
                                    </td>
                                    <td >
                                        <asp:TextBox ID="editpayreqnum" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">
                                        <asp:DropDownList ID="DropDownList1" runat="server">
                                            <asp:ListItem Selected="True" Value="1" Text="Payment">Payment</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="2" Text="Transfer OUT">Transfer OUT</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="3" Text="Transfer IN">Transfer IN</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="4" Text="Adjustment OUT">Adjustment OUT</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="5" Text="Adjustment IN">Adjustment IN</asp:ListItem>
                                        </asp:DropDownList>
                                        of:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editPAY" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Average Daily Balance of:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editAVG" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Previously Restricted Amount:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editPRA" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Rate of Restriction:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editRR" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        FY Collected Benefits Assessment:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editFCBA" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Current FY Restriction:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editCFR" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Total Restriction Amount:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editTRA" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Total Fund:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editTF" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Unrestricted Fund:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editUF" runat="server" Style="text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                <td><asp:Button ID="editgrants" Text="Edit Grants" OnClick="editgrantcmd" runat="server" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="style2">
                            Comments:<br /><asp:TextBox ID="editComments" runat="server" Height="40" Width="400" Wrap="true"></asp:TextBox>
                        </td>

                    </tr>
                    <tr>
                    <td>      <asp:Button ID="editsave" runat="server" Text="Save" OnClick="editsaveclick" /><asp:TextBox ID="testnumber" runat="server" Text="1" Visible="false" /> <asp:TextBox ID="grantcontollertest" runat="server" ForeColor="Red" Text="grantcontrol"  Visible="false" />
                <asp:Button ID="editcancel" runat="server" Text="Cancel" OnClick="buttoneditcancel" /><asp:Label id="Lb1" runat="server" /><asp:Label id="Label2" runat="server" /><asp:Label id="Label3" runat="server" /><asp:Label id="Label5" runat="server" /><asp:Label id="Label6" runat="server" /><asp:Label id="Label7" runat="server" /><asp:Label id="Label8" runat="server" /><asp:Label id="Label9" runat="server" />
                    </td></tr>
                </table>
            </asp:Panel>
            <%--end of edit panel--%>

            <asp:Panel ID="grantsEntry1" runat="server" Style="z-index: 1; position: relative;" visible="false">
            
            <table width="100%">
            <tr>
            <td>Grant No.</td><td width="30px">From</td><td width="30px">To</td><td>Amount</td><td width="60px">Location Code</td><td>Sup District</td><td>Obj Code</td><td>Extra Ordinary</td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">1. <asp:TextBox ID="gn1" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf1" runat="server"  Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt1" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga1" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc1" runat="server"  /></td><td><asp:TextBox ID="gsd1" runat="server" /></td><td><asp:TextBox ID="goc1" runat="server" /></td><td><asp:CheckBox ID="geo1" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">2. <asp:TextBox ID="gn2" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf2" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt2" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga2" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc2" runat="server"  /></td><td><asp:TextBox ID="gsd2" runat="server" /></td><td><asp:TextBox ID="goc2" runat="server" /></td><td><asp:CheckBox ID="geo2" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">3. <asp:TextBox ID="gn3" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf3" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt3" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga3" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc3" runat="server"  /></td><td><asp:TextBox ID="gsd3" runat="server" /></td><td><asp:TextBox ID="goc3" runat="server" /></td><td><asp:CheckBox ID="geo3" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">4. <asp:TextBox ID="gn4" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf4" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt4" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga4" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc4" runat="server"  /></td><td><asp:TextBox ID="gsd4" runat="server" /></td><td><asp:TextBox ID="goc4" runat="server" /></td><td><asp:CheckBox ID="geo4" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">5. <asp:TextBox ID="gn5" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf5" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt5" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga5" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc5" runat="server"  /></td><td><asp:TextBox ID="gsd5" runat="server" /></td><td><asp:TextBox ID="goc5" runat="server" /></td><td><asp:CheckBox ID="geo5" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">6. <asp:TextBox ID="gn6" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf6" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt6" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga6" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc6" runat="server"  /></td><td><asp:TextBox ID="gsd6" runat="server" /></td><td><asp:TextBox ID="goc6" runat="server" /></td><td><asp:CheckBox ID="geo6" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">7. <asp:TextBox ID="gn7" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf7" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt7" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga7" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc7" runat="server"  /></td><td><asp:TextBox ID="gsd7" runat="server" /></td><td><asp:TextBox ID="goc7" runat="server" /></td><td><asp:CheckBox ID="geo7" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">8. <asp:TextBox ID="gn8" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf8" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt8" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga8" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc8" runat="server"  /></td><td><asp:TextBox ID="gsd8" runat="server" /></td><td><asp:TextBox ID="goc8" runat="server" /></td><td><asp:CheckBox ID="geo8" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">9. <asp:TextBox ID="gn9" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf9" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt9" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga9" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc9" runat="server"  /></td><td><asp:TextBox ID="gsd9" runat="server" /></td><td><asp:TextBox ID="goc9" runat="server" /></td><td><asp:CheckBox ID="geo9" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">10.<asp:TextBox ID="gn10" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf10" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt10" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga10" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc10" runat="server"  /></td><td><asp:TextBox ID="gsd10" runat="server" /></td><td><asp:TextBox ID="goc10" runat="server" /></td><td><asp:CheckBox ID="geo10" runat="server" /></td>
            </tr>
            <tr><td style="white-space:nowrap;" colspan="4"> <asp:Button ID="grantsdone1" runat="server" text="Hide" OnClick="grantsdone1click" /><asp:Button ID="grantsCancel1" runat="server" Text="Cancel" OnClick="grantscancel" /><asp:Button ID="next1" runat="server" Text="Next" OnClick="next1click" /></td></tr>
            </table>

            </asp:Panel>
            <asp:Panel ID="grantsEntr2" runat="server" Style="z-index: 1; position: relative;" visible="false">
            
            <table width="100%">
            <tr>
            <td>Grant No.</td><td width="30px">From</td><td width="30px">To</td><td>Amount</td><td>Location Code</td><td>Sup District</td><td>Obj Code</td><td>Extra Ordinary</td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">11.<asp:TextBox ID="gn11" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf11" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt11" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga11" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc11" runat="server"  /></td><td><asp:TextBox ID="gsd11" runat="server" /></td><td><asp:TextBox ID="goc11" runat="server" /></td><td><asp:CheckBox ID="geo11" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">12.<asp:TextBox ID="gn12" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf12" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt12" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga12" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc12" runat="server"  /></td><td><asp:TextBox ID="gsd12" runat="server" /></td><td><asp:TextBox ID="goc12" runat="server" /></td><td><asp:CheckBox ID="geo12" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">13.<asp:TextBox ID="gn13" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf13" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt13" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga13" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc13" runat="server"  /></td><td><asp:TextBox ID="gsd13" runat="server" /></td><td><asp:TextBox ID="goc13" runat="server" /></td><td><asp:CheckBox ID="geo13" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">14.<asp:TextBox ID="gn14" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf14" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt14" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga14" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc14" runat="server"  /></td><td><asp:TextBox ID="gsd14" runat="server" /></td><td><asp:TextBox ID="goc14" runat="server" /></td><td><asp:CheckBox ID="geo14" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">15.<asp:TextBox ID="gn15" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf15" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt15" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga15" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc15" runat="server"  /></td><td><asp:TextBox ID="gsd15" runat="server" /></td><td><asp:TextBox ID="goc15" runat="server" /></td><td><asp:CheckBox ID="geo15" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">16.<asp:TextBox ID="gn16" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf16" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt16" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga16" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc16" runat="server"  /></td><td><asp:TextBox ID="gsd16" runat="server" /></td><td><asp:TextBox ID="goc16" runat="server" /></td><td><asp:CheckBox ID="geo16" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">17.<asp:TextBox ID="gn17" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf17" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt17" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga17" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc17" runat="server"  /></td><td><asp:TextBox ID="gsd17" runat="server" /></td><td><asp:TextBox ID="goc17" runat="server" /></td><td><asp:CheckBox ID="geo17" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">18.<asp:TextBox ID="gn18" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf18" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt18" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga18" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc18" runat="server"  /></td><td><asp:TextBox ID="gsd18" runat="server" /></td><td><asp:TextBox ID="goc18" runat="server" /></td><td><asp:CheckBox ID="geo18" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">19.<asp:TextBox ID="gn19" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf19" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt19" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga19" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc19" runat="server"  /></td><td><asp:TextBox ID="gsd19" runat="server" /></td><td><asp:TextBox ID="goc19" runat="server" /></td><td><asp:CheckBox ID="geo19" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">20.<asp:TextBox ID="gn20" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf20" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt20" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga20" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc20" runat="server"  /></td><td><asp:TextBox ID="gsd20" runat="server" /></td><td><asp:TextBox ID="goc20" runat="server" /></td><td><asp:CheckBox ID="geo20" runat="server" /></td>
            </tr>
            <tr><td style="white-space:nowrap;" colspan="4"><asp:Button ID="grantsdone2" runat="server" text="Hide" OnClick="grantsdone1click" /><asp:Button ID="grantsCancel2" runat="server" Text="Cancel" OnClick="grantscancel" /><asp:Button ID="prev2" runat="server" Text="Previous" OnClick="prev2click" /><asp:Button ID="next2" runat="server" Text="Next" OnClick="next2click"/></td></tr>
            </table>

            </asp:Panel>
            <asp:Panel ID="grantsEntr3" runat="server" Style="z-index: 1; position: relative;" visible="false">
            
            <table width="100%">
            <tr>
            <td style="width:auto">Grant No.</td><td width="30px">From</td><td width="30px">To</td><td>Amount</td><td>Location Code</td><td>Sup District</td><td>Obj Code</td><td>Extra Ordinary</td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">21.<asp:TextBox ID="gn21" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf21" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt21" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga21" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc21" runat="server"  /></td><td><asp:TextBox ID="gsd21" runat="server" /></td><td><asp:TextBox ID="goc21" runat="server" /></td><td><asp:CheckBox ID="geo21" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">22.<asp:TextBox ID="gn22" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf22" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt22" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga22" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc22" runat="server"  /></td><td><asp:TextBox ID="gsd22" runat="server" /></td><td><asp:TextBox ID="goc22" runat="server" /></td><td><asp:CheckBox ID="geo22" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">23.<asp:TextBox ID="gn23" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf23" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt23" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga23" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc23" runat="server"  /></td><td><asp:TextBox ID="gsd23" runat="server" /></td><td><asp:TextBox ID="goc23" runat="server" /></td><td><asp:CheckBox ID="geo23" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">24.<asp:TextBox ID="gn24" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf24" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt24" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga24" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc24" runat="server"  /></td><td><asp:TextBox ID="gsd24" runat="server" /></td><td><asp:TextBox ID="goc24" runat="server" /></td><td><asp:CheckBox ID="geo24" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">25.<asp:TextBox ID="gn25" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf25" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt25" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga25" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc25" runat="server"  /></td><td><asp:TextBox ID="gsd25" runat="server" /></td><td><asp:TextBox ID="goc25" runat="server" /></td><td><asp:CheckBox ID="geo25" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">26.<asp:TextBox ID="gn26" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf26" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt26" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga26" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc26" runat="server"  /></td><td><asp:TextBox ID="gsd26" runat="server" /></td><td><asp:TextBox ID="goc26" runat="server" /></td><td><asp:CheckBox ID="geo26" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">27.<asp:TextBox ID="gn27" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf27" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt27" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga27" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc27" runat="server"  /></td><td><asp:TextBox ID="gsd27" runat="server" /></td><td><asp:TextBox ID="goc27" runat="server" /></td><td><asp:CheckBox ID="geo27" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">28.<asp:TextBox ID="gn28" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf28" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt28" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga28" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc28" runat="server"  /></td><td><asp:TextBox ID="gsd28" runat="server" /></td><td><asp:TextBox ID="goc28" runat="server" /></td><td><asp:CheckBox ID="geo28" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">29.<asp:TextBox ID="gn29" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf29" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt29" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga29" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc29" runat="server"  /></td><td><asp:TextBox ID="gsd29" runat="server" /></td><td><asp:TextBox ID="goc29" runat="server" /></td><td><asp:CheckBox ID="geo29" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">30.<asp:TextBox ID="gn30" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf30" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt30" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga30" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc30" runat="server"  /></td><td><asp:TextBox ID="gsd30" runat="server" /></td><td><asp:TextBox ID="goc30" runat="server" /></td><td><asp:CheckBox ID="geo30" runat="server" /></td>
            </tr>
            <tr><td  style="white-space:nowrap;" colspan="4"><asp:Button ID="grantsdone3" runat="server" text="Done" OnClick="grantsdone1click" /><asp:Button ID="grantsCancel3" runat="server" Text="Cancel" OnClick="grantscancel" /><asp:Button ID="prev3" runat="server" Text="Previous" OnClick="next1click"/><asp:Button ID="next3" runat="server" Text="Next" OnClick="next3click"/></td></tr>
            </table>

            </asp:Panel>
            <asp:Panel ID="grantsEntr4" runat="server" Style="z-index: 1; position: relative;" visible="false">
            
            <table width="100%">
            <tr>
            <td style="width:auto">Grant No.</td><td width="30px">From</td><td width="30px">To</td><td>Amount</td><td>Location Code</td><td>Sup District</td><td>Obj Code</td><td>Extra Ordinary</td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">31.<asp:TextBox ID="gn31" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf31" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt31" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga31" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc31" runat="server"  /></td><td><asp:TextBox ID="gsd31" runat="server" /></td><td><asp:TextBox ID="goc31" runat="server" /></td><td><asp:CheckBox ID="geo31" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">32.<asp:TextBox ID="gn32" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf32" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt32" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga32" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc32" runat="server"  /></td><td><asp:TextBox ID="gsd32" runat="server" /></td><td><asp:TextBox ID="goc32" runat="server" /></td><td><asp:CheckBox ID="geo32" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">33.<asp:TextBox ID="gn33" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf33" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt33" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga33" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc33" runat="server"  /></td><td><asp:TextBox ID="gsd33" runat="server" /></td><td><asp:TextBox ID="goc33" runat="server" /></td><td><asp:CheckBox ID="geo33" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">34.<asp:TextBox ID="gn34" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf34" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt34" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga34" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc34" runat="server"  /></td><td><asp:TextBox ID="gsd34" runat="server" /></td><td><asp:TextBox ID="goc34" runat="server" /></td><td><asp:CheckBox ID="geo34" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">35.<asp:TextBox ID="gn35" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf35" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt35" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga35" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc35" runat="server"  /></td><td><asp:TextBox ID="gsd35" runat="server" /></td><td><asp:TextBox ID="goc35" runat="server" /></td><td><asp:CheckBox ID="geo35" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">36.<asp:TextBox ID="gn36" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf36" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt36" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga36" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc36" runat="server"  /></td><td><asp:TextBox ID="gsd36" runat="server" /></td><td><asp:TextBox ID="goc36" runat="server" /></td><td><asp:CheckBox ID="geo36" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">37.<asp:TextBox ID="gn37" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf37" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt37" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga37" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc37" runat="server"  /></td><td><asp:TextBox ID="gsd37" runat="server" /></td><td><asp:TextBox ID="goc37" runat="server" /></td><td><asp:CheckBox ID="geo37" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">38.<asp:TextBox ID="gn38" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf38" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt38" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga38" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc38" runat="server"  /></td><td><asp:TextBox ID="gsd38" runat="server" /></td><td><asp:TextBox ID="goc38" runat="server" /></td><td><asp:CheckBox ID="geo38" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">39.<asp:TextBox ID="gn39" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf39" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt39" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga39" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc39" runat="server"  /></td><td><asp:TextBox ID="gsd39" runat="server" /></td><td><asp:TextBox ID="goc39" runat="server" /></td><td><asp:CheckBox ID="geo39" runat="server" /></td>
            </tr>
            <tr>
            <td style="white-space:nowrap;">40.<asp:TextBox ID="gn40" runat="server" Width="80px" /></td><td><asp:TextBox ID="gf40" runat="server" Width="90px"  CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="gt40" runat="server" Width="90px" CssClass="mydatepickerclasser" /></td><td><asp:TextBox ID="ga40" runat="server" Width="90px" OnTextChanged="tallysum" AutoPostBack="true" /></td><td><asp:Textbox ID="glc40" runat="server"   /></td><td><asp:TextBox ID="gsd40" runat="server" /></td><td><asp:TextBox ID="goc40" runat="server" /></td><td><asp:CheckBox ID="geo40" runat="server" /></td>
            </tr>
            <tr><td colspan="3"  style="white-space:nowrap;"><asp:Button ID="grantsdone4" runat="server" text="Done" OnClick="grantsdone1click" /><asp:Button ID="grantsCancel4" runat="server" Text="Cancel" OnClick="grantscancel" /><asp:Button ID="prev4" runat="server" Text="Previous" OnClick="next2click"/></td></tr>
            </table>

            </asp:Panel>

   <div id="dialog" style="display: none;">
  <p>
    Record for <asp:Label ID="savedagencyname" runat="server"  /> was successfully saved.
  </p>
</div>
    <div id="dialog2" style="display: none;">
  <p>
    Operation failed!
  </p>
</div>
    <div id="dialog3" style="display: none;">
  <p>
    Edit was Sucessful!
  </p>
</div>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="Button1" />
            <asp:AsyncPostBackTrigger ControlID="Button2" />
            <asp:AsyncPostBackTrigger ControlID="Button3" />
            <asp:AsyncPostBackTrigger ControlID="Button4" />
        </Triggers>
    </asp:UpdatePanel>



</asp:Content>
