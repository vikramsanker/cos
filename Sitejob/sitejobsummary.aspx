<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="sitejobsummary.aspx.vb" Inherits="PriceCalc.sitejobsummary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
    <asp:Calendar ID="Calendar1" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 10px; top: 8%; position: absolute; height: 85%; width: 98%" BorderStyle="Solid" BackColor="White" BorderColor="Black" DayNameFormat="Full" FirstDayOfWeek="Monday" ForeColor="#CC3300" ShowGridLines="True">
        <DayHeaderStyle BackColor="#FF9900" Font-Bold="True" Font-Names="Arial" ForeColor="Black" Height="8%" />
        <DayStyle BackColor="White" BorderStyle="Solid" Font-Names="Arial" HorizontalAlign="Left" VerticalAlign="Top" ForeColor="#660066" />
        <NextPrevStyle ForeColor="White" />
        <OtherMonthDayStyle BackColor="Silver" />
        <TitleStyle BackColor="#660066" Font-Bold="True" Font-Names="Arial Black" Font-Size="Medium" ForeColor="White" Height="10%" />
        <TodayDayStyle BackColor="#FFFF99" />
        <WeekendDayStyle BackColor="#FF99CC" />
    </asp:Calendar>
</asp:Content>
