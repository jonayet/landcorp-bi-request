<%@ Page Title="Applications" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="True"
    Inherits="_Applications" MaintainScrollPositionOnPostback="true" CodeBehind="Applications.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    </asp:ScriptManagerProxy>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
    <script type="text/javascript">
        window.onresize = function () {
            autoResize();
        }
        function pageLoad(sender, args) {
            $(document).ready(function () {
                autoResize();
            });
        }

        function autoResize() {
            var newheight;
            var newwidth;

            if (document.getElementById) {
                newheight = $(window).height() - 175;
                newwidth = $(window).width() - 460;
            }

            var iFrame = document.getElementById('<%= myIframe.ClientID %>')
            if (iFrame) {
                iFrame.height = (newheight) + "px";
                iFrame.width = (newwidth) + "px";
            }
        }

        function AreYouSure() {
            return confirm('Are you sure???');
        }

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
                    <asp:ListItem>LIVE</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnl_Applications" runat="server" CssClass="FVPanel" ScrollBars="Auto">
        <table>
            <tr>
                <td valign="top">
                    <asp:Label ID="lbl_Applications" runat="server" CssClass="DateLabel" Text="Applications"></asp:Label>
                    <br />
                    <asp:FormView ID="fv_Applications" runat="server" DataKeyNames="AppId" DataSourceID="ds_Applications"
                        OnModeChanged="fv_Applications_ModeChanged">
                        <EmptyDataTemplate>
                            <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CommandName="New"
                                Text="New Application" CssClass="Label" />
                        </EmptyDataTemplate>
                        <InsertItemTemplate>
                            <asp:Panel ID="pnl_New" runat="server" CssClass="FVPanel">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label31" runat="server" CssClass="Label" Text="Name:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txb_AppName" runat="server" CssClass="Textbox" Text='<%# Bind("AppName") %>'
                                                Width="150px" CausesValidation="True" ValidationGroup="NewApplication" MaxLength="50" />
                                            <asp:RequiredFieldValidator ID="rf_AppName" runat="server" ControlToValidate="txb_AppName"
                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="NewApplication"></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="cv_AppName" runat="server" ControlToValidate="txb_AppName"
                                                Display="Dynamic" ErrorMessage="Already used!!!" ForeColor="Red" OnServerValidate="cv_AppName_ServerValidate"
                                                SetFocusOnError="True" ValidationGroup="NewApplication"></asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label32" runat="server" CssClass="Label" Text="URL:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txb_AppURL" runat="server" CausesValidation="True" CssClass="Textbox"
                                                MaxLength="255" Text='<%# Bind("AppURL") %>' ValidationGroup="NewApplication"
                                                Width="150px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" CssClass="Label" Text="Uses Farms:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="cb_UsesFarms" runat="server" Checked='<%# Bind("UsesFarms") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label7" runat="server" CssClass="Label" Text="Online:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="cb_AppOnline" runat="server" Checked='<%# Bind("AppOnline") %>' />
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:ImageButton ID="ib_Save" runat="server" CausesValidation="True" CommandName="Insert"
                                                Height="16px" Width="16px" ValidationGroup="NewApplication" ImageUrl="~/Images/Save.png"
                                                ToolTip="Insert" />
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="ib_Cancel" runat="server" CommandName="Cancel" Height="16px"
                                                Width="16px" ImageUrl="~/Images/Cancel.png" ToolTip="Cancel" CausesValidation="false" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CommandName="New"
                                Text="New Application" CssClass="Label" />
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:GridView ID="gv_Applications" runat="server" AutoGenerateColumns="False" DataKeyNames="AppId"
                        DataSourceID="ds_Applications" OnRowEditing="gv_Applications_RowEditing" OnSelectedIndexChanged="gv_Applications_SelectedIndexChanged"
                        SkinID="GridViewSkin" AllowSorting="True">
                        <Columns>
                            <asp:TemplateField HeaderText="Name" SortExpression="AppName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txb_AppName" runat="server" CausesValidation="True" CssClass="Textbox"
                                        MaxLength="50" Text='<%# Bind("AppName") %>' ValidationGroup="Edit" Width="150px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rf_AppName" runat="server" ControlToValidate="txb_AppName"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cv_AppName" runat="server" ControlToValidate="txb_AppName"
                                        Display="Dynamic" ErrorMessage="Already used!!!" ForeColor="Red" OnServerValidate="cv_AppName_ServerValidate"
                                        SetFocusOnError="True" ValidationGroup="Edit"></asp:CustomValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lb_Select" runat="server" CausesValidation="False" CommandName="Select"
                                        CssClass="Label" Text='<%# Eval("AppName") %>'></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle VerticalAlign="Middle" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Id" SortExpression="AppId">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_AppId" runat="server" Text='<%# Eval("AppId") %>' CssClass="Label"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle VerticalAlign="Middle" HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="URL" SortExpression="AppURL">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hpl_AppURL" runat="server" NavigateUrl='<%# Eval("AppURL") %>'
                                        Target="_blank" Text='<%# Eval("AppURL") %>'></asp:HyperLink>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txb_AppURL" runat="server" CausesValidation="True" CssClass="Textbox"
                                        MaxLength="255" Text='<%# Bind("AppURL") %>' ValidationGroup="Edit" Width="150px" />
                                </EditItemTemplate>
                                <ItemStyle VerticalAlign="Middle" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Uses Farms" SortExpression="UsesFarms">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cb_UsesFarms" runat="server" Checked='<%# Eval("UsesFarms") %>'
                                        Enabled="False" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="cb_UsesFarms" runat="server" Checked='<%# Bind("UsesFarms") %>' />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Online" SortExpression="AppOnline">
