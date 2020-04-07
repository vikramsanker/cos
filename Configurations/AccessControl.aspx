<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="AccessControl.aspx.vb" Inherits="PriceCalc.AccessControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
        <asp:Panel ID="Panel3" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1;left: 10px;top: 8%;position: absolute;height: 36%;width: 98%;overflow: scroll;">    
        <asp:Label ID="lblRole" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 1%; top: 15%; position: absolute; height: 15%; width: 5%; vertical-align:inherit; text-align: right" Text="Select Role" ForeColor="Black"></asp:Label>
        <asp:DropDownList runat="server" style="z-index: 1; left: 7%; top: 10%; position: absolute; width: 16%; height: 10%; bottom: 196px;" ID="TxtRole" AutoPostBack="True" AppendDataBoundItems="True">
        <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="LblScreens" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 30%; top: 3%; position: absolute; height: 15%; width: 20%; vertical-align:inherit; text-align: left" Text="List of Windows (Select appropriate to add!!)" ForeColor="Black"></asp:Label>
        <asp:Panel ID="Screenlistpanel" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1; left: 30%; top: 10%; position: absolute; height: 85%; width: 20%; overflow: scroll;background-color: #FFFFFF;">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="ScreenList" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
                        <HeaderStyle BackColor="#FF9900" Height="20px" HorizontalAlign="Center" VerticalAlign="Middle"/>
                        <alternatingrowstyle BackColor="White" ForeColor="#284775"></alternatingrowstyle>
                        <columns>
                        <asp:templatefield HeaderText="Select">
                        <itemtemplate>
                        <asp:checkbox ID="cbSelect" CssClass="gridCB" runat="server"></asp:checkbox>
                        </itemtemplate>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:templatefield>
                        </columns>
                        <SelectedRowStyle BackColor="#CCCCFF" />
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                <asp:AsyncPostBackTrigger ControlID="TxtRole" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                </Triggers>
            </asp:UpdatePanel>
        </asp:Panel>
        <asp:Label ID="LblAdded" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 57%; top: 3%; position: absolute; height: 15%; width: 20%; vertical-align:inherit; text-align: left" Text="List of Windows (Select appropriate to remove!!)" ForeColor="Black"></asp:Label>
        <asp:Button ID="AllAdd" runat="server" style="z-index: 1; left: 51%; top: 39%; height:8%; position: absolute; width: 5%" Text=">>" />
        <asp:Button ID="OneAdd" runat="server" style="z-index: 1; left: 51%; top: 49%; height:8%; position: absolute; width: 5%" Text=">" />
        <asp:Button ID="OneRemove" runat="server" style="z-index: 1; left: 51%; top: 59%; height:8%; position: absolute; width: 5%" Text="<" />
        <asp:Button ID="AllRemove" runat="server" style="z-index: 1; left: 51%; top: 69%; height:8%; position: absolute; width: 5%" Text="<<" />
        <asp:Panel ID="Addeddlistpanel" runat="server" style="border-style: groove;border-color: inherit;border-width: medium; z-index: 1; left: 57%; top: 10%; position: absolute; height: 85%; width: 20%; overflow: scroll; background-color: #FFFFFF;">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="Added" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
                        <HeaderStyle BackColor="#FF9900" Height="20px" HorizontalAlign="Center" VerticalAlign="Middle"/>
                        <alternatingrowstyle BackColor="White" ForeColor="#284775"></alternatingrowstyle>
                        <columns>
                        <asp:templatefield HeaderText="Select">
                        <itemtemplate>
                        <asp:checkbox ID="cbSelect" CssClass="gridCB" runat="server"></asp:checkbox>
                        </itemtemplate>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:templatefield>
                        </columns>
                        <SelectedRowStyle BackColor="#CCCCFF" />
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                <asp:AsyncPostBackTrigger ControlID="TxtRole" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                </Triggers>
            </asp:UpdatePanel>
        </asp:Panel>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
        <asp:Panel ID="Panel4" runat="server" style="border-style: groove; border-color: inherit; border-width: medium; z-index: 1; left: 10px; top: 45%; position: absolute; height: 10%; width: 98%;">
        <asp:Button ID="Save" runat="server" style="z-index: 1; left: 1%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Save" />
        <asp:Button ID="Export" runat="server" style="z-index: 1; left: 17%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Export" />
        <asp:Button ID="Clear" runat="server" style="z-index: 1; left: 9%; top: 30%; position: absolute; height: 40%; width: 7%;" Text="Clear" />
        <asp:Label ID="COSkey" runat="server" style="z-index: 1; Font-Size: 0.7vw; right: 1%; top: 30%; position: absolute; height: 40%; width: 7%;" ForeColor="#87CEEC"></asp:Label>
        </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
        <asp:Panel ID="Panel5" runat="server" BorderStyle="None" style="z-index: 1; left: 10px; top: 56%; position: absolute; height: 5%; width: 98%">
        <asp:TextBox ID="Searchbox" runat="server" style="z-index: 1; left: 5%; top: 3px; position: absolute; width: 24%; height: 89%; background-color: #E9E9E9;" BackColor="#FCF5D8" BorderStyle="Solid"></asp:TextBox>
        <asp:Label ID="Label11" runat="server" Font-Names="Arial" style="z-index: 1; Font-Size: 0.7vw; left: 0%; top: 45%; position: absolute; width: 4%; text-align: Left; vertical-align: inherit; right: 1167px;" Text="Search: "></asp:Label>
        <asp:Button ID="SearchButton" runat="server" style="z-index: 1; left: 32%; top: 10%; height:80%; width: 7%; position: absolute" Text="Find" />
        <asp:Label ID="LblCount" runat="server" style="z-index: 2; Font-Size: 0.7vw; right: 4px; bottom: 5%; position: absolute; width: 23%; height: 25%; text-align: right;" Text="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Black"></asp:Label>
        </asp:Panel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
        <asp:Panel ID="Panel6" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1;left: 10px;top: 62%; position: absolute;height: 31%; width: 98%;background-color: #FFFFFF; overflow:scroll">
        <asp:GridView ID="GridView1" runat="server" BorderStyle="Solid" Font-Names="Arial" style="border-style: groove; border-color: inherit; border-width: thin; z-index: -1; left: 12px; width: 100%;top: 5%;" CellPadding="5" ShowHeaderWhenEmpty="True" ForeColor="Black">
        <HeaderStyle BackColor="#FF9900"/>
        </asp:GridView>
        </asp:Panel>
</asp:Content>