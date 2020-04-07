<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="Importproduction.aspx.vb" Inherits="PriceCalc.Importproduction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
<asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 8%; position: absolute; height: 10%; width: 98%;">
<asp:FileUpload ID="FileUpload1" runat="server" style="position: absolute; top: 33%; Font-Size: 0.7vw; left: 1%; height: 50%; width:14%;"/>
<asp:Button ID="Clear" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 40%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Refresh" />
<asp:Button ID="Process" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 16%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Process" />
<asp:Button ID="ProdPlan" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Add Plan" />
<asp:Button ID="Export" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 84%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Export" />
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
<asp:Button ID="Delete" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 32%; top: 30%; position: absolute; height: 40%; width: 7%" Text="Delete" />
<asp:Label ID="COSkey" runat="server" style="z-index: 1; Font-Size: 0.7vw; right: 1%; top: 30%; position: absolute; height: 40%; width: 7%;" ForeColor="#87CEEC"></asp:Label>
<asp:Label ID="LblCount" runat="server" style="z-index: 2; Font-Size: 0.7vw; right: 4px; bottom: 5%; position: absolute; width: 23%; height: 25%; text-align: right;" Text="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label>
</asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
    <asp:Panel ID="Panel6" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 10px;top: 19%; position: absolute;height: 74%; width: 98%;background-color: #FFFFFF; overflow:scroll">
        <asp:GridView ID="GridView1" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
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