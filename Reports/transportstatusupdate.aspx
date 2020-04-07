<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="transportstatusupdate.aspx.vb" Inherits="PriceCalc.transportstatusupdate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
<asp:Panel ID="Panel1" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 8%; position: absolute; height: 19%; width: 37%; right: 715px;">
<asp:Label ID="LblDate" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 15%; position: absolute; height: 5%; width: 15%; vertical-align:inherit; text-align: left" Text="Delivery Date" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtDDate" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 26%; position: absolute; width: 25%; height: 15%" TextMode="Date"></asp:TextBox>
<asp:Label ID="LblAgent" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 28%; top: 15%; position: absolute; height: 5%; width: 15%; vertical-align:inherit; text-align: left" Text="Select Agent" ForeColor="Black"></asp:Label>
<asp:DropDownList ID="TxtAgent" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 28%; top: 26%; position: absolute; width: 25%; height: 17%;" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
</asp:DropDownList>
<asp:Button ID="Search" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 54%; position: absolute; height: 17%; width: 15%;" Text="Search" />
<asp:Button ID="Refresh" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 17%; top: 54%; position: absolute; height: 17%; width: 15%;" Text="Refresh" />
<asp:Button ID="Export" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 33%; top: 54%; position: absolute; height: 17%; width: 15%;" Text="Export" />

</asp:Panel>
<asp:Panel ID="Panel2" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 38%; top: 8%; position: absolute; height: 19%; width: 60%;">
<asp:Label ID="Label2" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 5%; position: absolute; height: 5%; width: 15%; vertical-align:inherit; text-align: left" Text="Type" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtType" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 15%; position: absolute; width: 20%; height: 15%" ReadOnly="True"></asp:TextBox>
<asp:Label ID="Label1" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 39%; position: absolute; height: 5%; width: 15%; vertical-align:inherit; text-align: left" Text="Select Reason" ForeColor="Black"></asp:Label>
<asp:DropDownList ID="TxtJobRemarks" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 50%; position: absolute; height: 17%; width: 20%" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
    <asp:ListItem>Cancelled by Customer</asp:ListItem>
    <asp:ListItem>Cancelled Internally</asp:ListItem>
    <asp:ListItem>Cancelled by Driver</asp:ListItem>
</asp:DropDownList>
<asp:Label ID="Label3" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 22%; top: 5%; position: absolute; height: 5%; width: 15%; vertical-align:inherit; text-align: left" Text="Client Details" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtDetails" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 22%; top: 15%; position: absolute; width: 30%; height: 50%" ReadOnly="True" TextMode="MultiLine"></asp:TextBox>
<asp:Label ID="Label4" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 5%; position: absolute; height: 5%; width: 15%; vertical-align:inherit; text-align: left" Text="Status" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtStatus" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 15%; position: absolute; width: 15%; height: 15%" ReadOnly="True"></asp:TextBox>
<asp:Label ID="Label5" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 40%; position: absolute; height: 5%; width: 15%; vertical-align:inherit; text-align: left" Text="Ref#" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtRefID" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 50%; position: absolute; width: 15%; height: 15%" ReadOnly="True"></asp:TextBox>
<asp:Button ID="Submit" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 77%; position: absolute; height: 17%; width: 10%;" Text="Submit" />
</asp:Panel>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
<asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 28%; position: absolute; height: 32%; width: 98%;background-color: #FFFFFF; overflow:scroll">
<asp:GridView ID="GridView1" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
<Columns>
<asp:ButtonField HeaderText="Completed" Text="Completed" ButtonType="Image" ImageUrl="~/Images/Okay.png" CommandName="Completed">
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:ButtonField>
<asp:ButtonField HeaderText="Cancelled" Text="Cancelled" ButtonType="Image" ImageUrl="~/Images/Not Okay.png" CommandName="Cancelled">
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:ButtonField>
</Columns>
<HeaderStyle BackColor="#FF9900"/>
</asp:GridView>
</asp:Panel>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
<asp:Panel ID="Panel6" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 10px;top: 61%; position: absolute;height: 32%; width: 98%;background-color: #FFFFFF; overflow:scroll">
<asp:GridView ID="GridView2" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
<HeaderStyle BackColor="#FF9900"/>
<Columns>
<asp:ButtonField HeaderText="Remove" Text="Remove" ButtonType="Image" ImageUrl="~/Images/Remove.png">
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:ButtonField>
</Columns>
</asp:GridView>
</asp:Panel>
</asp:Content>