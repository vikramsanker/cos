<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Timertest.aspx.vb" Inherits="PriceCalc.Timertest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

    <div style="background-color: #0076AE">
    

        <asp:ScriptManager ID="ScriptManager1"
            runat="server">
        </asp:ScriptManager>
<asp:Timer ID="Timer1" runat="server" Interval="1000">
                </asp:Timer>
        <asp:UpdatePanel ID="UpdatePanel1"
            runat="server">
            <ContentTemplate>
                   <asp:Label ID="Label1" runat="server"
                    ForeColor="White" ></asp:Label>
                <br />
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="tIMER1" EventName="Tick"></asp:AsyncPostBackTrigger>
            </Triggers>
        </asp:UpdatePanel>
        <br />
    

    </div>
    </form>
</body>
</html>
