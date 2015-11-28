<%@ Page Title="USP Differences" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="_USPDifferences" Codebehind="USPDifferences.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <table>
        <tr>
            <td valign="top">
                <asp:Panel ID="pnl_Source" runat="server" CssClass="FVPanel">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_SourceServer" runat="server" CssClass="Label" Text="Source Server:"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="dd_SourceServer" runat="server" CssClass="DropdownList" AutoPostBack="True"
                                    OnSelectedIndexChanged="dd_SourceServer_SelectedIndexChanged">
                                    <asp:ListItem>SQL-DW1</asp:ListItem>
                                    <asp:ListItem>RPT-PW1</asp:ListItem>
                                    <asp:ListItem>SQL-UW1</asp:ListItem>
                                    <asp:ListItem>SQL-PW4</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_SourceDatabase" runat="server" CssClass="Label" Text="Source Database:"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="dd_SourceDatabase" runat="server" CssClass="DropdownList" AutoPostBack="True"
                                    OnSelectedIndexChanged="dd_SourceDatabase_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_SourceStoredProcedure" runat="server" CssClass="Label" Text="Source USP:"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="dd_SourceStoredProcedure" runat="server" CssClass="DropdownList"
                                    AutoPostBack="True" OnSelectedIndexChanged="dd_SourceStoredProcedure_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="pnl_SourceDefinition" runat="server" CssClass="FVPanel" 
                        Width="500px">
                        <asp:Literal ID="ltl_SourceDefinition" runat="server"></asp:Literal>
                    </asp:Panel>
                </asp:Panel>
            </td>
            <td width="25px">
            </td>
            <td valign="top">
                <asp:Panel ID="pnl_Compare" runat="server" CssClass="FVPanel">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_CompareServer" runat="server" CssClass="Label" Text="Compare Server:"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="dd_CompareServer" runat="server" CssClass="DropdownList" AutoPostBack="True"
                                    OnSelectedIndexChanged="dd_CompareServer_SelectedIndexChanged">
                                    <asp:ListItem>RPT-PW1</asp:ListItem>
                                    <asp:ListItem>SQL-DW1</asp:ListItem>
                                    <asp:ListItem>SQL-UW1</asp:ListItem>
                                    <asp:ListItem>SQL-PW4</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_CompareDatabase" runat="server" CssClass="Label" Text="Compare Database:"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="dd_CompareDatabase" runat="server" CssClass="DropdownList"
                                    AutoPostBack="True" OnSelectedIndexChanged="dd_CompareDatabase_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_CompareStoredProcedure" runat="server" CssClass="Label" Text="Compare USP:"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="dd_CompareStoredProcedure" runat="server" CssClass="DropdownList"
                                    AutoPostBack="True" OnSelectedIndexChanged="dd_CompareStoredProcedure_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="pnl_CompareDefinition" runat="server" CssClass="FVPanel" 
                        Width="500px">
                        <asp:Literal ID="ltl_CompareDefinition" runat="server"></asp:Literal>
                    </asp:Panel>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
