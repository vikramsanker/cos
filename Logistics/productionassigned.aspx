﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="productionassigned.aspx.vb" Inherits="PriceCalc.productionassigned" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
    <asp:Panel ID="Panel3" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 10px;top: 8%;position: absolute;height: 36%;width: 98%;overflow: scroll;">    
            <asp:Label ID="LblProductionID" runat="server" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="ProductionID" ForeColor="Black"></asp:Label>
            <asp:Label ID="LblCOSKey" runat="server" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: Left" Text="NULL" ForeColor="Black"></asp:Label>
            <asp:Label ID="LblJob" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Job No."></asp:Label>
            <asp:TextBox ID="TxtJob" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 5%; position: absolute; width: 16%; height: 9%" EnableViewState="False" ReadOnly="True"></asp:TextBox>
            <asp:Label ID="LblClient" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 47%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Client"></asp:Label>
            <asp:TextBox ID="TxtClient" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 5%; position: absolute; width: 16%; height: 9%" ReadOnly="True"></asp:TextBox>
            <asp:Label ID="LblInstrument" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 70%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Instrument"></asp:Label>
            <asp:TextBox ID="TxtInstrument" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 76%; top: 5%; position: absolute; width: 16%; height: 9%" ReadOnly="True"></asp:TextBox>
            <asp:Label ID="LblSerialNo" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Serial No"></asp:Label>
            <asp:TextBox ID="TxtSerialNo" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 7%; top: 20%; position: absolute; width: 16%; height: 9%" ReadOnly="True"></asp:TextBox>
            <asp:Label ID="lblCertification" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Certification"></asp:Label>
            <asp:TextBox ID="TxtCertification" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 30%; top: 20%; position: absolute; width: 16%; height: 9%" ReadOnly="True"></asp:TextBox>
            <asp:Label ID="LblQuantity" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 47%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Quantity"></asp:Label>
            <asp:TextBox ID="TxtQuantity" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 53%; top: 20%; position: absolute; width: 16%; height: 9%" ReadOnly="True"></asp:TextBox>
            <asp:Label ID="lblstatus" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 70%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Status"></asp:Label>
            <asp:DropDownList ID="TxtStatus" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 76%; top: 20%; position: absolute; width: 16%; height: 10%;" AppendDataBoundItems="True">    
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Certificate</asp:ListItem>
            <asp:ListItem>On-hold</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="LblRemarks" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 40%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Remarks"></asp:Label>    
            <asp:TextBox ID="TxtRemarks" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 35%; position: absolute; width: 16%; height: 28%" TextMode="MultiLine"></asp:TextBox>
   </asp:Panel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
        <asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 45%; position: absolute; height: 10%; width: 98%;">
        <asp:Button ID="Update" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Update" />
        <asp:Button ID="Refresh" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 17%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Refresh" />
        <asp:Button ID="Export" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 9%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Export" />
        <asp:Label ID="LblCount" runat="server" style="z-index: 2; right: 4px; bottom: 5%; position: absolute; width: 23%; height: 25%; text-align: right;" Text="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label>
        </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
        <asp:Panel ID="Panel6" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 10px;top: 56%; position: absolute;height: 37%; width: 98%;background-color: #FFFFFF; overflow:scroll">
        <asp:GridView ID="GridView1" runat="server" BorderStyle="Solid" Font-Names="Arial"  style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
        <Columns>
        <asp:ButtonField HeaderText="Update" Text="Update" ButtonType="Image" ImageUrl="~/Images/application.png">
        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
        </asp:ButtonField>
        </Columns>
        <HeaderStyle BackColor="#FF9900"/>
        </asp:GridView>
        </asp:Panel>
</asp:Content>
