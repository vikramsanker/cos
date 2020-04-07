<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="Changepassword.aspx.vb" Inherits="PriceCalc.Changepassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
<asp:Panel ID="Panel3" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 10px;top: 8%;position: absolute;height: 36%;width: 98%;overflow: scroll;">    
        <asp:Label ID="LblOldPwd" runat="server" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Old Password" ForeColor="Black"></asp:Label>
        <asp:TextBox ID="TxtOldPwd" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 5%; position: absolute; width: 16%; height: 9%" TextMode="Password"></asp:TextBox>
        <asp:Label ID="LblPwd" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="New Password"></asp:Label>
        <asp:TextBox ID="Txtpwd" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 5%; position: absolute; width: 16%; height: 9%" EnableViewState="False" TextMode="Password"></asp:TextBox>
        <asp:Label ID="LblRepwd" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 47%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Re-enter New password"></asp:Label>
        <asp:TextBox ID="TxtRepwd" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 5%; position: absolute; width: 16%; height: 9%" TextMode="Password"></asp:TextBox>
</asp:Panel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
    <asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 45%; position: absolute; height: 10%; width: 98%;">
        <asp:Button ID="Update" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Update" />
        <asp:Button ID="Clear" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 9%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Clear" />
        </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
    <asp:Panel ID="Panel5" runat="server" BorderStyle="None" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 56%; position: absolute; height: 37%; width: 98%">
        <asp:Label ID="Help" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 1%; position: absolute; width: 96%; text-align: Left; height: 244px;" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label>
    </asp:Panel>
</asp:Content>
