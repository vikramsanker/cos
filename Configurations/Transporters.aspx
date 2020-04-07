<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="Transporters.aspx.vb" Inherits="PriceCalc.Transporters" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
        <asp:Panel ID="Panel3" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 10px;top: 8%;position: absolute;height: 36%;width: 98%;overflow: scroll;">    
        <asp:Label ID="LblVendor" runat="server" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Transporter" ForeColor="Black"></asp:Label>
        <asp:TextBox ID="TxtVendor" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 5%; position: absolute; width: 16%; height: 9%"></asp:TextBox>
        <asp:Label ID="LblAdd1" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Address Line 1"></asp:Label>
        <asp:TextBox ID="TxtAdd1" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 5%; position: absolute; width: 16%; height: 9%" EnableViewState="False"></asp:TextBox>
        <asp:Label ID="LblAdd2" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 47%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Address Line 2"></asp:Label>
        <asp:TextBox ID="TxtAdd2" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 5%; position: absolute; width: 16%; height: 9%"></asp:TextBox>
        <asp:Label ID="LblAdd3" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 70%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Address Line 3"></asp:Label>
        <asp:TextBox ID="TxtAdd3" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 76%; top: 5%; position: absolute; width: 16%; height: 9%"></asp:TextBox>
        <asp:Label ID="LblCountry" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Country"></asp:Label>
        <asp:DropDownList ID="Country" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 20%; position: absolute; height: 10%; width: 16%;" AppendDataBoundItems="True">
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="lblPostalcode" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Postal Code"></asp:Label>
        <asp:TextBox ID="Txtpostalcode" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 30%; top: 20%; position: absolute; width: 16%; height: 9%"></asp:TextBox>
        <asp:Label ID="LblContact" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 47%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Contact"></asp:Label>
        <asp:DropDownList ID="TxtSal" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 20%; position: absolute; width: 3%; height: 10%">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Mr.</asp:ListItem>
            <asp:ListItem>Mrs.</asp:ListItem>
            <asp:ListItem>Ms.</asp:ListItem>
        </asp:DropDownList>
        <asp:TextBox ID="TxtName" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 57%; top: 20%; position: absolute; width: 12%; height: 9%"></asp:TextBox>
        <asp:Label ID="LblTel" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 70%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Telephone"></asp:Label>
        <asp:TextBox ID="TxtTel" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 76%; top: 20%; position: absolute; width: 16%; height: 9%" TextMode="Phone"></asp:TextBox>
        <asp:Label ID="LblHP" runat="server" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 40%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Handphone" ForeColor="Black"></asp:Label>
        <asp:TextBox ID="TxtHP" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 35%; position: absolute; width: 16%; height: 9%" TextMode="Phone"></asp:TextBox>
        <asp:Label ID="LblEmailID" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 40%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Email ID"></asp:Label>
        <asp:TextBox ID="TxtEmail" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 30%; top: 35%; position: absolute; width: 16%; height: 9%" TextMode="Email"></asp:TextBox>
        <asp:Label ID="lblStatus" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 47%; top: 40%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Status"></asp:Label>
        <asp:DropDownList ID="Status" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 35%; position: absolute; width: 16%; height: 10%;" AppendDataBoundItems="True">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Active</asp:ListItem>
            <asp:ListItem>Inactive</asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="lblNote" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 70%; top: 40%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Note"></asp:Label>
        <asp:TextBox ID="TxtNote" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 76%; top: 35%; position: absolute; width: 16%; height: 18%" TextMode="MultiLine"></asp:TextBox>
        </asp:Panel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
            <asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 45%; position: absolute; height: 10%; width: 98%;">
        <asp:Button ID="Clear" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 17%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Clear" />
        <asp:Button ID="Save" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Save" />
        <asp:Button ID="Update" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 9%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Update" />
        <asp:Button ID="Delete" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 25%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Delete" />
        <asp:Button ID="Export" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 33%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Export" />
        <asp:Label ID="COSkey" runat="server" style="z-index: 1; right: 1%; top: 30%; position: absolute; height: 40%; width: 7%;" ForeColor="#87CEEC"></asp:Label>
        </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
            <asp:Panel ID="Panel5" runat="server" BorderStyle="None" style="z-index: 1;  left: 10px; top: 56%; position: absolute; height: 5%; width: 98%">
        <asp:TextBox ID="Searchbox" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 5%; top: 3px; position: absolute; width: 24%; height: 89%; background-color: #E9E9E9;" BackColor="#FCF5D8" BorderStyle="Solid"></asp:TextBox>
        <asp:Label ID="Label11" runat="server" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 0%; top: 45%; position: absolute; width: 4%; text-align: Left; vertical-align: inherit; right: 1167px;" Text="Search: "></asp:Label>
        <asp:Button ID="SearchButton" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 32%; top: 10%; height:80%; width: 7%; position: absolute" Text="Find" />
        <asp:Label ID="LblCount" runat="server" style="z-index: 2; right: 4px; bottom: 5%; position: absolute; width: 23%; height: 25%; text-align: right;" Text="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label>
        </asp:Panel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
            <asp:Panel ID="Panel6" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 10px;top: 62%; position: absolute;height: 31%; width: 98%;background-color: #FFFFFF; overflow:scroll">
        <asp:GridView ID="GridView1" runat="server" BorderStyle="Solid" Font-Names="Arial"  style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
        <Columns>
        <asp:ButtonField HeaderText="Edit" Text="Edit" ButtonType="Image" ImageUrl="~/Images/application.png">
        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
        </asp:ButtonField>
        </Columns>
        <HeaderStyle BackColor="#FF9900"/>
        </asp:GridView>
        </asp:Panel>
</asp:Content>
