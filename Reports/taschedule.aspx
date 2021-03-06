﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="taschedule.aspx.vb" Inherits="PriceCalc.taschedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
        <asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 8%; position: absolute; height: 10%; width: 98%;">
        <asp:Label ID="LblDate" runat="server" Font-Names="Arial" Font-Size="Small" style="z-index: 1; left: 1%; top: 50%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Delivery Date" ForeColor="Black"></asp:Label>
        <asp:TextBox ID="TxtDDate" runat="server" style="z-index: 1; left: 7%; top: 30%; position: absolute; width: 7%; height: 35%" TextMode="Date"></asp:TextBox>
            <asp:Label ID="LblAgent" runat="server" Font-Names="Arial" Font-Size="Small" style="z-index: 1; left: 15%; top: 50%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Select Agent" ForeColor="Black"></asp:Label>
        <asp:DropDownList ID="TxtAgent" runat="server" style="z-index: 1; left: 21%; top: 30%; position: absolute; width: 16%; height: 41%;" AppendDataBoundItems="True">
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="Search" runat="server" style="z-index: 1; left: 38%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Search" />
        <asp:Button ID="Refresh" runat="server" style="z-index: 1; left: 46%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Refresh" />
        <asp:Button ID="Export" runat="server" style="z-index: 1; left: 54%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Export" />
        <asp:Button ID="ToPDF" runat="server" style="z-index: 1; left: 62%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Export As PDF" />
        <asp:Label ID="LblCount" runat="server" style="z-index: 2; right: 4px; bottom: 5%; position: absolute; width: 23%; height: 25%; text-align: right;" Text="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
        <asp:Panel ID="Panel6" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1;left: 10px;top: 19%; position: absolute;height: 74%; width: 98%;background-color: #FFFFFF; overflow:scroll">
        <asp:GridView ID="GridView1" runat="server" BorderStyle="Solid" Font-Names="Arial" Font-Size="Small" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        <HeaderStyle BackColor="#FF9900"/>
        </asp:GridView>
    </asp:Panel>
</asp:Content>
