<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="sitejobrequest.aspx.vb" Inherits="PriceCalc.sitejobrequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
<asp:Panel ID="Panel3" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1;Font-Size: 0.7vw; left: 10px;top: 8%;position: absolute;height: 42%;width: 98%;overflow: scroll;">    
<asp:Label ID="LblClient" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 10%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Client" ForeColor="Black"></asp:Label>
<asp:DropDownList ID="TxtClient" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 5%; position: absolute; width: 16%; height:10%;" AppendDataBoundItems="True" AutoPostBack="True">
<asp:ListItem></asp:ListItem>
</asp:DropDownList>
<asp:Label ID="LblAddress" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 22%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Address Line 1"></asp:Label>
<asp:TextBox ID="TxtAdd1" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 18%; position: absolute; width: 16%; height: 7%" ReadOnly="True"></asp:TextBox>
<asp:Label ID="LblAdd2" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 33%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Address Line 2"></asp:Label>
<asp:TextBox ID="TxtAdd2" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 29%; position: absolute; width: 16%; height: 7%" ReadOnly="True"></asp:TextBox>
<asp:Label ID="LblAdd3" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 43%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Address Line 3"></asp:Label>
<asp:TextBox ID="TxtAdd3" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 40%; position: absolute; width: 16%; height: 7%" ReadOnly="True"></asp:TextBox>
<asp:Label ID="LblCountry" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 55%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Country"></asp:Label>
<asp:DropDownList ID="TxtCountry" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 51%; position: absolute; height: 10%; width: 16%;" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
</asp:DropDownList>
<asp:Label ID="lblPostalcode" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 67%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Postal Code"></asp:Label>
<asp:TextBox ID="Txtpostalcode" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 7%; top: 64%; position: absolute; width: 16%; height: 7%" ReadOnly="True"></asp:TextBox>
<asp:Label ID="LblContact" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 80%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Contact"></asp:Label>
<asp:DropDownList ID="TxtSal" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 75%; position: absolute; width: 3%; height: 9%">
<asp:ListItem></asp:ListItem>
<asp:ListItem>Mr.</asp:ListItem>
<asp:ListItem>Mrs.</asp:ListItem>
<asp:ListItem>Ms.</asp:ListItem>
</asp:DropDownList>
<asp:TextBox ID="TxtName" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 10%; top: 75%; position: absolute; width: 13%; height: 7%"></asp:TextBox>
<asp:Label ID="LblTel" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 90%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Telephone"></asp:Label>
<asp:TextBox ID="TxtTel" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 7%; top: 86%; position: absolute; width: 16%; height: 7%"></asp:TextBox>
<asp:Label ID="LblDOR" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 10%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Requested on"></asp:Label>
<asp:TextBox ID="TxtDOR" runat="server" Style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 5%; position: absolute; width: 16%; height: 8%" TextMode="Date"></asp:TextBox>
<asp:Label ID="LblJob" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 20%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Job No."></asp:Label>
<asp:TextBox ID="TxtJobNo" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 17%; position: absolute; width: 16%; height: 7%" EnableViewState="False"></asp:TextBox>
<asp:Label ID="LblSales" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 32%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Caltek Sales" ForeColor="Black"></asp:Label>
<asp:DropDownList ID="TxtSalesperson" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 28%; position: absolute; width: 16%; height: 10%;" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
</asp:DropDownList>
<asp:Label ID="lblPPE" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 45%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="PPE Request"></asp:Label>
<asp:TextBox ID="ListPPE" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 41%; position: absolute; width: 16%; height: 7%"></asp:TextBox>
<asp:Label ID="lblrisk" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 58%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Risk. Assmt."></asp:Label>
<asp:DropDownList ID="TxtRisk" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 53%; position: absolute; height: 10%; width: 16%;" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
<asp:ListItem>Yes</asp:ListItem>
<asp:ListItem>No</asp:ListItem>
</asp:DropDownList>
<asp:Label ID="lblNote" runat="server" ForeColor="Black" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 24%; top:68%; position: absolute; height: 12%; width: 5%; vertical-align:inherit; text-align: right" Text="Note"></asp:Label>
<asp:TextBox ID="TxtNote" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 30%; top: 65%; position: absolute; width: 16%; height: 17%" TextMode="MultiLine"></asp:TextBox>    
<asp:Label ID="LblHP" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 24%; top: 90%; position: absolute; height: 10%; width: 5%; vertical-align:inherit; text-align: right" Text="Handphone" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtHP" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 86%; position: absolute; width: 16%; height: 7%"></asp:TextBox>
<asp:Panel ID="Panel6" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1;Font-Size: 0.7vw; left: 48%;top: 17%; position: absolute;height: 63%; width: 51%;background-color: #FFFFFF; overflow:scroll">
<asp:GridView ID="GridView2" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
<Columns>
<asp:ButtonField HeaderText="Remove" Text="Remove" ButtonType="Image" ImageUrl="~/Images/Remove.png">
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
</asp:ButtonField>
</Columns>
<HeaderStyle BackColor="#FF9900"/>
</asp:GridView>
</asp:Panel>
<asp:Label ID="lblInstrument" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 48%; top: 5%; position: absolute; height: 5%; width: 5%; vertical-align:inherit; text-align: Left" Text="Instrument" ForeColor="Black"></asp:Label>
<asp:DropDownList ID="TxtInstrument" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 48%; top: 9%; position: absolute; height: 7%; width: 8%;" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
</asp:DropDownList>
<asp:Label ID="Label1" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 57%; top: 5%; position: absolute; height: 5%; width: 5%; vertical-align:inherit; text-align: Left" Text="Range" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtRange" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 57%; top: 9%; position: absolute; width: 5%; height: 6%"></asp:TextBox>
<asp:Label ID="Label2" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 63%; top: 5%; position: absolute; height: 5%; width: 5%; vertical-align:inherit; text-align: Left" Text="Make" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtMake" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 63%; top: 9%; position: absolute; width: 5%; height: 6%"></asp:TextBox>
<asp:Label ID="Label3" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 69%; top: 5%; position: absolute; height: 5%; width: 5%; vertical-align:inherit; text-align: Left" Text="Model" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtModel" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 69%; top: 9%; position: absolute; width: 5%; height: 6%"></asp:TextBox>
<asp:Label ID="Label4" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 75%; top: 5%; position: absolute; height: 5%; width: 5%; vertical-align:inherit; text-align: Left" Text="Quantity" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtQty" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 75%; top: 9%; position: absolute; width: 3%; height: 6%"></asp:TextBox>
<asp:Label ID="Label5" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 79%; top: 5%; position: absolute; height: 5%; width: 5%; vertical-align:inherit; text-align: Left" Text="Cert. Type" ForeColor="Black"></asp:Label>
<asp:DropDownList ID="TxtCertType" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 79%; top: 9%; position: absolute; height: 7%; width: 5%;" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
<asp:ListItem>Singlas</asp:ListItem>
<asp:ListItem>Std.Caltek</asp:ListItem>
<asp:ListItem>Key Solut.</asp:ListItem>
</asp:DropDownList>
<asp:Label ID="Label6" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 85%; top: 5%; position: absolute; height: 5%; width: 5%; vertical-align:inherit; text-align: Left" Text="Pre-Cert" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtPreCert" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 85%; top: 9%; position: absolute; width: 5%; height: 6%"></asp:TextBox>
<asp:Label ID="Label7" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 91%; top: 5%; position: absolute; height: 5%; width: 5%; vertical-align:inherit; text-align: Left" Text="Cal Points" ForeColor="Black"></asp:Label>
<asp:TextBox ID="TxtCalpts" runat="server" style=" z-index: 1; Font-Size: 0.7vw; left: 91%; top: 9%; position: absolute; width: 5%; height: 6%"></asp:TextBox>
<asp:Button ID="TxtAdd" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 97%; top: 9%; height:7%; width: 2%; position: absolute" Text="+" />
<asp:Button ID="Save" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 48%; top: 87%; position: absolute; height: 7%; width: 7%;" Text="Save" />
<asp:Button ID="Update" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 56%; top: 87%; position: absolute; height: 7%; width: 7%;" Text="Update" />
<asp:Button ID="Cancel" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 64%; top: 87%; position: absolute; height: 7%; width: 7%;" Text="Cancel" />
<asp:Label ID="COSkey" runat="server" style="z-index: 1; right: 1%; top: 95%; position: absolute; height: 5%; width: 5%;" ForeColor="#87CEEC"></asp:Label>
</asp:Panel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
<asp:Panel ID="Panel1" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1;Font-Size: 0.7vw; left: 10px;top: 51%;position: absolute;height: 10%;width: 98%">  
<asp:Label ID="LblLookup" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: Left" Text="Lookup" ForeColor="Black"></asp:Label>
<asp:DropDownList ID="TxtSearch" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 40%; position: absolute; width: 8%; height: 35%;" AppendDataBoundItems="True">
<asp:ListItem></asp:ListItem>
<asp:ListItem>Id</asp:ListItem>
<asp:ListItem>Client</asp:ListItem>
<asp:ListItem>Requested Date</asp:ListItem>
<asp:ListItem>Job No.</asp:ListItem>
<asp:ListItem>Salesperson</asp:ListItem>
<asp:ListItem>Remarks</asp:ListItem>
<asp:ListItem>Status</asp:ListItem>
</asp:DropDownList>
<asp:Label ID="Label8" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 10%; top: 15%; position: absolute; height: 10%; width: 7%; vertical-align:inherit; text-align: Left" Text="Keyword" ForeColor="Black"></asp:Label>        
<asp:TextBox ID="TxtKeyword" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 10%; top: 40%; position: absolute; height: 28%; width: 9%"></asp:TextBox>
<asp:Button ID="Search" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 20%; top: 40%; position: absolute; height: 35%; width: 5%;" Text="Search" />
<asp:Button ID="Export" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 26%; top: 40%; position: absolute; height: 35%; width: 5%;" Text="Export" />
<asp:Button ID="Refresh" runat="server" style="z-index: 1; Font-Size: 0.7vw; left: 32%; top: 40%; position: absolute; height: 35%; width: 5%;" Text="Refresh" />
</asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
<asp:Panel ID="Panel2" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1;Font-Size: 0.7vw; left: 10px;top: 62%;position: absolute;height: 31%;width: 98%; background-color: #FFFFFF; overflow:scroll">  
<asp:GridView ID="GridView1" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; Font-Size: 0.7vw; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
<Columns>
<asp:ButtonField HeaderText="Edit" Text="Edit" ButtonType="Image" ImageUrl="~/Images/application.png">
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
</asp:ButtonField>
</Columns>
<HeaderStyle BackColor="#FF9900"/>
</asp:GridView>
</asp:Panel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
</asp:Content>