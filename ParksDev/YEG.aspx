<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="YEG.aspx.cs" Inherits="ParksDev.YEG" %>
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
                $('.mydatepickerclass').datepicker({ dateFormat: 'mm-dd-yy', changeYear: true, changeMonth: true });
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
                }).dialog('open');
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
                }).dialog('open');
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
<h1  class="page_head">Youth Employment Grant Credits</h1>
    <p>&nbsp;</p>
 <%--    <asp:TextBox runat="server" id="datepicker" />--%>


    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" style="z-index: 2;position:relative;">
        <ContentTemplate>        
            <asp:Button ID="Button1" runat="server" Text="First" Width="75" OnClick="clickFirst" />
            <asp:Button ID="Button2" runat="server" Text="Previous" Width="75" OnClick="clickPrevious"/>
            <asp:Button ID="Button3" runat="server" Text="Next" Width="75" OnClick="clickNext"/>
            <asp:Button ID="Button4" runat="server" Text="Last" Width="75" OnClick="clickLast"/>
            <asp:Button ID="Button5" runat="server" Text="Edit"  Width="75" OnClick="clickEdit"/>
            <asp:Button ID="Button6" runat="server" Text="New"  Width="75" OnClick="clickNew"/>

            <%--index:--%><asp:Label ID="roxindexLab" runat="server" Visible="false"></asp:Label>
            <%--limit:--%><asp:Label ID="rowlimitLab" runat="server" Visible="false"></asp:Label>
           <asp:Label ID="DDSwitch" runat="server" Visible="false"></asp:Label>
          <asp:Label ID="fclick" runat="server" Visible="false"></asp:Label>
           <asp:Label ID="nuller" runat="server" Visible="false"></asp:Label>
           <asp:Label ID="nullvalue" runat="server" Visible="false"></asp:Label>
           <asp:Label ID="NORECORD" runat="server" Visible="false" Text="No record found for that agency" Font-Bold="true" ForeColor="Red" />
      <br />

            <asp:Panel ID="newPanel" runat="server" BorderColor="Black" BorderStyle="Double" style="z-index: 3; position:relative;" visible="false" >
                      <asp:Label runat="server" ID="newyeglabel" Text="New Youth Employment Goal" ForeColor="Red"  Font-Underline="true" /><br /><br />

             <table  align="center" width="100%" border="0">
             <tr>
             <td valign="top" width="200px">
                  <table border="0" width="100%">
                  <tr >
                    <td width="79">
                        Entered: 
                        </td>
                        <td width="200"  >
                        <asp:Label ID="newDate" runat="server" ForeColor="Red" BackColor="White" BorderColor="Black"  />
                        </td>
                </tr>
                <tr> 
                    <td>
                        Fiscal Year: </td><td><asp:TextBox ID="newFY" runat="server" /></td>

                </tr>
                <tr>
                    <td>
                        Processed: </td><td><asp:TextBox ID="newProcessed" runat="server" CssClass="mydatepickerclass"></asp:TextBox></td>

                </tr>
                <tr>
                   <td>
                        Agency:</td>
                        <td><asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="newAgencySource" DataTextField="AGENCY" DataValueField="AGE_CODE" >
                        
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="newAgencySource" runat="server" DataSourceMode="DataSet" ConnectionString="<%$ConnectionStrings:FoxProDevConnectionString%>"
                        SelectCommand="Select * from AGENCIES order by AGENCY"></asp:SqlDataSource>
                   </td>
                 </tr>
                 <tr>
                 <td>By:</td>                    
                 <td width="200px"><asp:Label ID="newUser" runat="server" /></td>
                 </tr>
                </table>
             </td>
             <td width="300"> <%--top right--%>
               <table border="0">                <tr>
                    <td>
                        <asp:DropDownList ID="newYTP" runat="server">
                        <asp:ListItem Selected="True" Value="0" Text="YEG CREDIT">YEG Credit</asp:ListItem>
                        <asp:ListItem Value="1" Text="YEG CREDIT ADJUSTMENT">YEG Credit Adjustment</asp:ListItem>
                        </asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="newYEG" runat="server" Width="200" class="right-justify"  />
                        </td>
                </tr>
                <tr>
                    <td align="right">
                        Total YEG Goal: </td>
                    <td>
                        <asp:Label ID="newTYG" runat="server" BackColor="White" Width="200" BorderColor="Black"  class="right-justify"></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Total YEG Previous Credited: </td>
                    <td>
                        <asp:Label ID="newTYPC" runat="server" BackColor="White" Width="200" BorderColor="Black" class="right-justify"  ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Total Remaining YEG Goal: </td>
                    <td>
                        <asp:Label ID="newTRYG" runat="server" Font-Bold="true" BackColor="White" Width="200" BorderColor="Black" class="right-justify"  ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Unmet YEG Goal from previous FY: </td>
                    <td>
                        <asp:Label ID="newUTGFPFY" runat="server" BackColor="White" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Current FY Estimate YEG Goal: </td>
                    <td>
                        <asp:Label ID="newCFEYG" runat="server" BackColor="White" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" >
                        Total YEG Credited this FY: </td>
                    <td>
                        <asp:Label ID="newTYGTFY" runat="server" BackColor="White" Width="200" BorderColor="Black" class="right-justify"  ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Remaining YEG Goal of current FY: </td>
                    <td>
                        <asp:Label ID="newRYGCFY" runat="server" Font-Bold="true" BackColor="White" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr></table>

             </td>
             </tr>
             <tr>
             <td colspan="2">
                 <table border="0" width="100%">
                     <tr>
                         <td style="width:140px" align="left">
                             Grant No:
                         </td>
                         <td colspan="4" style="width:auto">
                              <asp:TextBox ID="newGrantNo" runat="server" Width="500px" Height="30px" />
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             Project:
                         </td>
                         <td colspan="4">
                            <asp:TextBox ID="newProject" runat="server" Width="500px" Height="30px" />
                     </tr>
                     <tr>
                         <td align="left" colspan="5">

                         <table>
                         <tr>
                         <td style="width: 98px;">
                            No. of Youths:
                         </td>
                         <td colspan="4">
                             <asp:TextBox ID="newYouths" runat="server" Width="250px" Height="30px" />
                         </td>
                         <td>Approximate Age: </td>
                         <td><asp:TextBox ID="newAproxAge" runat="server" Width="250px" Height="30px" /></td>
                     </tr>
                     <tr>
                         <td align="left">
                             No. of Hours:
                         </td>
                         <td colspan="4">
                           <asp:TextBox ID="newHours" runat="server" Width="250px" Height="30px" />
                           </td>
                           <td>
                           Wage Per Hour:
                           </td>
                           <td>
                           <asp:TextBox ID="newWage" runat="server" Width="250px" Height="30px" />
                           </td>
                           </tr>
                           </table>



                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             Job Performed:
                         </td>
                         <td colspan="4">
                             <asp:TextBox ID="newJob" runat="server" Width="500px" Height="30px" />
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             Employed by:
                         </td>
                         <td colspan="4">
                             <asp:TextBox ID="newEmployed" runat="server" Width="500px" Height="30px" />
                         </td>
                     </tr>
                        <tr>
                         <td align="left" width="1px" colspan="0">
                             Covered Period:
                         </td>
                         <td align="left" colspan="0" style="width:auto">
                             FROM:
                         </td>
                         <td width="160px" colspan="0">
                             <asp:TextBox ID="newFrom" runat="server" CssClass="mydatepickerclass"/>
                         </td>
                         <td align="left" width="1px" colspan="0">
                             TO:
                         </td>
                         <td width="900px">
                             <asp:TextBox ID="newTo" runat="server" CssClass="mydatepickerclass" />
                         </td>
                     </tr>
                     <tr>
                         <td align="left" valign="top">
                             Comments:
                         </td>
                         <td colspan="4">
                            <asp:TextBox ID="newComments" runat="server" Height="40" Width="150" Wrap="true"></asp:TextBox>
                         </td>
                     </tr>
                 </table>
                                     <tr>
                    <td>
                         <asp:Button ID="Button7" Text="Save" runat="server" OnClick="newSaveClick" /> <asp:Button ID="newCancel" Text="Cancel" runat="server" OnClick="newCancelclick" />
                         </td>
                </tr>
             </td>
             </tr>
            </table>


            </asp:Panel> <%--new panel--%>

            <asp:Panel ID="EditPanel" runat="server" BorderColor="Red" BorderStyle="Dashed" style="z-index: 1;position:relative;" visible="false" >

               <asp:Label ID="editmodeon" runat="server" Text="EDIT MODE:" ForeColor="Red" Font-Underline="true" /><br /><br />
                <table align="center" width="100%" border="0">
                    <tr>
                        <td valign="top" width="200px">
                            <table border="0" width="100%">
                                <tr>
                                    <td width="84">
                                        Entered:
                                    </td>
                                    <td width="200">
                                        <asp:TextBox ID="editEntered" runat="server" CssClass="mydatepickerclass" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Fiscal Year:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editFy" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Processed:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editProcessed" runat="server" CssClass="mydatepickerclass"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Agency:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="editAgency" runat="server" DataSourceID="agencySource" DataTextField="AGENCY"
                                            DataValueField="AGENCY">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="agencySource" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ConnectionStrings:FoxProDevConnectionString%>"
                                            SelectCommand="Select AGE_CODE, AGENCY from AGENCIES order by AGENCY"></asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="300">
                            <%--top right--%>
                            <table border="0">
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="editYegType" runat="server">
                                            <asp:ListItem Selected="True" Value="0" Text="YEG CREDIT">YEG Credit</asp:ListItem>
                                            <asp:ListItem Value="1" Text="YEG CREDIT ADJUSTMENT">YEG Credit Adjustment</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="editYeg" runat="server" Width="200" class="right-justify" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Total YEG Goal:
                                    </td>
                                    <td>
                                        <asp:Label ID="editTotalYegGoal" runat="server" BackColor="White" Width="200" BorderColor="Black"
                                            class="right-justify"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Total YEG Previous Credited:
                                    </td>
                                    <td>
                                        <asp:Label ID="editTYPC" runat="server" BackColor="White" Width="200" BorderColor="Black"
                                            class="right-justify"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Total Remaining YEG Goal:
                                    </td>
                                    <td>
                                        <asp:Label ID="editTRYG" runat="server" Font-Bold="true" BackColor="White" Width="200"
                                            BorderColor="Black" class="right-justify"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Unmet YEG Goal from previous FY:
                                    </td>
                                    <td>
                                        <asp:Label ID="editUYGFPF" runat="server" BackColor="White" Width="200" BorderColor="Black"
                                            class="right-justify"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Current FY Estimate YEG Goal:
                                    </td>
                                    <td>
                                        <asp:Label ID="editCFEYG" runat="server" BackColor="White" Width="200" BorderColor="Black"
                                            class="right-justify"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Total YEG Credited this FY:
                                    </td>
                                    <td>
                                        <asp:Label ID="editTYCTF" runat="server" BackColor="White" Width="200" BorderColor="Black"
                                            class="right-justify"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Remaining YEG Goal of current FY:
                                    </td>
                                    <td>
                                        <asp:Label ID="editRYGOCF" runat="server" Font-Bold="true" BackColor="White" Width="200"
                                            BorderColor="Black" class="right-justify"></asp:Label>
                                    </td>
                                </tr>
                                  <tr>
                                    <td>
                                        By:
                                    </td>
                                    <td width="200px">
                                        <asp:TextBox ID="editBy" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table border="0" width="100%">
                                <tr>
                                    <td style="width: 127px" align="left">
                                        Grant No:
                                    </td>
                                    <td colspan="4" style="width: auto">
                                        <asp:TextBox ID="editGrantNo" runat="server" Width="500px" Height="30px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Project:
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ID="editProject" runat="server" Width="500px" Height="30px" />
                                </tr>
                                <tr><td colspan="5">
                                  <table>
                                  
                                  
                                  
                                  
                                  <td align="left" style="width:92px" > <%--92 seems to work in IE--%>
                                     No. of Youths:
                                  </td>
                                  <td >
                                     <asp:TextBox ID="editNoYouths" runat="server" Width="250px" Height="30px" />
                                  </td>
                                  <td>
                                     Approximate Age:
                                  </td>
                                  <td >
                                     <asp:TextBox ID="editAproxAge" runat="server" Width="250px" Height="30px"   />
                                  </td>
                                  </tr>
                                  <tr>
                                  <td align="left">
                                     No. of Hours:
                                  </td>
                                  <td>
                                     <asp:TextBox ID="editNoOfHours" runat="server" Width="250px" Height="30px" />
                                  </td>
                                  <td>
                                     Wage Per Hour:
                                  </td>
                                  <td >
                                     <asp:TextBox ID="editWage" runat="server" Width="250px"  Height="30px" />
                                  </td>


                                  </table>


                                </td></tr>
                                <tr>
                                    <td align="left">
                                        Job Performed:
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ID="editJobP" runat="server" Width="500px" Height="30px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Employed by:
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ID="editEmployed" runat="server" Width="500px" Height="30px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" width="1px" colspan="0">
                                        Covered Period:
                                    </td>
                                    <td align="left" colspan="0" style="width: auto">
                                        FROM:
                                    </td>
                                    <td width="160px" colspan="0">
                                        <asp:TextBox ID="editFrom" runat="server" CssClass="mydatepickerclass" />
                                    </td>
                                    <td align="left" width="1px" colspan="0">
                                        TO:
                                    </td>
                                    <td width="900px">
                                        <asp:TextBox ID="editTo" runat="server" CssClass="mydatepickerclass" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        Comments:
                                    </td>
                                    <td colspan="4" id="Td2">
                                        <asp:TextBox ID="editComments" runat="server" Height="150" Width="400" Wrap="true"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                   </tr>
                   <tr>
                        <td>
                          <asp:Button ID="editSave" Text="Save" runat="server" OnClick="editSaver" /> <asp:Button ID="editCancel" Text="Cancel" runat="server" OnClick="editCanceler" />
                        </td>
                   </tr>
            </table>
            <asp:Label ID="testbox" runat="server" Visible="false"></asp:Label>
            </asp:Panel><%-- end edit panel--%>

            <asp:Panel ID="viewPanel" runat="server" BorderColor="Transparent" BorderStyle="Groove" style="z-index: 1; position:relative;" visible="true" >
            
             <table  align="center" width="100%" border="0">
             <tr>
             <td valign="top" width="200px">
                  <table border="0" width="100%">
                  <tr>
                    <td style="width:70px">
                        Entered: 
                        </td>
                        <td width="228" >
                        <asp:Label ID="enteredLab" runat="server" BackColor="LightGray" Width="250px"></asp:Label>
                        </td>
                </tr>
                <tr>
                    <td>
                        Fiscal Year: </td><td><asp:Label ID="fyLab" runat="server" BackColor="LightGray" Width="250px" BorderColor="Black" ></asp:Label></td>

                </tr>
                <tr>
                    <td>
                        Processed: </td><td><asp:Label ID="proLab" runat="server" BackColor="LightGray" Width="250px" BorderColor="Black"></asp:Label></td>

                </tr>
                <tr>
                    <td>
                        Agency: </td>
                  <%--      <td><asp:Label ID="agencyLab" runat="server"  BackColor="White" Width="200" BorderColor="Black" ></asp:Label></td>--%>
                  <td> <asp:DropDownList ID="AgencyViewScrolldown" runat="server" DataSourceID="newAgencySource" DataTextField="AGENCY" DataValueField="AGE_CODE" Width="250px" OnSelectedIndexChanged="changeagency" OnTextChanged="changeagency" BackColor="LightGray">
                       </asp:DropDownList> <asp:CheckBox ID="ageFilter" runat="server" Text="Filter" AutoPostBack="true" ToolTip="Filter Results"  OnCheckedChanged="ageclick"   />
                       <asp:SqlDataSource ID="SqlDataSource1" runat="server" DataSourceMode="DataSet" ConnectionString="<%$ConnectionStrings:FoxProDevConnectionString%>"
                       SelectCommand="Select * from AGENCIES order by AGENCY">
                       </asp:SqlDataSource>
                 </td>
                 </tr>
                </table>
             </td>
             <td width="300"> <%--top right--%>
               <table border="0"><tr>
                    <td align="right">
                        <asp:DropDownList ID="typeofyeg" runat="server" BackColor="LightGray" >
                        <asp:ListItem Selected="True" Value="YEG Credit">YEG Credit</asp:ListItem>
                        <asp:ListItem Value="YEG Credit Adjustment">YEG Credit Adjustment</asp:ListItem>
                        </asp:DropDownList></td>
                    <td>
                        <asp:Label ID="yegLab" runat="server" BackColor="LightGray" Width="200" BorderColor="Black" class="right-justify" ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Total YEG Goal: </td>
                    <td>
                        <asp:Label ID="tYEGGLab" runat="server" BackColor="LightGray" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Total YEG Previous Credited: </td>
                    <td>
                        <asp:Label ID="totYEGpcLab" runat="server" BackColor="LightGray" Width="200" BorderColor="Black" class="right-justify"  ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Total Remaining YEG Goal: </td>
                    <td>
                        <asp:Label ID="TRYGLab" runat="server" Font-Bold="true" BackColor="LightGray" Width="200" BorderColor="Black" class="right-justify"  ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Unmet YEG Goal from previous FY: </td>
                    <td>
                        <asp:Label ID="UYGFPFLab" runat="server" BackColor="LightGray" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Current FY Estimate YEG Goal: </td>
                    <td>
                        <asp:Label ID="CFEYGLab" runat="server" BackColor="LightGray" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" >
                        Total YEG Credited this FY: </td>
                    <td>
                        <asp:Label ID="TYCTFLab" runat="server" BackColor="LightGray" Width="200" BorderColor="Black" class="right-justify"  ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Remaining YEG Goal of current FY: </td>
                    <td>
                        <asp:Label ID="RYGOCFLab" runat="server" Font-Bold="true" BackColor="LightGray" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr>
                <tr>
                 <td>By:</td>                    
                 <td><asp:Label ID="byLab" runat="server" BackColor="LightGray" Width="200px"></asp:Label></td>
                 </tr>
                </table>

             </td>
             </tr>
             <tr>
             <td colspan="2">
                 <table border="0" width="100%">
                     <tr>
                         <td style="width:100px" align="left">
                             Grant No:
                         </td>
                         <td colspan="4" style="width:auto">
                             <asp:Label ID="grantLab" runat="server"  BackColor="LightGray" Width="500px" BorderColor="Black"></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             Project:
                         </td>
                         <td colspan="4">
                             <asp:Label ID="projectLab" runat="server" BackColor="LightGray" Width="500px"  BorderColor="Black"></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             No. of Youths:
                         </td>
              <%--           <td colspan="4">--%>
                          <td colspan="2">
                             <asp:Label ID="nyouthLab" runat="server" BackColor="LightGray" Width="250px" BorderColor="Black" ></asp:Label>
                         </td>
                         <td>Approximate Age:
                         </td>
                          <td colspan="2">
                            <asp:Label ID="aproxagev" runat="server"  BackColor="LightGray" Width="250px" BorderColor="Black" ></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             No. of Hours:
                         </td>
                  <%--       <td colspan="4">--%>
                          <td colspan="2">
                             <asp:Label ID="nHoursLab" runat="server" BackColor="LightGray" Width="250px" BorderColor="Black" ></asp:Label>
                         </td>
                         <td>
                         Wage Per Hour:
                         </td>
                          <td colspan="2">
                         <asp:Label ID="wagehourv" runat="server" BackColor="LightGray" Width="250px" BorderColor="Black" ></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             Job Performed:
                         </td>
                         <td colspan="4">
                             <asp:Label ID="jperformedLab" runat="server" BackColor="LightGray" Width="500px" BorderColor="Black"></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             Employed by:
                         </td>
                         <td colspan="4">
                             <asp:Label ID="employLab" runat="server" BackColor="LightGray" Width="250px" BorderColor="Black" ></asp:Label>
                         </td>
                     </tr>
                       <tr>
                         <td align="left" width="1px" colspan="0">
                             Covered Period:
                         </td>
                         <td align="left" colspan="0" style="width:auto">
                             FROM:
                         </td>
                         <td width="160px" colspan="0">
                             <asp:Label ID="fromLab" runat="server" BackColor="LightGray" Width="160" BorderColor="Black" ></asp:Label>
                         </td>
                         <td align="left" width="1px" colspan="0">
                             TO:
                         </td>
                         <td width="900px">
                             <asp:Label ID="toLab" runat="server" BackColor="LightGray" Width="160" BorderColor="Black" ></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td align="left" valign="top">
                             Comments:
                         </td>
                         <td colspan="4" id="devadmi">
                             <asp:TextBox ID="commentsLab" runat="server" Width="500" Wrap="true"
                                 BackColor="LightGray"></asp:TextBox>
                         </td>
                     </tr>

                 </table>
             </td>
             </tr>
            </table>
            <asp:Label ID="eds" Text="" Visible="false" runat="server" />
            </asp:Panel> <%--viewpanel--%>
               <div id="dialog" style="display: none;">
  <p>
    Record for <asp:Label ID="savedagencyname" runat="server"  /> was successfully saved.
  </p>
</div>
    <div id="dialog2" style="display: none;">
  <p>
    Operation failed! Something went wrong. please contact your system administrator
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
            <asp:AsyncPostBackTrigger ControlID="Button2"  />
            <asp:AsyncPostBackTrigger ControlID="Button3" />
            <asp:AsyncPostBackTrigger ControlID="Button4"  />
            <asp:AsyncPostBackTrigger ControlID="AgencyViewScrolldown"  />
            <asp:AsyncPostBackTrigger ControlID="ageFilter"  />                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
        </Triggers>
    </asp:UpdatePanel>
    <br />
    <br />
    <br /><br />
</asp:Content>
