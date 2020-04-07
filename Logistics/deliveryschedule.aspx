<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="deliveryschedule.aspx.vb" Inherits="PriceCalc.deliveryschedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
<asp:Panel ID="Panel1" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 8%; position: absolute; height: 9%; width: 98%;">
<asp:Label ID="LblDate" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: left" Text="Select Delivery Date" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtDDate" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 40%; position: absolute; width: 8%; height: 31%" TextMode="Date"></asp:TextBox>
<asp:Label ID="LblAgent" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 10%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: left" Text="Select Agent" ForeColor="Black"></asp:Label>
<asp:DropDownList ID="TxtAgent" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 10%; top: 40%; position: absolute; width: 8%; height: 35%;" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
</asp:DropDownList>
<asp:Button ID="Commit" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 19%; top: 40%; position: absolute; height: 35%; width: 5%;" Text="Commit" />
<asp:Button ID="Refresh" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 25%; top: 40%; position: absolute; height: 35%; width: 5%;" Text="Refresh" />
<asp:Button ID="Export" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 31%; top: 40%; position: absolute; height: 35%; width: 5%;" Text="Export" />
<asp:Label ID="Label2" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 38%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: left" Text="Look up" ForeColor="Black"></asp:Label>        
<asp:DropDownList ID="TxtOption" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 38%; top: 40%; position: absolute; height: 35%; width: 8%">
<asp:ListItem></asp:ListItem>
<asp:ListItem>ID</asp:ListItem>
<asp:ListItem>Delivery Date</asp:ListItem>
<asp:ListItem>Certificate Status</asp:ListItem>
<asp:ListItem>Agent</asp:ListItem>
<asp:ListItem>Deliver To</asp:ListItem>
<asp:ListItem>Delivery Address</asp:ListItem>
<asp:ListItem>Job Number</asp:ListItem>
<asp:ListItem>Client Name</asp:ListItem>
</asp:DropDownList>
<asp:Label ID="Label3" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 47%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: left" Text="Keyword" ForeColor="Black"></asp:Label>        
<asp:TextBox ID="TxtKeyword" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 47%; top: 40%; position: absolute; height: 28%; width: 9%"></asp:TextBox>
<asp:Button ID="Search" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 57%; top: 40%; position: absolute; height: 35%; width: 5%" Text="Search" />
<asp:Label ID="Label4" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 64%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: left" Text="Select Job" ForeColor="Black"></asp:Label>        
<asp:DropDownList ID="TxtJobRemarks" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 64%; top: 40%; position: absolute; height: 35%; width: 9%" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
</asp:DropDownList>
<asp:Label ID="Label5" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 74%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: left" Text="Enter Remarks" ForeColor="Black"></asp:Label>        
<asp:TextBox ID="TxtDeliveryRemarks" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 74%; top: 40%; position: absolute; height: 28%; width: 15%"></asp:TextBox>
<asp:Button ID="Add" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 90%; top: 40%; position: absolute; height: 35%; width: 5%" Text="Add" />
<asp:Label ID="LblCount" runat="server" style="z-index: 2; right: 4px; bottom: 1px; position: absolute; width: 23%; height: 25%; text-align: right;" Text="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label>
</asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
<asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 18%; position: absolute; height: 37%; width: 98%;background-color: #FFFFFF; overflow:scroll">
<asp:GridView ID="GridView1" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
<Columns>
<asp:ButtonField HeaderText="Remove" Text="Remove" ButtonType="Image" ImageUrl="~/Images/Remove.png">
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:ButtonField>
<asp:templatefield HeaderText="Select">
<itemtemplate>
<asp:checkbox ID="cbselect2" CssClass="gridCB" runat="server"></asp:checkbox>
</itemtemplate>
<HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:templatefield>
</Columns>
<HeaderStyle BackColor="#FF9900"/>
</asp:GridView>
</asp:Panel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
<asp:Panel ID="Panel2" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 56%; position: absolute; height: 5%; width: 98%;">
<asp:Label ID="Label1" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1px; top: 40%; position: absolute; height: 15%; width: 6%; vertical-align:inherit; text-align: right" Text="Lookup Collection" ForeColor="Black"></asp:Label>
<asp:DropDownList ID="TxtCollectionOption" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 20%; position: absolute; height: 60%; width: 8%">
<asp:ListItem></asp:ListItem>
<asp:ListItem>Collection ID</asp:ListItem>
<asp:ListItem>Collection Date</asp:ListItem>
<asp:ListItem>Client</asp:ListItem>
<asp:ListItem>Address</asp:ListItem>
</asp:DropDownList>
<asp:TextBox ID="TxtCollectionKeyword" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 16%; top: 20%; position: absolute; height: 47%; width: 15%"></asp:TextBox>
<asp:Button ID="Collectionsearch" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 32%; top: 20%; position: absolute; height: 60%; width: 5%" Text="Search" />
<asp:Label ID="Label6" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 40%; top: 40%; position: absolute; height: 15%; width: 10%; vertical-align:inherit; text-align: right" Text="Modify Del.Remarks" ForeColor="Black"></asp:Label>
<asp:DropDownList ID="TxtJobSelect" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 51%; top: 20%; position: absolute; height: 60%; width: 8%" AppendDataBoundItems="True" AutoPostBack="True">
<asp:ListItem></asp:ListItem>
</asp:DropDownList>
<asp:TextBox ID="TxtUpRemarks" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 60%; top: 20%; position: absolute; height: 47%; width: 15%"></asp:TextBox>
<asp:Button ID="Update" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 76%; top: 20%; position: absolute; height: 60%; width: 5%; right: 226px;" Text="Update" />
<asp:Label ID="LblCollectionCount" runat="server" style="z-index: 2; right: 4px; bottom: 20%; position: absolute; width: 23%; height: 25%; text-align: right;" Text="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label> 
</asp:Panel>
<asp:Panel ID="Panel6" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 10px;top: 62%; position: absolute;height: 31%; width: 98%;background-color: #FFFFFF; overflow:scroll">
<asp:GridView ID="GridView2" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
<Columns>
<asp:templatefield HeaderText="Select">
<itemtemplate>
<asp:checkbox ID="cbSelect" CssClass="gridCB" runat="server"></asp:checkbox>
</itemtemplate>
<HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:templatefield>
</Columns>
<HeaderStyle BackColor="#FF9900"/>
</asp:GridView>
</asp:Panel>
</asp:Content>