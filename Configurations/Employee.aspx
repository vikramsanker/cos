<%@ Page Title="COS - Employee Management" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="Employee.aspx.vb" Inherits="PriceCalc.Employee" %>
<%@ MasterType VirtualPath="~/MainMasterPage.Master" %>
<asp:Content ID="C3" runat="server" ContentPlaceHolderID="CPH3">
<asp:Panel ID="Panel3" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 10px;top: 8%;position: absolute;height: 36%;width: 98%;overflow: scroll;">    
<asp:Label ID="Label1" runat="server" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Employee ID" ForeColor="Black"></asp:Label>
<asp:TextBox ID="EID" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 5%; position: absolute; width: 16%; height: 9%"></asp:TextBox>
<asp:Label ID="Label2" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="First Name"></asp:Label>
<asp:TextBox ID="FName" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 5%; position: absolute; width: 16%; height: 9%"></asp:TextBox>
<asp:Label ID="Label3" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 47%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Middle Name"></asp:Label>
<asp:TextBox ID="MName" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 5%; position: absolute; width: 16%; height: 9%"></asp:TextBox>
<asp:Label ID="Label4" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 70%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Last Name"></asp:Label>
<asp:TextBox ID="LName" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 76%; top: 5%; position: absolute; width: 16%; height: 9%"></asp:TextBox>
<asp:Label ID="Label5" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Email ID"></asp:Label>
<asp:TextBox ID="EmailID" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 7%; top: 20%; position: absolute; width: 16%; height: 9%"></asp:TextBox>
<asp:Label ID="Label6" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Department"></asp:Label>
<asp:DropDownList ID="Department" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 20%; position: absolute; height: 10%; width: 16%;" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
</asp:DropDownList>   
<asp:Label ID="Label7" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 47%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Gender"></asp:Label>
<asp:DropDownList ID="Gender" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 53%; top: 20%; position: absolute; width: 16%; height: 10%">
<asp:ListItem></asp:ListItem>
<asp:ListItem>Male</asp:ListItem>
<asp:ListItem>Female</asp:ListItem>
</asp:DropDownList>
<asp:Label ID="Label8" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 70%; top: 25%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Role"></asp:Label>
<asp:DropDownList ID="Role" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 76%; top: 20%; position: absolute; width: 16%; height: 10%" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
</asp:DropDownList>
<asp:Label ID="Label9" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 40%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Status"></asp:Label>
<asp:DropDownList ID="Status" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 35%; position: absolute; width: 16%; height: 10%">
<asp:ListItem></asp:ListItem>
<asp:ListItem>Active</asp:ListItem>
<asp:ListItem>Inactive</asp:ListItem>
</asp:DropDownList>
<asp:Label ID="Label10" runat="server" ForeColor="Black" Font-Names="Arial"  style="z-index: 1;Font-Size: 0.7vw; left: 24%;top: 40%;position: absolute; height: 15%; width: 5%; vertical-align:inherit;text-align: right" Text="Date of Birth"></asp:Label>
<asp:TextBox ID="DOB" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 35%; position: absolute; width: 16%; height: 9%" TextMode="Date"></asp:TextBox>
</asp:Panel>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="CPH1">
<asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 45%; position: absolute; height: 10%; width: 98%;">
<asp:Button ID="Clear" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 17%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Clear" />
<asp:Button ID="Save" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Save" />
<asp:Button ID="Update" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 9%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Update" />
<asp:Button ID="Delete" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 25%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Delete" />
<asp:Button ID="Export" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 33%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Export" />
</asp:Panel>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="CPH2">
<asp:Panel ID="Panel5" runat="server" BorderStyle="None" style="z-index: 1; left: 10px; top: 56%; position: absolute; height: 5%; width: 98%">
<asp:TextBox ID="Searchbox" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 5%; top: 3px; position: absolute; width: 24%; height: 89%; background-color: #E9E9E9;" BackColor="#FCF5D8" BorderStyle="Solid"></asp:TextBox>
<asp:Label ID="Label11" runat="server" Font-Names="Arial"  style="z-index: 1; Font-Size: 0.7vw; left: 0%; top: 45%; position: absolute; width: 4%; text-align: Left; vertical-align: inherit; right: 1167px;" Text="Search: "></asp:Label>
<asp:Button ID="SearchButton" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 32%; top: 10%; height:80%; width: 7%; position: absolute" Text="Find" />
<asp:Label ID="LblCount" runat="server" style="z-index: 2; right: 4px; bottom: 5%; position: absolute; width: 23%; height: 25%; text-align: right;" Text="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label>
</asp:Panel>
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="CPH4">
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