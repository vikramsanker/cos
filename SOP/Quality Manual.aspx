<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainMasterPage.Master" CodeBehind="Quality Manual.aspx.vb" Inherits="PriceCalc.Quality_Manual" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH3" runat="server">
    <asp:Panel ID="PanelDisplay" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1;left: 25%; top: 8%;position: absolute;height: 84%; width: 73%;" oncontextmenu="return false" BackColor="White">
                   <iframe id="Displayframe" runat="server" style="width:100%; z-index: -1;height:100%">

           </iframe>  
    </asp:Panel>
    <asp:Panel ID="NavPanel" runat="server" style="border-style: groove;border-color: inherit;border-width: medium;z-index: 1;left: 10px; top: 8%;position: absolute;height: 84%; width: 23%;overflow:scroll" BackColor="White">
        <asp:TreeView ID="TreeView1" runat="server" style="z-index: 1; left: 0px; top: 0px; position: absolute; height: 553px; width: 259px" ShowLines="True">
            <Nodes>
                <asp:TreeNode Text="Standard Operating Procedures" Value="Standard Operating Procedures">
                    <asp:TreeNode Text="Quality Manual" Value="Quality Manual"></asp:TreeNode>
                    <asp:TreeNode Text="Document Control" Value="Procedure for Control of Documents"></asp:TreeNode>
                    <asp:TreeNode Text="Record Control" Value="Procedure for Control of Records"></asp:TreeNode>
                    <asp:TreeNode Text="Change Management" Value="Procedure for Change Management"></asp:TreeNode>
                    <asp:TreeNode Text="Risk Assessment" Value="Procedure for Risk Assessment and Contingency Measures"></asp:TreeNode>
                    <asp:TreeNode Text="Contingency Measures" Value="Contingency Measures"></asp:TreeNode>
                    <asp:TreeNode Text="Internal Audit" Value="Procedure for Internal Audit"></asp:TreeNode>
                    <asp:TreeNode Text="Non-Disclosure Agreement" Value="Procedure for managing confidentiality and impartiality"></asp:TreeNode>
                    <asp:TreeNode Text="Confidentiality" Value="Procedure for managing confidentiality and impartiality"></asp:TreeNode>
                    <asp:TreeNode Text="Impartiality" Value="Procedure for managing confidentiality and impartiality"></asp:TreeNode>
                    <asp:TreeNode Text="Information Systems Security" Value="Procedure for managing information systems"></asp:TreeNode>
                    <asp:TreeNode Text="Non-Conformance" Value="Procedure for nonconforming work and CAPA"></asp:TreeNode>
                    <asp:TreeNode Text="Corrective Action" Value="Procedure for nonconforming work and CAPA"></asp:TreeNode>
                    <asp:TreeNode Text="Calibration Methods" Value="Procedure for selection, verification and validation of calibration methods"></asp:TreeNode>
                    <asp:TreeNode Text="Service Realization" Value="Procedure for Service Realization"></asp:TreeNode>
                    <asp:TreeNode Text="Terms and Definitions" Value="Terms and Definitions"></asp:TreeNode>
                    <asp:TreeNode Text="Client Complaints" Value="Customer complaint handling process"></asp:TreeNode>
                    <asp:TreeNode Text="Identification" Value="Procedure for Identification and Traceability"></asp:TreeNode>
                    <asp:TreeNode Text="Traceability" Value="Procedure for Identification and Traceability"></asp:TreeNode>
                    <asp:TreeNode Text="Purchase" Value="Procedure for Purchase and Subcontract"></asp:TreeNode>
                    <asp:TreeNode Text="Subcontract" Value="Procedure for Purchase and Subcontract"></asp:TreeNode>
                    <asp:TreeNode Text="Customer Satisfaction" Value="Procedure for Customer Satisfaction and Data Analysis"></asp:TreeNode>
                    <asp:TreeNode Text="Data Analysis" Value="Procedure for Customer Satisfaction and Data Analysis"></asp:TreeNode>
                    <asp:TreeNode Text="Competency" Value="Procedure for Competency and Training"></asp:TreeNode>
                    <asp:TreeNode Text="Training & Assessment" Value="Procedure for Competency and Training"></asp:TreeNode>
                    <asp:TreeNode Text="Process Map" Value="High Level Process Map"></asp:TreeNode>
                </asp:TreeNode>
                <asp:TreeNode Text="References" Value="References">
                    <asp:TreeNode Text="Employee Handbook" Value="Caltek Employee Handbook 01-2019"></asp:TreeNode>
                    <asp:TreeNode Text="Organization Structure" Value="Organization Structure"></asp:TreeNode>
                    <asp:TreeNode Text="Strengths" Value="Strengths"></asp:TreeNode>
                    <asp:TreeNode Text="Weaknesses" Value="Weaknesses"></asp:TreeNode>
                    <asp:TreeNode Text="Opportunities" Value="Opportunities"></asp:TreeNode>
                    <asp:TreeNode Text="Threats" Value="Threats"></asp:TreeNode>
                    <asp:TreeNode Text="Process Codes" Value="Process Codes"></asp:TreeNode>
                    <asp:TreeNode Text="Specimen Signatures" Value="Specimen Signatures"></asp:TreeNode>
                </asp:TreeNode>
            </Nodes>
        </asp:TreeView>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH4" runat="server">
</asp:Content>