<%--                                <ItemTemplate>
                                    <asp:CheckBox ID="cb_AppOnline" runat="server" Checked='<%# Eval("AppOnline") %>'
                                        Enabled="False" />
                                </ItemTemplate>--%>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="cb_AppOnline" runat="server" Checked='<%# Bind("AppOnline") %>' />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <table class="NoBorder">
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="ib_Edit" runat="server" CommandName="Edit" Height="14px" ImageUrl="~/Images/Edit.png"
                                                    ToolTip="Edit" CausesValidation="false" />
                                            </td>
                                            <td>
                                                <asp:ImageButton ID="ib_Delete" runat="server" CommandName="Delete" Height="14px"
                                                    ImageUrl="~/Images/Delete.png" ToolTip="Delete" OnClientClick="return AreYouSure();" CausesValidation="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <table class="NoBorder">
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="ib_Update" runat="server" CommandName="Update" Height="16px"
                                                    Width="16px" ImageUrl="~/Images/Save.png" ToolTip="Save" CausesValidation="true" ValidationGroup="Edit" />
                                            </td>
                                            <td>
                                                <asp:ImageButton ID="ib_Cancel" runat="server" CommandName="Cancel" Height="16px"
                                                    Width="16px" ImageUrl="~/Images/Cancel.png" ToolTip="Cancel" CausesValidation="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="ds_Applications" runat="server" ConnectionString="<%$ ConnectionStrings:AdminDEV %>"
                        InsertCommand="wsp_Application_Add" ProviderName="<%$ ConnectionStrings:AdminDEV.ProviderName %>"
                        SelectCommand="wsp_Application_Get" UpdateCommand="wsp_Application_Update" InsertCommandType="StoredProcedure"
                        SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" DeleteCommand="wsp_Application_Delete"
                        DeleteCommandType="StoredProcedure" >
                        <DeleteParameters>
                            <asp:Parameter Name="AppId" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="AppName" Type="String" />
                            <asp:Parameter Name="AppURL" Type="String" />
                            <asp:Parameter Name="UsesFarms" Type="Boolean" />
                            <asp:Parameter Name="AppOnline" Type="Boolean" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="AppId" Type="Int32" />
                            <asp:Parameter Name="AppName" Type="String" />
                            <asp:Parameter Name="AppURL" Type="String" />
                            <asp:Parameter Name="UsesFarms" Type="Boolean" />
                            <asp:Parameter Name="AppOnline" Type="Boolean" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="hf_UsesFarms" runat="server" Value="false" />
                </td>
                <td style="width: 5px">
                </td>
                <td valign="top">
                    <asp:Panel ID="pnl_Single" runat="server" CssClass="FVPanel" Visible="False">
                        <cc1:TabContainer ID="tc_Application" runat="server" ActiveTabIndex="0" CssClass="Tab">
                            <cc1:TabPanel ID="tp_UserTypes" runat="server" HeaderText="User Types">
                                <ContentTemplate>
                                    <asp:Panel ID="pnl_RegChargeCodes" runat="server" CssClass="FVPanel" ScrollBars="Auto">
                                        <asp:Label ID="lbl_AppUserTypes" runat="server" CssClass="DateLabel" Text="User Types"></asp:Label>
                                        <br />
                                        <asp:FormView ID="fv_AppUserTypes" runat="server" DataKeyNames="UserTypeId" DataSourceID="ds_AppUserTypes"
                                            OnModeChanged="fv_AppUserTypes_ModeChanged" OnDataBound="fv_AppUserTypes_DataBound">
                                            <EmptyDataTemplate>
                                                <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CommandName="New"
                                                    Text="New User Type" CssClass="Label" />
                                            </EmptyDataTemplate>
                                            <InsertItemTemplate>
                                                <asp:Panel ID="pnl_New" runat="server" CssClass="FVPanel">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label31" runat="server" CssClass="Label" Text="User Type:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txb_UserType" runat="server" CssClass="Textbox" Text='<%# Bind("UserType") %>'
                                                                    Width="100px" ValidationGroup="NewUserType" />
                                                                <asp:RequiredFieldValidator ID="rf_UserType" runat="server" ControlToValidate="txb_UserType"
                                                                    ValidationGroup="NewUserType" Display="Dynamic" ErrorMessage="*" ForeColor="Red"
                                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr id="tr_IsFinAdminUser" runat="server">
                                                            <td>
                                                                <asp:Label ID="Label5" runat="server" CssClass="Label" Text="FIN Admin User:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox ID="cb_IsFinAdminUser" runat="server" Checked='<%# Bind("IsFinAdminUser") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label32" runat="server" CssClass="Label" Text="Admin User:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox ID="cb_IsAdminUser" runat="server" Checked='<%# Bind("IsAdminUser") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label3" runat="server" CssClass="Label" Text="Office User:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox ID="cb_IsOfficeUser" runat="server" Checked='<%# Bind("IsOfficeUser") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr id="tr_IsFarmUser" runat="server">
                                                            <td>
                                                                <asp:Label ID="Label1" runat="server" CssClass="Label" Text="Farm User:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox ID="cb_IsFarmUser" runat="server" Checked='<%# Bind("IsFarmUser") %>'
                                                                    OnLoad="cb_IsFarmUser_Load" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label2" runat="server" CssClass="Label" Text="Read Only User:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox ID="cb_IsReadOnlyUser" runat="server" Checked='<%# Bind("IsReadOnlyUser") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label6" runat="server" CssClass="Label" Text="App Owner User:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox ID="cb_IsAppOwnerUser" runat="server" Checked='<%# Bind("IsAppOwnerUser") %>' />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:ImageButton ID="ib_Save" runat="server" CausesValidation="True" CommandName="Insert"
                                                                    Height="16px" Width="16px" ValidationGroup="NewUserType" ImageUrl="~/Images/Save.png"
                                                                    ToolTip="Insert" />
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ID="ib_Cancel" runat="server" CommandName="Cancel" Height="16px"
                                                                    Width="16px" ImageUrl="~/Images/Cancel.png" ToolTip="Cancel" CausesValidation="false" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CommandName="New"
                                                    Text="New User Type" CssClass="Label" />
                                            </ItemTemplate>
                                        </asp:FormView>
                                        <asp:GridView ID="gv_AppUserTypes" runat="server" AutoGenerateColumns="False" DataKeyNames="UserTypeId"
                                            DataSourceID="ds_AppUserTypes" OnRowEditing="gv_AppUserTypes_RowEditing" OnSelectedIndexChanged="gv_AppUserTypes_SelectedIndexChanged"
                                            SkinID="GridViewSkin" AllowSorting="True" OnRowCreated="gv_AppUserTypes_RowCreated">
                                            <Columns>
                                                <asp:TemplateField HeaderText="User Type" SortExpression="UserType">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txb_UserType" runat="server" CssClass="Textbox" Text='<%# Bind("UserType") %>'
                                                            Width="200px" ValidationGroup="EditUserTypes"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rf_AppName" runat="server" ControlToValidate="txb_UserType"
                                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="EditUserTypes"></asp:RequiredFieldValidator>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_UserType" runat="server" Text='<%# Eval("UserType") %>' CssClass="Label"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FIN Admin User" SortExpression="IsFinAdminUser">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cb_IsFinAdminUser" runat="server" Checked='<%# Eval("IsFinAdminUser") %>'
                                                            Enabled="False" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="cb_IsFinAdminUser" runat="server" Checked='<%# Bind("IsFinAdminUser") %>' />
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Admin User" SortExpression="IsAdminUser">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cb_IsAdminUser" runat="server" Checked='<%# Eval("IsAdminUser") %>'
                                                            Enabled="False" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="cb_IsAdminUser" runat="server" Checked='<%# Bind("IsAdminUser") %>' />
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Office User" SortExpression="IsOfficeUser">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cb_IsOfficeUser" runat="server" Checked='<%# Eval("IsOfficeUser") %>'
                                                            Enabled="False" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="cb_IsOfficeUser" runat="server" Checked='<%# Bind("IsOfficeUser") %>' />
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Farm User" SortExpression="IsFarmUser">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cb_IsFarmUser" runat="server" Checked='<%# Eval("IsFarmUser") %>'
                                                            Enabled="False" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="cb_IsFarmUser" runat="server" Checked='<%# Bind("IsFarmUser") %>'
                                                            OnLoad="cb_IsFarmUser_Load" />
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Read Only User" SortExpression="IsReadOnlyUser">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cb_IsReadOnlyUser" runat="server" Checked='<%# Eval("IsReadOnlyUser") %>'
                                                            Enabled="False" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="cb_IsReadOnlyUser" runat="server" Checked='<%# Bind("IsReadOnlyUser") %>' />
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="App Owner User" SortExpression="IsAppOwnerUser">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cb_IsAppOwnerUser" runat="server" Checked='<%# Eval("IsAppOwnerUser") %>'
                                                            Enabled="False" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="cb_IsAppOwnerUser" runat="server" Checked='<%# Bind("IsAppOwnerUser") %>' />
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <table class="NoBorder">
                                                            <tr>
                                                                <td>
                                                                    <asp:ImageButton ID="ib_Edit" runat="server" CommandName="Edit" Height="14px" ImageUrl="~/Images/Edit.png"
                                                                        ToolTip="Edit" Visible='<%# Eval("CanEdit") %>' CausesValidation="false" />
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="ib_Delete" runat="server" CommandName="Delete" Height="14px"
                                                                        ImageUrl="~/Images/Delete.png" ToolTip="Delete" OnClientClick="return AreYouSure();"
                                                                        Visible='<%# Eval("CanEdit") %>' CausesValidation="false" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table class="NoBorder">
                                                            <tr>
                                                                <td>
                                                                    <asp:ImageButton ID="ib_Update" runat="server" CommandName="Update" Height="16px"
                                                                        Width="16px" ImageUrl="~/Images/Save.png" ToolTip="Save" CausesValidation="true"  ValidationGroup="EditUserTypes" />
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="ib_Cancel" runat="server" CommandName="Cancel" Height="16px"
                                                                        Width="16px" ImageUrl="~/Images/Cancel.png" ToolTip="Cancel" CausesValidation="false" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="ds_AppUserTypes" runat="server" ConnectionString="<%$ ConnectionStrings:AdminDEV %>"
                                            DeleteCommand="wsp_AppUserTypes_Delete" InsertCommand="wsp_AppUserTypes_Add"
                                            ProviderName="<%$ ConnectionStrings:AdminDEV.ProviderName %>" SelectCommand="wsp_AppUserTypes_Get"
                                            UpdateCommand="wsp_AppUserTypes_Update" InsertCommandType="StoredProcedure" SelectCommandType="StoredProcedure"
                                            UpdateCommandType="StoredProcedure" DeleteCommandType="StoredProcedure" >
                                            <DeleteParameters>
                                                <asp:Parameter Name="UserTypeId" Type="Int32" />
                                            </DeleteParameters>
                                            <InsertParameters>
                                                <asp:ControlParameter ControlID="gv_Applications" Name="AppId" PropertyName="SelectedValue" />
                                                <asp:Parameter Name="UserType" Type="String" />
                                                <asp:Parameter Name="IsFinAdminUser" Type="Boolean" />
                                                <asp:Parameter Name="IsAdminUser" Type="Boolean" />
                                                <asp:Parameter Name="IsOfficeUser" Type="Boolean" />
                                                <asp:Parameter Name="IsFarmUser" Type="Boolean" />
                                                <asp:Parameter Name="IsReadOnlyUser" Type="Boolean" />
                                            </InsertParameters>
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="gv_Applications" Name="AppId" PropertyName="SelectedValue" />
                                                <asp:Parameter DefaultValue="false" Name="IncludeNULLHeader" Type="Boolean" />
                                                <asp:Parameter DefaultValue="false" Name="IncludeSelectAll" Type="Boolean" />
                                            </SelectParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="UserTypeId" Type="Int32" />
                                                <asp:Parameter Name="UserType" Type="String" />
                                                <asp:Parameter Name="IsFinAdminUser" Type="Boolean" />
                                                <asp:Parameter Name="IsAdminUser" Type="Boolean" />
                                                <asp:Parameter Name="IsOfficeUser" Type="Boolean" />
                                                <asp:Parameter Name="IsFarmUser" Type="Boolean" />
                                                <asp:Parameter Name="IsReadOnlyUser" Type="Boolean" />
                                            </UpdateParameters>
                                        </asp:SqlDataSource>
                                    </asp:Panel>
                                </ContentTemplate>
                            </cc1:TabPanel>
                            <cc1:TabPanel ID="tp_AccessTypes" runat="server" HeaderText="Farm Access Types">
                                <ContentTemplate>
                                    <asp:Panel ID="pnl_AccessTypes" runat="server" CssClass="FVPanel" ScrollBars="Auto">
                                        <asp:Label ID="lbl_AccessTypes" runat="server" CssClass="DateLabel" Text="Farm Access Types"></asp:Label>
                                        <br />
                                        <asp:FormView ID="fv_AccessTypes" runat="server" DataKeyNames="AppAccessTypeId" DataSourceID="ds_AccessTypes"
                                            OnModeChanged="fv_AccessTypes_ModeChanged">
                                            <EmptyDataTemplate>
                                                <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CommandName="New"
                                                    Text="New Farm Access Type" CssClass="Label" />
                                            </EmptyDataTemplate>
                                            <InsertItemTemplate>
                                                <asp:Panel ID="pnl_New" runat="server" CssClass="FVPanel">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label31" runat="server" CssClass="Label" Text="Farm Access Type:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="dd_AccessTypeId" runat="server" CssClass="DropdownList" DataSourceID="ds_AccessTypesAll"
                                                                    ValidationGroup="NewAccessType" DataTextField="AccessType" DataValueField="AccessTypeId"
                                                                    SelectedValue='<%# Bind("AccessTypeId") %>'>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ID="ib_Save" runat="server" CausesValidation="True" CommandName="Insert"
                                                                    Height="16px" Width="16px" ValidationGroup="NewAccessType" ImageUrl="~/Images/Save.png"
                                                                    ToolTip="Insert" />
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ID="ib_Cancel" runat="server" CommandName="Cancel" Height="16px"
                                                                    Width="16px" ImageUrl="~/Images/Cancel.png" ToolTip="Cancel" CausesValidation="false" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CommandName="New"
                                                    Text="New Farm Access Type" CssClass="Label" />
                                            </ItemTemplate>
                                        </asp:FormView>
                                        <asp:GridView ID="gv_AccessTypes" runat="server" AutoGenerateColumns="False" DataKeyNames="AppAccessTypeId"
                                            DataSourceID="ds_AccessTypes" OnRowEditing="gv_AccessTypes_RowEditing" SkinID="GridViewSkin"
                                            AllowSorting="True">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Farm Access Type" SortExpression="AccessType">
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="dd_AccessTypeId" runat="server" CssClass="DropdownList" DataSourceID="ds_AccessTypesAll"
                                                            ValidationGroup="NewAccessType" DataTextField="AccessType" DataValueField="AccessTypeId"
                                                            SelectedValue='<%# Bind("AccessTypeId") %>'>
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_AccessType" runat="server" Text='<%# Eval("AccessType") %>' CssClass="Label"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <table class="NoBorder">
                                                            <tr>
                                                                <td>
                                                                    <asp:ImageButton ID="ib_Edit" runat="server" CommandName="Edit" Height="14px" ImageUrl="~/Images/Edit.png"
                                                                        ToolTip="Edit" CausesValidation="false" />
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="ib_Delete" runat="server" CommandName="Delete" Height="14px"
                                                                        ImageUrl="~/Images/Delete.png" ToolTip="Delete" OnClientClick="return AreYouSure();" CausesValidation="false" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table class="NoBorder">
                                                            <tr>
                                                                <td>
                                                                    <asp:ImageButton ID="ib_Update" runat="server" CommandName="Update" Height="16px"
                                                                        Width="16px" CausesValidation="true" ValidationGroup="NewAccessType" ImageUrl="~/Images/Save.png"
                                                                        ToolTip="Save" />
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="ib_Cancel" runat="server" CommandName="Cancel" Height="16px"
                                                                        Width="16px" ImageUrl="~/Images/Cancel.png" ToolTip="Cancel" CausesValidation="false" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="ds_AccessTypes" runat="server" ConnectionString="<%$ ConnectionStrings:Admin %>"
                                            ProviderName="<%$ ConnectionStrings:Admin.ProviderName %>" SelectCommand="wsp_AppAccessFarmTypes_Get"
                                            SelectCommandType="StoredProcedure" InsertCommand="wsp_AppAccessFarmTypes_Add"
                                            InsertCommandType="StoredProcedure" DeleteCommand="wsp_AppAccessFarmTypes_Delete"
                                            DeleteCommandType="StoredProcedure" UpdateCommand="wsp_AppAccessFarmTypes_Update"
                                            UpdateCommandType="StoredProcedure" >
                                            <DeleteParameters>
                                                <asp:Parameter Name="AppAccessTypeId" Type="Int32" />
                                            </DeleteParameters>
                                            <InsertParameters>
                                                <asp:ControlParameter ControlID="gv_Applications" Name="AppId" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:Parameter Name="AccessTypeId" Type="Int32" />
                                            </InsertParameters>
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="gv_Applications" Name="AppId" PropertyName="SelectedValue" />
                                            </SelectParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="AppAccessTypeId" Type="Int32" />
                                                <asp:ControlParameter ControlID="gv_Applications" Name="AppId" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:Parameter Name="AccessTypeId" Type="Int32" />
                                            </UpdateParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="ds_AccessTypesAll" runat="server" ConnectionString="<%$ ConnectionStrings:Admin %>"
                                            ProviderName="<%$ ConnectionStrings:Admin.ProviderName %>" SelectCommand="wsp_AppAccessFarmTypes_Get"
                                            SelectCommandType="StoredProcedure" >
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="0" Name="AppId" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </asp:Panel>
                                </ContentTemplate>
                            </cc1:TabPanel>
                            <cc1:TabPanel ID="tp_Pages" runat="server" HeaderText="Pages">
                                <ContentTemplate>
                                    <asp:Panel ID="pnl_Pages" runat="server" CssClass="FVPanel">
                                        <table>
                                            <tr>
                                                <td valign="top">
                                                    <asp:Label ID="lbl_PagesHeader" runat="server" CssClass="DateLabel" Text="Pages"></asp:Label>
                                                    <br />
                                                    <asp:FormView ID="fv_ApplicationPages" runat="server" DataKeyNames="AppPageId" DataSourceID="ds_ApplicationPages"
                                                        OnModeChanged="fv_ApplicationPages_ModeChanged">
                                                        <EmptyDataTemplate>
                                                            <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CommandName="New"
                                                                CssClass="Label" Text="New Page" />
                                                        </EmptyDataTemplate>
                                                        <InsertItemTemplate>
                                                            <asp:Panel ID="pnl_New" runat="server" CssClass="FVPanel">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lbl_Title" runat="server" CssClass="Label" Text="Title:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txb_Title" runat="server" CausesValidation="True" CssClass="Textbox"
                                                                                MaxLength="50" Text='<%# Bind("Title") %>' ValidationGroup="NewPage" Width="100px" />
                                                                            <asp:RequiredFieldValidator ID="rf_txb_Title" runat="server" ControlToValidate="txb_Title"
                                                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="NewPage"></asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lbl_URL" runat="server" CssClass="Label" Text="URL:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txb_URL" runat="server" CausesValidation="True" CssClass="Textbox"
                                                                                MaxLength="255" Text='<%# Bind("URL") %>' ValidationGroup="NewPage" Width="150px" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label35" runat="server" CssClass="Label" Text="Parent:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="dd_ParentId" runat="server" CssClass="DropdownList" DataSourceID="ds_ApplicationPagesDD"
                                                                                DataTextField="Title" DataValueField="AppPageId" SelectedValue='<%# Bind("ParentId") %>'
                                                                                ValidationGroup="NewPage">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lbl_OrderId" runat="server" CssClass="Label" Text="Order:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txb_OrderId" runat="server" CausesValidation="True" CssClass="TextboxRight"
                                                                                Text='<%# Bind("OrderId") %>' ValidationGroup="NewPage" Width="50px" />
                                                                            <asp:RequiredFieldValidator ID="rf_txb_OrderId" runat="server" ControlToValidate="txb_OrderId"
                                                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="NewPage"></asp:RequiredFieldValidator>
                                                                            <asp:CompareValidator ID="cmp_txb_OrderId" runat="server" ControlToValidate="txb_OrderId"
                                                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                                                                                Type="Integer" ValidationGroup="NewPage"></asp:CompareValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lbl_Hidden" runat="server" CssClass="Label" Text="Hidden:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBox ID="cb_Hidden" runat="server" Checked='<%# Bind("Hidden") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lbl_ShowRibbon" runat="server" CssClass="Label" Text="Show Ribbon:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBox ID="cb_ShowRibbon" runat="server" Checked='<%# Bind("ShowRibbon") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lbl_ShowNavigation" runat="server" CssClass="Label" Text="Show Navigation:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBox ID="cb_ShowNavigation" runat="server" Checked='<%# Bind("ShowNavigation") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lbl_HeadingApp" runat="server" CssClass="Label" Text="Show App Name:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBox ID="cb_HeadingApp" runat="server" Checked='<%# Bind("HeadingApp") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lbl_HeadingPageTitle" runat="server" CssClass="Label" Text="Show Page Title:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBox ID="cb_HeadingPageTitle" runat="server" Checked='<%# Bind("HeadingPageTitle") %>' />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:ImageButton ID="ib_Save" runat="server" CausesValidation="True" CommandName="Insert"
                                                                                Height="16px" Width="16px" ValidationGroup="NewPage" ImageUrl="~/Images/Save.png"
                                                                                ToolTip="Insert" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:ImageButton ID="ib_Cancel" runat="server" CommandName="Cancel" Height="16px"
                                                                                Width="16px" ImageUrl="~/Images/Cancel.png" ToolTip="Cancel" CausesValidation="false" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </InsertItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CommandName="New"
                                                                CssClass="Label" Text="New Page" />
                                                        </ItemTemplate>
                                                    </asp:FormView>
                                                    <asp:GridView ID="gv_ApplicationPages" runat="server" AutoGenerateColumns="False"
                                                        DataKeyNames="AppPageId" DataSourceID="ds_ApplicationPages" AllowSorting="True"
                                                        SkinID="GridViewSkin" OnRowEditing="gv_ApplicationPages_RowEditing" OnSelectedIndexChanged="gv_ApplicationPages_SelectedIndexChanged">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Title" SortExpression="Title">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txb_Title" runat="server" Text='<%# Bind("Title") %>' CssClass="Textbox"
                                                                        Width="100px" MaxLength="50" ValidationGroup="EditPage"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rf_txb_Title" runat="server" ControlToValidate="txb_Title"
                                                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="EditPage"></asp:RequiredFieldValidator>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lb_Title" runat="server" CausesValidation="False" CommandName="Select"
                                                                        Text='<%# Eval("Title") %>' CssClass="Label"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="URL" SortExpression="URL">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txb_URL" runat="server" CssClass="Textbox" Text='<%# Bind("URL") %>'
                                                                        Width="150px" MaxLength="255" ValidationGroup="EditPage"></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="hpl_FullURL" runat="server" NavigateUrl='<%# Eval("FullURL") %>'
                                                                        Target="_blank" Text='<%# Eval("URL") %>'></asp:HyperLink>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Parent" SortExpression="ParentName">
                                                                <EditItemTemplate>
                                                                    <asp:DropDownList ID="dd_ParentId" runat="server" CssClass="DropdownList" DataSourceID="ds_ApplicationPagesDD"
                                                                        DataTextField="Title" DataValueField="AppPageId" SelectedValue='<%# Bind("ParentId") %>'
                                                                        ValidationGroup="EditPage">
                                                                    </asp:DropDownList>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbl_ParentName" runat="server" CssClass="Label" Text='<%# Eval("ParentName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Order" SortExpression="OrderId">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txb_OrderId" runat="server" CausesValidation="True" CssClass="TextboxRight"
                                                                        Text='<%# Bind("OrderId") %>' ValidationGroup="EditPage" Width="50px"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rf_txb_OrderId" runat="server" ControlToValidate="txb_OrderId"
                                                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="EditPage"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="cmp_txb_OrderId" runat="server" ControlToValidate="txb_OrderId"
                                                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                                                                        Type="Integer" ValidationGroup="EditPage"></asp:CompareValidator>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbl_OrderId" runat="server" CssClass="Label" Text='<%# Eval("OrderId") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Hidden" SortExpression="Hidden">
                                                                <EditItemTemplate>
                                                                    <asp:CheckBox ID="cb_Hidden" runat="server" Checked='<%# Bind("Hidden") %>' />
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="cb_Hidden" runat="server" Checked='<%# Eval("Hidden") %>' Enabled="false" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            
                                                            <asp:TemplateField HeaderText="Show Ribbon" SortExpression="ShowRibbon">
                                                                <EditItemTemplate>
                                                                    <asp:CheckBox ID="cb_ShowRibbon" runat="server" Checked='<%# Bind("ShowRibbon") %>' />
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="cb_ShowRibbon" runat="server" Checked='<%# Eval("ShowRibbon") %>' Enabled="false" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            
                                                            <asp:TemplateField HeaderText="Show Navigation" SortExpression="ShowNavigation">
                                                                <EditItemTemplate>
                                                                    <asp:CheckBox ID="cb_ShowNavigation" runat="server" Checked='<%# Bind("ShowNavigation") %>' />
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="cb_ShowNavigation" runat="server" Checked='<%# Eval("ShowNavigation") %>' Enabled="false" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            
                                                            <asp:TemplateField HeaderText="Show App Name" SortExpression="HeadingApp">
                                                                <EditItemTemplate>
                                                                    <asp:CheckBox ID="cb_HeadingApp" runat="server" Checked='<%# Bind("HeadingApp") %>' />
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="cb_HeadingApp" runat="server" Checked='<%# Eval("HeadingApp") %>' Enabled="false" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            
                                                            <asp:TemplateField HeaderText="Show Page Title" SortExpression="HeadingPageTitle">
                                                                <EditItemTemplate>
                                                                    <asp:CheckBox ID="cb_HeadingPageTitle" runat="server" Checked='<%# Bind("HeadingPageTitle") %>' />
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="cb_HeadingPageTitle" runat="server" Checked='<%# Eval("HeadingPageTitle") %>' Enabled="false" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <table class="NoBorder">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:ImageButton ID="ib_Edit" runat="server" CommandName="Edit" Height="14px" ImageUrl="~/Images/Edit.png"
                                                                                    ToolTip="Edit" CausesValidation="false" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:ImageButton ID="ib_Delete" runat="server" CommandName="Delete" Height="14px"
                                                                                    ImageUrl="~/Images/Delete.png" ToolTip="Delete" OnClientClick="return AreYouSure();" CausesValidation="false" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <table class="NoBorder">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:ImageButton ID="ib_Update" runat="server" CommandName="Update" Height="16px"
                                                                                    Width="16px" ImageUrl="~/Images/Save.png" ToolTip="Save" CausesValidation="true" ValidationGroup="EditPage" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:ImageButton ID="ib_Cancel" runat="server" CommandName="Cancel" Height="16px"
                                                                                    Width="16px" ImageUrl="~/Images/Cancel.png" ToolTip="Cancel" CausesValidation="false" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </EditItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="ds_ApplicationPages" runat="server" ConnectionString="<%$ ConnectionStrings:Admin %>"
                                                        ProviderName="<%$ ConnectionStrings:Admin.ProviderName %>" SelectCommand="wsp_ApplicationPages_Get"
                                                        SelectCommandType="StoredProcedure" UpdateCommand="wsp_ApplicationPages_Update"
                                                        UpdateCommandType="StoredProcedure" DeleteCommand="wsp_ApplicationPages_Delete"
                                                        DeleteCommandType="StoredProcedure" InsertCommand="wsp_ApplicationPages_Add"
                                                        InsertCommandType="StoredProcedure" >
                                                        <DeleteParameters>
                                                            <asp:Parameter Name="AppPageId" Type="Int32" />
                                                        </DeleteParameters>
                                                        <InsertParameters>
                                                            <asp:ControlParameter ControlID="gv_Applications" Name="AppId" PropertyName="SelectedValue"
                                                                Type="Int32" />
                                                            <asp:Parameter Name="Title" Type="String" />
                                                            <asp:Parameter Name="URL" Type="String" />
                                                            <asp:Parameter Name="ParentId" Type="Int32" />
                                                            <asp:Parameter Name="OrderId" Type="Int32" />
                                                            <asp:Parameter Name="Hidden" Type="Boolean" />
                                                            <asp:Parameter Name="ShowRibbon" Type="Boolean" />
                                                            <asp:Parameter Name="ShowNavigation" Type="Boolean" />
                                                            <asp:Parameter Name="HeadingApp" Type="Boolean" />
                                                            <asp:Parameter Name="HeadingPageTitle" Type="Boolean" />
                                                        </InsertParameters>
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="gv_Applications" Name="AppId" PropertyName="SelectedValue"
                                                                Type="Int32" />
                                                        </SelectParameters>
                                                        <UpdateParameters>
                                                            <asp:Parameter Name="AppPageId" Type="Int32" />
                                                            <asp:Parameter Name="Title" Type="String" />
                                                            <asp:Parameter Name="URL" Type="String" />
                                                            <asp:Parameter Name="ParentId" Type="Int32" />
                                                            <asp:Parameter Name="OrderId" Type="Int32" />
                                                            <asp:Parameter Name="Hidden" Type="Boolean" />
                                                            <asp:Parameter Name="ShowRibbon" Type="Boolean" />
                                                            <asp:Parameter Name="ShowNavigation" Type="Boolean" />
                                                            <asp:Parameter Name="HeadingApp" Type="Boolean" />
                                                            <asp:Parameter Name="HeadingPageTitle" Type="Boolean" />
                                                        </UpdateParameters>
                                                    </asp:SqlDataSource>
                                                    <asp:SqlDataSource ID="ds_ApplicationPagesDD" runat="server" ConnectionString="<%$ ConnectionStrings:Admin %>"
                                                        ProviderName="<%$ ConnectionStrings:Admin.ProviderName %>" SelectCommand="wsp_ApplicationPagesDD_Get"
                                                        SelectCommandType="StoredProcedure" >
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="gv_Applications" Name="AppId" PropertyName="SelectedValue"
                                                                Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                                <td width="5px">
                                                </td>
                                                <td valign="top">
                                                    <asp:Panel ID="pnl_Users" runat="server" Visible="False" CssClass="FVPanel">
                                                        <asp:Label ID="lbl_Permissions" runat="server" CssClass="DateLabel" Text="Permissions"></asp:Label>
                                                        <br />
                                                        <asp:FormView ID="fv_ApplicationPageUsers" runat="server" DataKeyNames="AppPageUserId"
                                                            DataSourceID="ds_ApplicationPageUsers" OnModeChanged="fv_ApplicationPageUsers_ModeChanged">
                                                            <EmptyDataTemplate>
                                                                <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CommandName="New"
                                                                    CssClass="Label" Text="New Permission" />
                                                            </EmptyDataTemplate>
                                                            <InsertItemTemplate>
                                                                <asp:Panel ID="pnl_New1" runat="server" CssClass="FVPanel">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Label35" runat="server" CssClass="Label" Text="User Type:"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd_UserTypeId" runat="server" CssClass="DropdownList" DataSourceID="ds_ApplicationUserTypes"
                                                                                    DataTextField="UserType" DataValueField="UserTypeId" SelectedValue='<%# Bind("UserTypeId") %>'
                                                                                    ValidationGroup="NewPagePermission">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:ImageButton ID="ib_Save" runat="server" CausesValidation="True" CommandName="Insert"
                                                                                Height="16px" Width="16px" ValidationGroup="NewPagePermission" ImageUrl="~/Images/Save.png"
                                                                                ToolTip="Insert" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:ImageButton ID="ib_Cancel" runat="server" CommandName="Cancel" Height="16px"
                                                                                Width="16px" ImageUrl="~/Images/Cancel.png" ToolTip="Cancel" CausesValidation="false" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                </asp:Panel>
                                                            </InsertItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CommandName="New"
                                                                    CssClass="Label" Text="New Permission" />
                                                            </ItemTemplate>
                                                        </asp:FormView>
                                                        <asp:GridView ID="gv_ApplicationPageUsers" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            DataKeyNames="AppPageUserId" DataSourceID="ds_ApplicationPageUsers" OnRowEditing="gv_ApplicationPageUsers_RowEditing"
                                                            SkinID="GridViewSkin">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="User Type" SortExpression="UserType">
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList ID="dd_UserTypeId" runat="server" CssClass="DropdownList" DataSourceID="ds_ApplicationUserTypes"
                                                                            DataTextField="UserType" DataValueField="UserTypeId" SelectedValue='<%# Bind("UserTypeId") %>'
                                                                            ValidationGroup="EditUserType">
                                                                        </asp:DropDownList>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbl_UserType" runat="server" CssClass="Label" Text='<%# Bind("UserType") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <table class="NoBorder">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:ImageButton ID="ib_Edit" runat="server" CommandName="Edit" Height="14px" ImageUrl="~/Images/Edit.png"
                                                                                        ToolTip="Edit" CausesValidation="false" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:ImageButton ID="ib_Delete" runat="server" CommandName="Delete" Height="14px"
                                                                                        ImageUrl="~/Images/Delete.png" ToolTip="Delete" OnClientClick="return AreYouSure();" CausesValidation="false" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <table class="NoBorder">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:ImageButton ID="ib_Update" runat="server" CommandName="Update" Height="16px"
                                                                                        Width="16px" ImageUrl="~/Images/Save.png" ToolTip="Save" CausesValidation="true" ValidationGroup="EditUserType" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:ImageButton ID="ib_Cancel" runat="server" CommandName="Cancel" Height="16px"
                                                                                        Width="16px" ImageUrl="~/Images/Cancel.png" ToolTip="Cancel" CausesValidation="false" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </EditItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="ds_ApplicationPageUsers" runat="server" ConnectionString="<%$ ConnectionStrings:Admin %>"
                                                            ProviderName="<%$ ConnectionStrings:Admin.ProviderName %>" SelectCommand="wsp_ApplicationPageUsers_Get"
                                                            SelectCommandType="StoredProcedure" DeleteCommand="wsp_ApplicationPageUsers_Delete"
                                                            DeleteCommandType="StoredProcedure" InsertCommand="wsp_ApplicationPageUsers_Add"
                                                            InsertCommandType="StoredProcedure" UpdateCommand="wsp_ApplicationPageUsers_Update"
                                                            UpdateCommandType="StoredProcedure" >
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="AppPageUserId" Type="Int32" />
                                                            </DeleteParameters>
                                                            <InsertParameters>
                                                                <asp:ControlParameter ControlID="gv_ApplicationPages" Name="AppPageId" PropertyName="SelectedValue"
                                                                    Type="Int32" />
                                                                <asp:Parameter Name="UserTypeId" Type="Int32" />
                                                            </InsertParameters>
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="gv_ApplicationPages" Name="AppPageId" PropertyName="SelectedValue"
                                                                    Type="Int32" />
                                                            </SelectParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="AppPageUserId" Type="Int32" />
                                                                <asp:ControlParameter ControlID="gv_ApplicationPages" Name="AppPageId" PropertyName="SelectedValue"
                                                                    Type="Int32" />
                                                                <asp:Parameter Name="UserTypeId" Type="Int32" />
                                                            </UpdateParameters>
                                                        </asp:SqlDataSource>
                                                        <asp:SqlDataSource ID="ds_ApplicationUserTypes" runat="server" ConnectionString="<%$ ConnectionStrings:Admin %>"
                                                            ProviderName="<%$ ConnectionStrings:Admin.ProviderName %>" SelectCommand="wsp_AppUserTypes_Get"
                                                            SelectCommandType="StoredProcedure" >
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="gv_Applications" Name="AppId" PropertyName="SelectedValue"
                                                                    Type="Int32" />
                                                                <asp:Parameter DefaultValue="false" Name="IncludeNULLHeader" Type="Boolean" />
                                                                <asp:Parameter DefaultValue="false" Name="IncludeSelectAll" Type="Boolean" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </ContentTemplate>
                            </cc1:TabPanel>
                            <cc1:TabPanel ID="tp_UsersAndGroups" runat="server" HeaderText="Users / Groups">
                                <ContentTemplate>
                                    <iframe id="myIframe" runat="server" class="FVPanel" frameborder="1" width="100%"
                                        height="100%"></iframe>
                                </ContentTemplate>
                            </cc1:TabPanel>
                        </cc1:TabContainer>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
