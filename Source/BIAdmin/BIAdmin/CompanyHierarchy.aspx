<%@ Page Title="Company Hierarchy" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="_CompanyHierarchy" Codebehind="CompanyHierarchy.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:LinkButton ID="lb_CollapseAll" runat="server" Text="Collapse All" CssClass="Label"
        OnClick="lb_CollapseAll_Click"></asp:LinkButton>
    <asp:LinkButton ID="lb_ExpandAll" runat="server" Text="Expand All" CssClass="Label"
        OnClick="lb_ExpandAll_Click"></asp:LinkButton>
    <asp:TreeView ID="tv_CompanyHierarchy" runat="server" CssClass="HierarchytreeView"
        OnTreeNodePopulate="tv_CompanyHierarchy_TreeNodePopulate" ShowLines="True" Target="_blank">
        <NodeStyle HorizontalPadding="3px" NodeSpacing="1px" ForeColor="Black" />
        <ParentNodeStyle HorizontalPadding="3px" NodeSpacing="1px" ForeColor="Black" />
        <HoverNodeStyle ForeColor="DimGray" />
    </asp:TreeView>
</asp:Content>
