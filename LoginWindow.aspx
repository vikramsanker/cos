<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LoginWindow.aspx.vb" Inherits="PriceCalc.LoginWindow" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Caltek Operating System</title>
<style>
body, html {
background: #484848;
height: 98%;
}
</style>
</head>
<body id="Login">
<form id="form1" runat="server">
<asp:Panel ID="Panel0" runat="server" style="background: no-repeat center center fixed; z-index: 1; left: 0; top: 0; position: absolute; height: 97%; width: 98%; right: 0; bottom: 0; margin-bottom: auto; margin-left: auto; margin-right: auto; margin-top: auto" BackImageUrl="~/Images/Login BG.gif">
<asp:Panel ID="Panel3" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 2; Font-Size: 0.7vw; left: 40%; top: 40%; position: absolute; height: 35%; width: 17%; ">
<asp:TextBox ID="Logintxt" runat="server" style="z-index: 3; Font-Size: 0.7vw; left: 37%; top: 21%; position: absolute; width: 50%; height: 11%;"></asp:TextBox>
<asp:TextBox ID="PwdTxt" runat="server" style="z-index: 3; Font-Size: 0.7vw; left: 37%; top: 42%; position: absolute; width: 50%; height: 11%;" TextMode="Password"></asp:TextBox>
<asp:Button ID="LoginBtn" runat="server" style="z-index: 3; Font-Size: 0.7vw; left: 8%; top: 67%; position: absolute; height:12%; width: 38%; background-color: #008080; font-family: sans-serif; Font-Size: 0.7vw; letter-spacing: 2px; color: #FFFFFF;" Text="Login" />
<asp:Button ID="CancelBtn" runat="server" style="z-index: 3; Font-Size: 0.7vw; left: 50%; top: 67%; position: absolute; height:12%; width: 38%; background-color: #008080; font-family: sans-serif; Font-Size: 0.7vw; letter-spacing: 2px; color: #FFFFFF;" Text="Clear" />
<asp:Label ID="Label2" runat="server" Font-Names="Arial" style="z-index: 3; Font-Size: 0.7vw; left: 8%; top: 27%; position: absolute; width: 25%;" Text="Username" ForeColor="White"></asp:Label>
<asp:Label ID="Label3" runat="server" Font-Names="Arial" style="z-index: 3; Font-Size: 0.7vw;left: 8%; top: 47%; position: absolute; width: 25%;" Text="Password" ForeColor="White"></asp:Label>
<asp:Label ID="Label4" runat="server" Font-Names="Arial" style="z-index: 3; word-wrap:normal; Font-Size: 0.7vw; left: 8%; top: 85%; position: absolute; width: 80%; height: 26%;" ForeColor="#CC0000"></asp:Label>
</asp:Panel>
<asp:Panel ID="Panel1" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 29%; position: absolute; height: 10%; width: 97%;" ForeColor="White">
<asp:Label ID="Label5" runat="server" Font-Names="Norwester" style="z-index: 1; Font-Size: 2vw; left: 27px; top: 20%; position: absolute; width: 95%; bottom: 481px; text-align: center; letter-spacing: 5px;" Text="CALTEK GROUP OF COMPANIES - OPERATING SYSTEM (COS)"></asp:Label>
</asp:Panel>
</asp:Panel>
</form>
</body>
</html>