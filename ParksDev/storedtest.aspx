<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="storedtest.aspx.cs" Inherits="ParksDev.storedtest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">Stored Procedure Testing.
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
First Name<asp:TextBox ID="first" runat="server"></asp:TextBox><br />
Last Name<asp:TextBox ID="last" runat="server"></asp:TextBox><br />
Score A<asp:TextBox ID="ScoreA" runat="server"></asp:TextBox><br />
Score B<asp:TextBox ID="ScoreB" runat="server"></asp:TextBox><br />
Score C<asp:TextBox ID="ScoreC" runat="server"></asp:TextBox><br />
<asp:button ID="button1" runat="server" Text="insert DATA" OnClick="InsertCommand"/>

</asp:Content>