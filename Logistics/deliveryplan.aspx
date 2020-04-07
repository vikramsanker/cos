<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="deliveryplan.aspx.vb" Inherits="PriceCalc.deliveryplan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
<asp:Panel ID="Panel1" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 8%; position: absolute; height: 9%; width: 98%;">
<asp:Label ID="LblDate" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 50%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Delivery Date" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtDDate" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 30%; position: absolute; width: 16%; height: 41%" TextMode="Date"></asp:TextBox>
<asp:Button ID="Plan" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="To Schedule" />
<asp:Button ID="Refresh" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 32%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Refresh" />
<asp:Button ID="Export" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 40%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Export" />
<asp:DropDownList ID="TxtOption" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 48%; top: 30%; position: absolute; height: 39%; width: 10%">
<asp:ListItem></asp:ListItem>
<asp:ListItem>Date Received</asp:ListItem>
<asp:ListItem>Job Number</asp:ListItem>
<asp:ListItem>Client Name</asp:ListItem>
<asp:ListItem>Quantity</asp:ListItem>
<asp:ListItem>Department</asp:ListItem>
<asp:ListItem>Delivery Type</asp:ListItem>
<asp:ListItem>Certification</asp:ListItem>
<asp:ListItem>Instrument</asp:ListItem>
</asp:DropDownList>
<asp:TextBox ID="TxtKeyword" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 59%; top: 30%; position: absolute; height: 35%; width: 16%"></asp:TextBox>
<asp:Button ID="Search" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 76%; top: 30%; position: absolute; height: 40%; width: 7%" Text="Search" />
<asp:Label ID="LblCount" runat="server" style="z-index: 2; Font-Size: 0.7vw; right: 4px; bottom: 5%; position: absolute; width: 23%; height: 25%; text-align: right;" Text="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label>
</asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
<asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 18%; position: absolute; height: 37%; width: 98%;background-color: #FFFFFF; overflow:scroll">
<asp:GridView ID="GridView2" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
<Columns>
<asp:templatefield HeaderText="Select">
<itemtemplate>
<asp:checkbox ID="cbSelect" CssClass="gridCB" runat="server"></asp:checkbox>
</itemtemplate>
<HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:templatefield>
<asp:ButtonField HeaderText="Remove" Text="Remove" ButtonType="Image" ImageUrl="~/Images/Remove.png">
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:ButtonField>
</Columns>
<HeaderStyle BackColor="#FF9900"/>
</asp:GridView>
</asp:Panel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
<asp:Panel ID="Panel6" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1;left: 10px;top: 56%; position: absolute;height: 37%; width: 98%;background-color: #FFFFFF; overflow:scroll">
<asp:GridView ID="GridView1" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
<Columns>
<asp:ButtonField HeaderText="Add" Text="Add" ButtonType="Image" ImageUrl="~/Images/add.png">
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:ButtonField>
</Columns>
<HeaderStyle BackColor="#FF9900"/>
</asp:GridView>
</asp:Panel>
</asp:Content>