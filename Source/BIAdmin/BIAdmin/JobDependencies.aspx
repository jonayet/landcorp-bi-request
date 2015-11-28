<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="_JobDependencies" MaintainScrollPositionOnPostback="true" Codebehind="JobDependencies.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <script src="Scripts/LU_Farms.js" type="text/javascript"></script>
    <script src="Scripts/fxHeader.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
    <script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            $(document).ready(function () {
                $('#<%= lbl_Response.ClientID %>').delay(3000).fadeOut(4000, function () {
                });
            });
        });
    </script>
    <table>
        <tr>
            <td>
                <asp:Label ID="lbl_Source" runat="server" Text="Source" CssClass="Label"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="dd_Source" runat="server" CssClass="DropdownList" OnSelectedIndexChanged="dd_Source_SelectedIndexChanged"
                    AutoPostBack="True">
                    <asp:ListItem>DEV</asp:ListItem>
                    <asp:ListItem>UAT</asp:ListItem>
                    <asp:ListItem>LIVE</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label ID="lbl_Category" runat="server" CssClass="Label" Text="Category"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="dd_Category" runat="server" CssClass="DropdownList" AutoPostBack="true"
                    OnSelectedIndexChanged="dd_Category_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td>
                <asp:CheckBox ID="cb_IncludeDisabled" runat="server" Checked="false" Text="Include Disabled"
                    AutoPostBack="true" OnCheckedChanged="cb_IncludeDisabled_CheckedChanged" />
            </td>
            <td>
                <asp:Label ID="lbl_Response" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td valign="top">
                <asp:GridView ID="gv_Jobs" runat="server" SkinID="GridViewSkin" AutoGenerateColumns="false"
                    OnRowDataBound="gv_Jobs_RowDataBound" DataKeyNames="job_id">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="hdl_JobName" runat="server" CssClass="Label" Text="Job Name"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_JobName" runat="server" CssClass="Label" Text='<%# Eval("name") %>'></asp:Label>
                                <asp:HiddenField ID="hf_enabled" runat="server" Value='<%# Eval("enabled") %>'></asp:HiddenField>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="hdl_Dependents" runat="server" CssClass="Label" Text="# Dependents"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="lb_Dependents" runat="server" CssClass="Label" Text='<%# Eval("DependenceCount") %>'
                                    ToolTip='<%# Eval("DependenceJobs") %>' OnClick="lb_Dependents_Click" ForeColor="Black"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="hdl_Dependencies" runat="server" CssClass="Label" Text="# Dependencies"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="lb_Dependencies" runat="server" CssClass="Label" Text='<%# Eval("DependentOnCount") %>'
                                    ToolTip='<%# Eval("DependentOnJobs") %>' OnClick="lb_Dependencies_Click" ForeColor="Black"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="hdl_HasStep" runat="server" CssClass="Label" Text="Has Step"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="lb_HasStep" runat="server" Checked='<%# Eval("HasStep") %>' Enabled="false">
                                </asp:CheckBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:HiddenField ID="hf_Type" runat="server" />
            </td>
            <td width="25px">
            </td>
            <td valign="top">
                <asp:Panel ID="pnl_Dependencies" runat="server" Visible="False">
                    <asp:Label ID="lbl_Dependencies" runat="server" Text="Label" CssClass="DetailsLabel"></asp:Label><br />
                    <asp:FormView ID="fv_Dependencies" runat="server">
                        <EmptyDataTemplate>
                            <asp:LinkButton ID="lb_New" runat="server" CssClass="Label" OnClick="lb_New_Click">New Dependency</asp:LinkButton>
                        </EmptyDataTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="dd_Jobs" runat="server" CssClass="DropdownList" OnLoad="dd_Jobs_Load"
                                SelectedValue='<%# Bind("job_id") %>'>
                            </asp:DropDownList>
                            <br />
                            <asp:LinkButton ID="lb_Insert" runat="server" CssClass="Label" OnClick="lb_Insert_Click">Insert</asp:LinkButton>
                            <asp:LinkButton ID="lb_Cancel" runat="server" CssClass="Label" OnClick="lb_Cancel_Click"
                                CommandName="Cancel">Cancel</asp:LinkButton>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="lb_New" runat="server" CssClass="Label" OnClick="lb_New_Click">New Dependency</asp:LinkButton>
                        </ItemTemplate>
                    </asp:FormView>
                    <br />
                    <asp:GridView ID="gv_Dependencies" runat="server" AutoGenerateColumns="false" DataKeyNames="job_id"
                        OnRowDataBound="gv_Dependencies_RowDataBound" SkinID="GridViewSkin">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lb_Delete" runat="server" CssClass="Label" Text="Delete" OnClick="lb_Delete_Click"></asp:LinkButton>
                                    <cc1:ConfirmButtonExtender ID="lb_Delete_ConfirmButtonExtender" runat="server" ConfirmText="Delete???"
                                        Enabled="True" TargetControlID="lb_Delete">
                                    </cc1:ConfirmButtonExtender>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="hdl_JobName" runat="server" CssClass="Label" Text="Job Name"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_JobName" runat="server" CssClass="Label" Text='<%# Eval("name") %>'></asp:Label>
                                    <asp:HiddenField ID="hf_enabled" runat="server" Value='<%# Eval("enabled") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
