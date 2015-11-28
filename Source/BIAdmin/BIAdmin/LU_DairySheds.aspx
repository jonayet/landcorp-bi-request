<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="_LU_DairySheds" MaintainScrollPositionOnPostback="true" Codebehind="LU_DairySheds.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    </asp:ScriptManagerProxy>
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
                <asp:LinkButton ID="lb_NewShed" runat="server" OnClick="lb_NewShed_Click" OnLoad="ToggelLinkButton"
                    Text="New Shed" CssClass="Label" CausesValidation="False"></asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lb_SnapShot" runat="server" OnClick="lb_SnapShot_Click" OnLoad="ToggelLinkButton"
                    Text="Copy From Live" CssClass="Label" CausesValidation="False"></asp:LinkButton>
                <cc1:ConfirmButtonExtender ID="lb_SnapShot_ConfirmButtonExtender" runat="server"
                    ConfirmText="Are you sure???" Enabled="True" TargetControlID="lb_SnapShot">
                </cc1:ConfirmButtonExtender>
            </td>
            <td>
                <asp:LinkButton ID="lb_CopyToLive" runat="server" OnClick="lb_CopyToLive_Click" OnLoad="ToggelLinkButton"
                    Text="Publish To Live" CssClass="Label" CausesValidation="False"></asp:LinkButton>
                <cc1:ConfirmButtonExtender ID="lb_CopyToLive_ConfirmButtonExtender" runat="server"
                    ConfirmText="Are you sure???" Enabled="True" TargetControlID="lb_CopyToLive">
                </cc1:ConfirmButtonExtender>
            </td>
            <td>
                <asp:LinkButton ID="lb_CopyToUAT" runat="server" OnClick="lb_CopyToUAT_Click" OnLoad="ToggelLinkButton"
                    Text="Publish To UAT" CssClass="Label" CausesValidation="False"></asp:LinkButton>
                <cc1:ConfirmButtonExtender ID="lb_CopyToUAT_ConfirmButtonExtender" runat="server"
                    ConfirmText="Are you sure???" Enabled="True" TargetControlID="lb_CopyToUAT">
                </cc1:ConfirmButtonExtender>
            </td>
            <td>
                <asp:LinkButton ID="lb_HighlightDifferencesLIVE" runat="server" OnClick="lb_HighlightDifferencesLIVE_Click"
                    OnLoad="ToggelLinkButtonLIVE" Text="Highlight Differences (LIVE)" CssClass="Label"
                    CausesValidation="False"></asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lb_HighlightDifferencesUAT" runat="server" OnClick="lb_HighlightDifferencesUAT_Click"
                    OnLoad="ToggelLinkButtonUAT" Text="Highlight Differences (UAT)" CssClass="Label"
                    CausesValidation="False"></asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lb_HighlightDifferencesDEV" runat="server" OnClick="lb_HighlightDifferencesDEV_Click"
                    OnLoad="ToggelLinkButtonDEV" Text="Highlight Differences (DEV)" CssClass="Label"
                    CausesValidation="False"></asp:LinkButton>
            </td>
            <td>
                <asp:Label ID="lbl_Response" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:GridView ID="gv_Sheds" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="SK_ShedId" OnDataBound="gv_DataBound" ShowHeaderWhenEmpty="True"
        SkinID="GridViewSkin" OnRowDataBound="gv_RowDataBound" OnPageIndexChanging="gv_Sheds_PageIndexChanging"
        PageSize="20">
        <Columns>
            <asp:TemplateField SortExpression="SK_ShedId" HeaderText="SK_ShedId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_SK_ShedId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_SK_ShedId" runat="server" Text="SK Shed Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_SK_ShedId" runat="server" Text='<%# Eval("SK_ShedId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lbl_SK_ShedId" runat="server" Text='<%# Bind("SK_ShedId") %>'></asp:Label>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="35px" />
            </asp:TemplateField>

            <asp:TemplateField SortExpression="LC_ShedName" HeaderText="LC_ShedName">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_LC_ShedName" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_LC_ShedName" runat="server" Text="LC Shed" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_LC_ShedName" runat="server" Text='<%# Eval("LC_ShedName") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_LC_ShedName" runat="server" Text='<%# Bind("LC_ShedName") %>'
                        CssClass="Textbox" Width="135px" ValidationGroup="Edit" MaxLength="50"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="txb_LC_ShedName_AutoCompleteExtender" runat="server"
                        CompletionInterval="100" CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="100" ContextKey="LC_ShedName"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="txb_LC_ShedName" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:RequiredFieldValidator ID="rf_txb_LC_ShedName" runat="server" ControlToValidate="txb_LC_ShedName"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                    <asp:HiddenField ID="vhf_LC_ShedName" runat="server" Value='<%# Eval("LC_ShedName") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Left" Width="143px" />
            </asp:TemplateField>

            <asp:TemplateField SortExpression="PAM_FarmId" HeaderText="PAM_FarmId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_PAM_FarmId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_PAM_FarmId" runat="server" Text="PAM Farm Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_PAM_FarmId" runat="server" Text='<%# Eval("PAM_FarmId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_PAM_FarmId" runat="server" Text='<%# Bind("PAM_FarmId") %>'
                        CssClass="TextboxRight" Width="35px"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_PAM_FarmId" runat="server" ErrorMessage="*" ControlToValidate="txb_PAM_FarmId"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red"></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="rf_txb_PAM_FarmId" runat="server" 
                        ControlToValidate="txb_PAM_FarmId" Display="Dynamic" ErrorMessage="*" 
                        ForeColor="Red" SetFocusOnError="True" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                    <asp:HiddenField ID="vhf_PAM_FarmId" runat="server" Value='<%# Eval("PAM_FarmId") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>

            <asp:TemplateField SortExpression="MH_FarmID" HeaderText="MH_FarmID">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_MH_FarmID" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_MH_FarmID" runat="server" Text="MH Farm Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_MH_FarmID" runat="server" Text='<%# Eval("MH_FarmID") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_MH_FarmID" runat="server" Text='<%# Bind("MH_FarmID") %>' CssClass="TextboxRight"
                        Width="35px"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_MH_FarmID" runat="server" ErrorMessage="*" ControlToValidate="txb_MH_FarmID"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_MH_FarmID" runat="server" Value='<%# Eval("MH_FarmID") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>

            <asp:TemplateField SortExpression="MH_Farm" HeaderText="MH_Farm">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_MH_Farm" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_MH_Farm" runat="server" Text="MH Farm" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_MH_Farm" runat="server" Text='<%# Eval("MH_Farm") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_MH_Farm" runat="server" Text='<%# Bind("MH_Farm") %>' CssClass="Textbox"
                        Width="135px" ValidationGroup="Edit" MaxLength="50"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="txb_MH_Farm_AutoCompleteExtender" runat="server" CompletionInterval="100"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="100" ContextKey="MH_Farm"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="txb_MH_Farm" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:HiddenField ID="vhf_MH_Farm" runat="server" Value='<%# Eval("MH_Farm") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Left" Width="143px" />
            </asp:TemplateField>

            <asp:TemplateField SortExpression="CO_CompanyName" HeaderText="CO_CompanyName">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_CO_CompanyName" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView"> 
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_CO_CompanyName" runat="server" Text="CO Company Name" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_CO_CompanyName" runat="server" Text='<%# Eval("CO_CompanyName") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_CO_CompanyName" runat="server" Text='<%# Bind("CO_CompanyName") %>' CssClass="Textbox"
                        Width="135px" ValidationGroup="Edit" MaxLength="50"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="txb_CO_CompanyName_AutoCompleteExtender" runat="server" CompletionInterval="100"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="100" ContextKey="CO_CompanyName"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="txb_CO_CompanyName" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:HiddenField ID="vhf_CO_CompanyName" runat="server" Value='<%# Eval("CO_CompanyName") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Left" Width="143px" />
            </asp:TemplateField>

            <asp:TemplateField SortExpression="CO_SupplyNumber" HeaderText="CO_SupplyNumber">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_CO_SupplyNumber" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView"> 
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_CO_SupplyNumber" runat="server" Text="CO Supply Number" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_CO_SupplyNumber" runat="server" Text='<%# Eval("CO_SupplyNumber") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_CO_SupplyNumber" runat="server" Text='<%# Bind("CO_SupplyNumber") %>' CssClass="Textbox"
                        Width="135px" ValidationGroup="Edit" MaxLength="50"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="txb_CO_SupplyNumber_AutoCompleteExtender" runat="server" CompletionInterval="100"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="100" ContextKey="CO_SupplyNumber"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="txb_CO_SupplyNumber" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:HiddenField ID="vhf_CO_SupplyNumber" runat="server" Value='<%# Eval("CO_SupplyNumber") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Left" Width="143px" />
            </asp:TemplateField>

            <asp:TemplateField SortExpression="MapsTo_Wth_FarmID" HeaderText="MapsTo_Wth_FarmID">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_MapsTo_Wth_FarmID" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_MapsTo_Wth_FarmID" runat="server" Text="MapsTo With FarmID"
                        OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_MapsTo_Wth_FarmID" runat="server" Text='<%# Eval("MapsTo_Wth_FarmID") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_MapsTo_Wth_FarmID" runat="server" Text='<%# Bind("MapsTo_Wth_FarmID") %>'
                        CssClass="TextboxRight" Width="35px"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_MapsTo_Wth_FarmID" runat="server" ErrorMessage="*"
                        ControlToValidate="txb_MapsTo_Wth_FarmID" Display="Dynamic" SetFocusOnError="True"
                        Operator="DataTypeCheck" Type="Integer" ForeColor="Red"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_MapsTo_Wth_FarmID" runat="server" Value='<%# Eval("MapsTo_Wth_FarmID") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>

            <asp:TemplateField SortExpression="RadionId" HeaderText="RadionId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_RadionId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_RadionId" runat="server" Text="Radion Id"
                        OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_RadionId" runat="server" Text='<%# Eval("RadionId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_RadionId" runat="server" Text='<%# Bind("RadionId") %>'
                        CssClass="TextboxRight" Width="35px"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_RadionId" runat="server" ErrorMessage="*"
                        ControlToValidate="txb_RadionId" Display="Dynamic" SetFocusOnError="True"
                        Operator="DataTypeCheck" Type="Integer" ForeColor="Red"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_RadionId" runat="server" Value='<%# Eval("RadionId") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>

            <asp:TemplateField SortExpression="farm_Id" HeaderText="farm_Id">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_farm_Id" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_farm_Id" runat="server" Text="farm Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_farm_Id" runat="server" Text='<%# Eval("farm_Id") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_farm_Id" runat="server" Text='<%# Bind("farm_Id") %>' CssClass="TextboxRight"
                        Width="35px"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_farm_Id" runat="server" ErrorMessage="*" ControlToValidate="txb_farm_Id"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red"></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="rf_txb_farm_Id" runat="server" 
                        ControlToValidate="txb_farm_Id" Display="Dynamic" ErrorMessage="*" 
                        ForeColor="Red" SetFocusOnError="True" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                    <asp:HiddenField ID="vhf_farm_Id" runat="server" Value='<%# Eval("farm_Id") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>


            <asp:TemplateField SortExpression="SK_FarmId" HeaderText="SK_FarmId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_SK_FarmId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_SK_FarmId" runat="server" Text="SK Farm ID"
                        OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_SK_FarmId" runat="server" Text='<%# Eval("SK_FarmId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_SK_FarmId" runat="server" Text='<%# Bind("SK_FarmId") %>'
                        CssClass="TextboxRight" Width="35px"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_SK_FarmId" runat="server" ErrorMessage="*"
                        ControlToValidate="txb_SK_FarmId" Display="Dynamic" SetFocusOnError="True"
                        Operator="DataTypeCheck" Type="Integer" ForeColor="Red"></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="rf_txb_SK_FarmId" runat="server" 
                        ControlToValidate="txb_SK_FarmId" Display="Dynamic" ErrorMessage="*" 
                        ForeColor="Red" SetFocusOnError="True" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                    <asp:HiddenField ID="vhf_SK_FarmId" runat="server" Value='<%# Eval("SK_FarmId") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>


            <asp:TemplateField SortExpression="SharePercentage" HeaderText="SharePercentage">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_SharePercentage" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_SharePercentage" runat="server" Text="Share Percentage"
                        OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_SharePercentage" runat="server" Text='<%# Eval("SharePercentage") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_SharePercentage" runat="server" Text='<%# Bind("SharePercentage") %>'
                        CssClass="TextboxRight" Width="35px"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_SharePercentage" runat="server" ErrorMessage="*"
                        ControlToValidate="txb_SharePercentage" Display="Dynamic" SetFocusOnError="True"
                        Operator="DataTypeCheck" Type="Integer" ForeColor="Red"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_SharePercentage" runat="server" Value='<%# Eval("SharePercentage") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>
            
            <asp:TemplateField SortExpression="IsActive" HeaderText="IsActive">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_IsActive" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_IsActive" runat="server" Text="Active" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="cb_IsActive" runat="server" Checked='<%# Eval("IsActive") %>' Enabled="false" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="cb_IsActive" runat="server" Checked='<%# Bind("IsActive") %>' />
                    <asp:HiddenField ID="vhf_IsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="35px" />
            </asp:TemplateField>

            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <table class="NoBorder">
                        <tr>
                            <td>
                                <asp:LinkButton ID="lb_Update" runat="server" CausesValidation="True" Text="Update"
                                    CssClass="Label" OnClick="lb_Update_Click" ValidationGroup="Edit"></asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="lb_Cancel" runat="server" CausesValidation="False" Text="Cancel"
                                    CssClass="Label" OnClick="lb_Cancel_Click"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="lb_Edit" runat="server" CausesValidation="False" Text="Edit"
                        CssClass="Label" OnClick="lb_Edit_Click" OnLoad="lb_Edit_Load"></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
        <HeaderStyle VerticalAlign="Top" />
    </asp:GridView>
    
    <asp:Button ID="bt_NewShedHidden" runat="server" Text="Button" Style="display: none"
        OnClick="btn_Hidden_Click" />
    <cc1:ModalPopupExtender ID="mpe_NewShed" runat="server" TargetControlID="bt_NewShedHidden"
        PopupControlID="pnl_NewShed" Enabled="True" BackgroundCssClass="modalBackground"
        DropShadow="true">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnl_NewShed" runat="server" CssClass="modalPopup" Style="display: none" >
        <br />
        <table>
            <tr>
                <td align="center">
                    <asp:Label ID="nlbl_DataFields" runat="server" CssClass="DetailsLabel" Text="Fields"></asp:Label>
                </td>
                <td align="center">
                    <asp:Label ID="nlbl_NewShedDetails" runat="server" CssClass="DetailsLabel" Text="New Shed Details"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_LC_ShedName" runat="server" CssClass="DetailsLabel" 
                        Text="LC Shed Name:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_LC_ShedName" runat="server" CausesValidation="True" CssClass="Textbox"
                        ValidationGroup="NewShed" Width="100px" MaxLength="50"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="ntxb_LC_ShedName_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="LC_ShedName"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_LC_ShedName" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:RequiredFieldValidator ID="rf_ntxb_LC_ShedName" runat="server" 
                        ErrorMessage="*" ControlToValidate="ntxb_LC_ShedName" Display="Dynamic" 
                        ForeColor="Red" SetFocusOnError="True" ValidationGroup="NewShed"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_PAM_FarmId" runat="server" CssClass="DetailsLabel" 
                        Text="PAM Farm Id:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_PAM_FarmId" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewShed" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncv_PAM_FarmId" runat="server" ControlToValidate="ntxb_PAM_FarmId"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewShed"></asp:CompareValidator>
                    <cc1:AutoCompleteExtender ID="ntxb_PAM_FarmId_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="PAM_FarmId"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_PAM_FarmId" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:RequiredFieldValidator ID="rf_ntxb_PAM_FarmId" runat="server" 
                        ControlToValidate="ntxb_PAM_FarmId" Display="Dynamic" ErrorMessage="*" 
                        ForeColor="Red" SetFocusOnError="True" ValidationGroup="NewShed"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_MH_FarmID" runat="server" CssClass="DetailsLabel" 
                        Text="MH Farm ID:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_MH_FarmID" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewShed" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncv_MH_FarmID" runat="server" ControlToValidate="ntxb_MH_FarmID"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewShed"></asp:CompareValidator>
                    <cc1:AutoCompleteExtender ID="ntxb_MH_FarmID_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="MH_FarmID"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_MH_FarmID" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_MH_Farm" runat="server" CssClass="DetailsLabel" 
                        Text="MH Farm:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_MH_Farm" runat="server" CausesValidation="True" CssClass="Textbox"
                        ValidationGroup="NewShed" Width="100px"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="ntxb_MH_Farm_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="MH_Farm"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_MH_Farm" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                </td>
            </tr>

            
            <tr>
                <td>
                    <asp:Label ID="nlbl_CO_CompanyName" runat="server" CssClass="DetailsLabel" 
                        Text="CO Company Name:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_CO_CompanyName" runat="server" CausesValidation="True" CssClass="Textbox"
                        ValidationGroup="NewShed" Width="100px" MaxLength="50"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="ntxb_CO_CompanyName_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="CO_CompanyName"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_CO_CompanyName" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                </td>
            </tr>

            
            <tr>
                <td>
                    <asp:Label ID="nlbl_CO_SupplyNumber" runat="server" CssClass="DetailsLabel" Text="CO Supply Number:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_CO_SupplyNumber" runat="server" CausesValidation="True" CssClass="Textbox"
                        ValidationGroup="NewShed" Width="100px" MaxLength="50"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="nxtb_CO_SupplyNumber_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="CO_SupplyNumber"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_CO_SupplyNumber" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                </td>
            </tr>


            <tr>
                <td>
                    <asp:Label ID="nlbl_MapsTo_Wth_FarmID" runat="server" CssClass="DetailsLabel" Text="MapsTo With Farm ID:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_MapsTo_Wth_FarmID" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewShed" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_MapsTo_Wth_FarmID" runat="server" ControlToValidate="ntxb_MapsTo_Wth_FarmID"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewShed"></asp:CompareValidator>
                    <cc1:AutoCompleteExtender ID="ntxb_MapsTo_Wth_FarmID_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="MapsTo_Wth_FarmID"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_MapsTo_Wth_FarmID" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_RadionId" runat="server" CssClass="DetailsLabel" 
                        Text="Radion Id:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_RadionId" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewShed" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_RadionId" runat="server" ControlToValidate="ntxb_RadionId"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewShed"></asp:CompareValidator>
                    <cc1:AutoCompleteExtender ID="ntxb_RadionId_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="RadionId"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_RadionId" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_farm_Id" runat="server" CssClass="DetailsLabel" 
                        Text="farm Id:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_farm_Id" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewShed" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_farm_Id" runat="server" ControlToValidate="ntxb_farm_Id"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewShed"></asp:CompareValidator>
                    <cc1:AutoCompleteExtender ID="ntxb_farm_Id_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="farm_Id"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_farm_Id" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:RequiredFieldValidator ID="rf_ntxb_farm_Id" runat="server" 
                        ControlToValidate="ntxb_farm_Id" Display="Dynamic" ErrorMessage="*" 
                        ForeColor="Red" SetFocusOnError="True" ValidationGroup="NewShed"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_SK_FarmId" runat="server" CssClass="DetailsLabel" 
                        Text="SK Farm Id:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_SK_FarmId" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewShed" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_SK_FarmId" runat="server" ControlToValidate="ntxb_SK_FarmId"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewShed"></asp:CompareValidator>
                    <cc1:AutoCompleteExtender ID="ntxb_SK_FarmId_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="SK_FarmId"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_SK_FarmId" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:RequiredFieldValidator ID="rf_ntxb_SK_FarmId" runat="server" 
                        ControlToValidate="ntxb_SK_FarmId" Display="Dynamic" ErrorMessage="*" 
                        ForeColor="Red" SetFocusOnError="True" ValidationGroup="NewShed"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_SharePercentage" runat="server" CssClass="DetailsLabel" 
                        Text="Share Percentage:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_SharePercentage" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewShed" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_SharePercentage" runat="server" ControlToValidate="ntxb_SharePercentage"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewShed"></asp:CompareValidator>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:Label ID="nlbl_IsActive" runat="server" CssClass="DetailsLabel" 
                        Text="Is Active:"></asp:Label>
                </td>
                <td>
                    <asp:CheckBox ID="ncb_IsActive" runat="server" ValidationGroup="NewShed" Width="100px" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="bt_SaveNewSheds" runat="server" OnClick="bt_SaveNewSheds_Click" Text="Save"
                        ValidationGroup="NewShed" Width="75" />
                    <asp:Button ID="bt_CancelNewSheds" runat="server" CausesValidation="False" OnClick="bt_CancelNewSheds_Click"
                        Text="Cancel" Width="75" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:HiddenField ID="hf_SK_ShedId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_farm_id" runat="server" Value="All" />
    <asp:HiddenField ID="hf_PAM_FarmId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_LC_ShedName" runat="server" Value="All" />
    <asp:HiddenField ID="hf_MH_FarmID" runat="server" Value="All" />
    <asp:HiddenField ID="hf_MH_Farm" runat="server" Value="All" />
    <asp:HiddenField ID="hf_CO_CompanyName" runat="server" Value="All" />
    <asp:HiddenField ID="hf_CO_SupplyNumber" runat="server" Value="All" />
    <asp:HiddenField ID="hf_MapsTo_Wth_FarmID" runat="server" Value="All" />
    <asp:HiddenField ID="hf_IsActive" runat="server" Value="All" />
    <asp:HiddenField ID="hf_RadionId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_SK_FarmId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_SharePercentage" runat="server" Value="All" />
    <asp:HiddenField ID="hdf_SortBy" runat="server" Value="LC_ShedName" />
    <asp:HiddenField ID="hdf_SortDirection" runat="server" Value="ASC" />
    <asp:HiddenField ID="hdf_PopUpVisible" runat="server" Value="false" />
    <asp:HiddenField ID="hdf_PopUp" runat="server" Value="false" />
    <script type="text/javascript">

        function pageLoad() {
            fxheaderInit('<%= gv_Sheds.ClientID %>', 750, 1, 0, $('#<%= gv_Sheds.ClientID %>').width() + 18);
            fxheader();
        }

    </script>
</asp:Content>
