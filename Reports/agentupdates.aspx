<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="agentupdates.aspx.vb" Inherits="PriceCalc.agentupdates" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
        <asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 8%; position: absolute; height: 10%; width: 98%;">
        <asp:Label ID="LblLookup" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: Left" Text="Lookup" ForeColor="Black"></asp:Label>
        <asp:DropDownList ID="TxtSearch" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 40%; position: absolute; width: 8%; height: 35%;" AppendDataBoundItems="True">
        <asp:ListItem></asp:ListItem>
            <asp:ListItem>CollectionID</asp:ListItem>
            <asp:ListItem>Job Number</asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="Label3" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 10%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: Left" Text="Keyword" ForeColor="Black"></asp:Label>        
        <asp:TextBox ID="TxtKeyword" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 10%; top: 40%; position: absolute; height: 28%; width: 9%"></asp:TextBox>
        <asp:Button ID="Search" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 20%; top: 40%; position: absolute; height: 35%; width: 5%;" Text="Search" />
            <asp:Label ID="LblID" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 26%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: Left" Text="Ref ID" ForeColor="Black"></asp:Label>        
        <asp:TextBox ID="TxtRefID" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 26%; top: 40%; position: absolute; height: 28%; width: 10%" ReadOnly="True"></asp:TextBox>
            <asp:Label ID="LblType" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 37%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: Left" Text="Type" ForeColor="Black"></asp:Label>        
        <asp:TextBox ID="TxtType" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 37%; top: 40%; position: absolute; height: 28%; width: 10%" ReadOnly="True"></asp:TextBox>
        <asp:Label ID="LblStatus" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 48%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: Left" Text="Select Status" ForeColor="Black"></asp:Label>        
        <asp:DropDownList ID="TxtStatus" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 48%; top: 40%; position: absolute; height: 35%; width: 9%" AppendDataBoundItems="True">
        <asp:ListItem></asp:ListItem>
        <asp:ListItem>Completed</asp:ListItem>
        <asp:ListItem>Cancelled</asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="LblRemarks" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 58%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: Left" Text="Enter Remarks" ForeColor="Black"></asp:Label>        
        <asp:TextBox ID="TxtDeliveryRemarks" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 58%; top: 40%; position: absolute; height: 28%; width: 15%"></asp:TextBox>
        <asp:Button ID="Add" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 74%; top: 40%; position: absolute; height: 35%; width: 5%" Text="Add" />
        <asp:Button ID="Refresh" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 80%; top: 40%; position: absolute; height: 35%; width: 5%;" Text="Refresh" />
        <asp:Label ID="LblCount" runat="server" style="z-index: 2; right: 4px; bottom: 5%; position: absolute; width: 23%; height: 25%; text-align: right;" Text="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
        <asp:Panel ID="Panel6" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 10px;top: 19%; position: absolute;height: 74%; width: 98%;background-color: #FFFFFF; overflow:scroll">
        <asp:GridView ID="GridView1" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
                    <Columns>
        <asp:ButtonField HeaderText="Update" Text="Update" ButtonType="Image" ImageUrl="~/Images/application.png">
        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        </asp:ButtonField>
        </Columns>
        <HeaderStyle BackColor="#FF9900"/>
        </asp:GridView>
    </asp:Panel>
</asp:Content>