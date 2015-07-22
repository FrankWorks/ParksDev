<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="clipboard.aspx.cs" Inherits="ParksDev.clipboard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

          <asp:Panel ID="EditPanel" runat="server" BorderColor="Red" BorderStyle="Dashed" style="z-index: 1;position:relative;" visible="false" >

               <asp:Label ID="editmodeon" runat="server" Text="EDIT MODE:" ForeColor="Red" Font-Underline="true" /><br /><br />

             <table  align="center" width="100%" border="1">
             <tr>
             <td valign="top" width="200px">
                  <table border="1" width="100%">
                  <tr >
                    <td width="79">
                        Entered: 
                        </td>
                        <td width="200" style="background:white;" >
                       <asp:TextBox ID="editEntered" runat="server" />
                        </td>
                </tr>
                <tr>
                    <td>
                        Fiscal Year: </td><td><asp:TextBox ID="editFy" runat="server" /></td>

                </tr>
                <tr>
                    <td>
                        Processed: </td><td><asp:TextBox ID="editProcessed" runat="server" CssClass="mydatepickerclass"></asp:TextBox></td>

                </tr>
              <tr>
                    <td>
                        Agency:
                     </td>
                     <td><asp:DropDownList ID="editAgency" runat="server" DataSourceID="agencySource" DataTextField="AGENCY" DataValueField="AGENCY"  >
                        
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="agencySource" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ConnectionStrings:FoxProDevConnectionString%>"
                        SelectCommand="Select AGE_CODE, AGENCY from AGENCIES"></asp:SqlDataSource>
                        </td>
                </tr>
                 <tr>
                 <td>By:</td>                    
                 <td width="200px"><asp:TextBox ID="editBy" runat="server" /></td>
                 </tr>
                </table>
             </td>
             <td width="300"> <%--top right--%>
               <table border="1">                
               <tr>
                    <td>
                        <asp:DropDownList ID="editYegType" runat="server">
                        <asp:ListItem Selected="True" Value="0" Text="YEG CREDIT"  >YEG Credit</asp:ListItem>
                        <asp:ListItem Value="1" Text="YEG CREDIT ADJUSTMENT">YEG Credit Adjustment</asp:ListItem>
                        </asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="editYeg" runat="server" /></td>
                </tr>
                <tr>
                    <td align="right">
                        Total YEG Goal: </td>
                    <td>
                        <asp:Label ID="editTotalYegGoal" runat="server" BackColor="White" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Total YEG Previous Credited: </td>
                    <td>
                        <asp:Label ID="editTYPC" runat="server" BackColor="White" Width="200" BorderColor="Black" class="right-justify"  ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Total Remaining YEG Goal: </td>
                    <td>
                        <asp:Label ID="editTRYG" runat="server" Font-Bold="true" BackColor="White" Width="200" BorderColor="Black" class="right-justify"  ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Unmet YEG Goal from previous FY: </td>
                    <td>
                        <asp:Label ID="editUYGFPF" runat="server" BackColor="White" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Current FY Estimate YEG Goal: </td>
                    <td>
                        <asp:Label ID="editCFEYG" runat="server" BackColor="White" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" >
                        Total YEG Credited this FY: </td>
                    <td>
                        <asp:Label ID="editTYCTF" runat="server" BackColor="White" Width="200" BorderColor="Black" class="right-justify"  ></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        Remaining YEG Goal of current FY: </td>
                    <td>
                        <asp:Label ID="editRYGOCF" runat="server" Font-Bold="true" BackColor="White" Width="200" BorderColor="Black"  class="right-justify" ></asp:Label></td>
                </tr></table>

             </td>
             </tr>
             <tr>
             <td colspan="2">
                 <table border="1" width="100%">
                     <tr>
                         <td style="width:127px" align="left">
                             Grant No:
                         </td>
                         <td colspan="4" style="width:auto">
                              <asp:TextBox ID="editGrantNo" runat="server" />
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             Project:
                         </td>
                         <td colspan="4">
                            <asp:TextBox ID="editProject" runat="server" />
                     </tr>
                     <tr>
                         <td align="left">
                             No. of Youths:
                         </td>
                         <td colspan="4">
                             <asp:TextBox ID="editNoYouths" runat="server" />
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             No. of Hours:
                         </td>
                         <td colspan="4">
                           <asp:TextBox ID="editNoOfHours" runat="server" />
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             Job Performed:
                         </td>
                         <td colspan="4">
                             <asp:TextBox ID="editJobP" runat="server" />
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             Employed by:
                         </td>
                         <td colspan="4">
                             <asp:TextBox ID="editEmployed" runat="server" /></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td align="left">
                             Comments:
                         </td>
                         <td colspan="4" id="devadmi">
                            <asp:TextBox ID="editComments" runat="server" Height="150" Width="400" Wrap="true"></asp:TextBox>
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
                             <asp:TextBox ID="editFrom" runat="server" CssClass="mydatepickerclass" />
                         </td>
                         <td align="left" width="1px" colspan="0">
                             TO:
                         </td>
                         <td width="900px">
                             <asp:TextBox ID="editTo" runat="server" CssClass="mydatepickerclass" />
                         </td>
                     </tr>

                 </table>
                  </tr>
                  <tr>
                    <td>
                    <asp:Button ID="editSave" Text="Save" runat="server" OnClick="editSaver" /> <asp:Button ID="editCancel" Text="Cancel" runat="server" OnClick="editCanceler" />
                         </td>
                </tr>
             </td>
             </tr>
            </table>
            <asp:Label ID="eds" Text="Edit Was Sucessful" Visible="false" runat="server" />
            </asp:Panel> <%--viewpanel--%>
 

    
    </div>
    </form>
</body>
</html>
