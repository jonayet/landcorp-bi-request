<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="_LU_Farms" MaintainScrollPositionOnPostback="true" Codebehind="LU_Farms.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    </asp:ScriptManagerProxy>
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
                <asp:LinkButton ID="lb_NewFarm" runat="server" OnClick="lb_NewFarm_Click" OnLoad="ToggelLinkButton"
                    Text="New Farm" CssClass="Label" CausesValidation="False"></asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lb_DeactiveFarm" runat="server" OnClick="lb_DeactiveFarm_Click"
                    OnLoad="ToggelLinkButton" Text="Deactivate Farm" CssClass="Label" CausesValidation="False"></asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lb_MergeFarms" runat="server" OnClick="lb_MergeFarms_Click" OnLoad="ToggelLinkButton"
                    Text="Merge Farms" CssClass="Label" CausesValidation="False"></asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lb_SplitFarm" runat="server" OnClick="lb_SplitFarm_Click" OnLoad="ToggelLinkButton"
                    Text="Split Farm" CssClass="Label" CausesValidation="False"></asp:LinkButton>
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
    <asp:GridView ID="gv_Farms" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="SK_FarmId" OnDataBound="gv_DataBound" ShowHeaderWhenEmpty="True"
        SkinID="GridViewSkin" OnRowDataBound="gv_RowDataBound" OnPageIndexChanging="gv_Farms_PageIndexChanging"
        PageSize="20">
        <Columns>
            <asp:TemplateField SortExpression="SK_FarmId" HeaderText="SK_FarmId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_SK_FarmId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_SK_FarmId" runat="server" Text="SK Farm Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_SK_FarmId" runat="server" Text='<%# Eval("SK_FarmId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lbl_SK_FarmId" runat="server" Text='<%# Bind("SK_FarmId") %>'></asp:Label>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="35px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="LC_Farm" HeaderText="LC_Farm">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_LC_Farm" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_LC_Farm" runat="server" Text="LC Farm" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_LC_Farm" runat="server" Text='<%# Eval("LC_Farm") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_LC_Farm" runat="server" Text='<%# Bind("LC_Farm") %>' CssClass="Textbox"
                        Width="135px" ValidationGroup="Edit"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="txb_LC_Farm_AutoCompleteExtender" runat="server" CompletionInterval="100"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="100" ContextKey="LC_Farm"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="txb_LC_Farm" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:RequiredFieldValidator ID="rf_txb_LC_Farm" runat="server" ControlToValidate="txb_LC_Farm"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                    <asp:HiddenField ID="vhf_LC_Farm" runat="server" Value='<%# Eval("LC_Farm") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Left" Width="143px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="Island" HeaderText="Island">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_Island" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_Island" runat="server" Text="Island" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_Island" runat="server" Text='<%# Eval("Island") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_Island" runat="server" Text='<%# Bind("Island") %>' CssClass="Textbox"
                        Width="65px" ValidationGroup="Edit"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="txb_Island_AutoCompleteExtender" runat="server" CompletionInterval="100"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="100" ContextKey="Island"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="txb_Island" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:HiddenField ID="vhf_Island" runat="server" Value='<%# Eval("Island") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Left" Width="73px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="Region" HeaderText="Region">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_Region" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_Region" runat="server" Text="Region" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_Region" runat="server" Text='<%# Eval("Region") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_Region" runat="server" Text='<%# Bind("Region") %>' CssClass="Textbox"
                        Width="115px" ValidationGroup="Edit"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="txb_Region_AutoCompleteExtender" runat="server" CompletionInterval="100"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="100" ContextKey="Region"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="txb_Region" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                    <asp:HiddenField ID="vhf_Region" runat="server" Value='<%# Eval("Region") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Left" Width="123px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="ActiveFrom" HeaderText="ActiveFrom">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_ActiveFrom" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_ActiveFrom" runat="server" Text="Active From" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_ActiveFrom" runat="server" Text='<%# Eval("ActiveFrom", "{0:dd/MM/yyyy}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_ActiveFrom" runat="server" Text='<%# Bind("ActiveFrom", "{0:dd/MM/yyyy}") %>'
                        CssClass="Textbox" Width="65px" ValidationGroup="Edit"></asp:TextBox>
                    <cc1:CalendarExtender ID="txb_ActiveFrom_CalendarExtender" runat="server" Enabled="True"
                        Format="dd/MM/yyyy" TargetControlID="txb_ActiveFrom">
                    </cc1:CalendarExtender>
                    <asp:CompareValidator ID="cmp_txb_ActiveFrom" runat="server" ErrorMessage="*" ControlToValidate="txb_ActiveFrom"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Date"
                        ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="rf_txb_ActiveFrom" runat="server" ControlToValidate="txb_ActiveFrom"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                    <asp:HiddenField ID="vhf_ActiveFrom" runat="server" Value='<%# Eval("ActiveFrom", "{0:dd/MM/yyyy}") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="73px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="ActiveTo" HeaderText="ActiveTo">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_ActiveTo" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_ActiveTo" runat="server" Text="Active To" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_ActiveTo" runat="server" Text='<%# Eval("ActiveTo", "{0:dd/MM/yyyy}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_ActiveTo" runat="server" Text='<%# Bind("ActiveTo", "{0:dd/MM/yyyy}") %>'
                        CssClass="Textbox" Width="61px" ValidationGroup="Edit"></asp:TextBox>
                    <cc1:CalendarExtender ID="txb_ActiveTo_CalendarExtender" runat="server" Enabled="True"
                        Format="dd/MM/yyyy" TargetControlID="txb_ActiveTo">
                    </cc1:CalendarExtender>
                    <asp:CompareValidator ID="cmp_txb_ActiveTo" runat="server" ErrorMessage="*" ControlToValidate="txb_ActiveTo"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Date"
                        ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_ActiveTo" runat="server" Value='<%# Eval("ActiveTo", "{0:dd/MM/yyyy}") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="73px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="Cluster_Id" HeaderText="Cluster_Id">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_Cluster_Id" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_Cluster_Id" runat="server" Text="Cluster Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_Cluster_Id" runat="server" Text='<%# Eval("Cluster_Id") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_Cluster_Id" runat="server" Text='<%# Bind("Cluster_Id") %>'
                        CssClass="TextboxRight" Width="35px"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_Cluster_Id" runat="server" ErrorMessage="*" ControlToValidate="txb_Cluster_Id"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_Cluster_Id" runat="server" Value='<%# Eval("Cluster_Id") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="farm_id" HeaderText="farm_id">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_farm_id" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_farm_id" runat="server" Text="farm id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_farm_id" runat="server" Text='<%# Eval("farm_id") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_farm_id" runat="server" Text='<%# Bind("farm_id") %>' CssClass="TextboxRight"
                        Width="35px" ValidationGroup="Edit"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_farm_id" runat="server" ErrorMessage="*" ControlToValidate="txb_farm_id"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_farm_id" runat="server" Value='<%# Eval("farm_id") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="LastFarmId" HeaderText="LastFarmId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_LastFarmId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_LastFarmId" runat="server" Text="Last Farm Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_LastFarmId" runat="server" Text='<%# Eval("LastFarmId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_LastFarmId" runat="server" Text='<%# Bind("LastFarmId") %>'
                        CssClass="TextboxRight" Width="35px" ValidationGroup="Edit"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_LastFarmId" runat="server" ErrorMessage="*" ControlToValidate="txb_LastFarmId"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_LastFarmId" runat="server" Value='<%# Eval("LastFarmId") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="MapsToFarmId" HeaderText="MapsToFarmId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_MapsToFarmId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_MapsToFarmId" runat="server" Text="Maps To Farm Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_MapsToFarmId" runat="server" Text='<%# Eval("MapsToFarmId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_MapsToFarmId" runat="server" Text='<%# Bind("MapsToFarmId") %>'
                        CssClass="TextboxRight" Width="35px" ValidationGroup="Edit"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_MapsToFarmId" runat="server" ErrorMessage="*" ControlToValidate="txb_MapsToFarmId"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_MapsToFarmId" runat="server" Value='<%# Eval("MapsToFarmId") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="PAM_ClientID" HeaderText="PAM_ClientID">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_PAM_ClientID" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_PAM_ClientID" runat="server" Text="PAM Client ID" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_PAM_ClientID" runat="server" Text='<%# Eval("PAM_ClientID") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_PAM_ClientID" runat="server" Text='<%# Bind("PAM_ClientID") %>'
                        CssClass="TextboxRight" Width="40px" ValidationGroup="Edit"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_PAM_ClientID" runat="server" ErrorMessage="*" ControlToValidate="txb_PAM_ClientID"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_PAM_ClientID" runat="server" Value='<%# Eval("PAM_ClientID") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="48px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="PAM_CustomerNum" HeaderText="PAM_CustomerNum">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_PAM_CustomerNum" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_PAM_CustomerNum" runat="server" Text="PAM Customer Num" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_PAM_CustomerNum" runat="server" Text='<%# Eval("PAM_CustomerNum") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_PAM_CustomerNum" runat="server" Text='<%# Bind("PAM_CustomerNum") %>'
                        CssClass="TextboxRight" Width="45px" ValidationGroup="Edit"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_PAM_CustomerNum" runat="server" ErrorMessage="*"
                        ControlToValidate="txb_PAM_CustomerNum" Display="Dynamic" SetFocusOnError="True"
                        Operator="DataTypeCheck" Type="Integer" ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_PAM_CustomerNum" runat="server" Value='<%# Eval("PAM_CustomerNum") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="53px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="FMS_ClientId" HeaderText="FMS_ClientId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_FMS_ClientId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_FMS_ClientId" runat="server" Text="FMS Client Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_FMS_ClientId" runat="server" Text='<%# Eval("FMS_ClientId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_FMS_ClientId" runat="server" Text='<%# Bind("FMS_ClientId") %>'
                        CssClass="TextboxRight" Width="35px" ValidationGroup="Edit"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_FMS_ClientId" runat="server" ErrorMessage="*" ControlToValidate="txb_FMS_ClientId"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_FMS_ClientId" runat="server" Value='<%# Eval("FMS_ClientId") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="BANId" HeaderText="BANId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_BANId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_BANId" runat="server" Text="BAN Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_BANId" runat="server" Text='<%# Eval("BANId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_BANId" runat="server" Text='<%# Bind("BANId") %>' CssClass="TextboxRight"
                        Width="35px" ValidationGroup="Edit"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_BANId" runat="server" ErrorMessage="*" ControlToValidate="txb_BANId"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_BANId" runat="server" Value='<%# Eval("BANId") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="LabTestId" HeaderText="LabTestId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_LabTestId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_LabTestId" runat="server" Text="Lab Test Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_LabTestId" runat="server" Text='<%# Eval("LabTestId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_LabTestId" runat="server" Text='<%# Bind("LabTestId") %>' CssClass="TextboxRight"
                        Width="35px" ValidationGroup="Edit"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_LabTestId" runat="server" ErrorMessage="*" ControlToValidate="txb_LabTestId"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_LabTestId" runat="server" Value='<%# Eval("LabTestId") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="43px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="AllianceId" HeaderText="AllianceId">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_AllianceId" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_AllianceId" runat="server" Text="Alliance Id" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_AllianceId" runat="server" Text='<%# Eval("AllianceId") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_AllianceId" runat="server" Text='<%# Bind("AllianceId") %>'
                        CssClass="TextboxRight" Width="45px" ValidationGroup="Edit"></asp:TextBox>
                    <asp:CompareValidator ID="cmp_txb_AllianceId" runat="server" ErrorMessage="*" ControlToValidate="txb_AllianceId"
                        Display="Dynamic" SetFocusOnError="True" Operator="DataTypeCheck" Type="Integer"
                        ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_AllianceId" runat="server" Value='<%# Eval("AllianceId") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" Width="53px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="DPR" HeaderText="DPR">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_DPR" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_DPR" runat="server" Text="DPR" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="cb_DPR" runat="server" Checked='<%# Eval("DPR") %>' Enabled="false" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="cb_DPR" runat="server" Checked='<%# Bind("DPR") %>' />
                    <asp:HiddenField ID="vhf_DPR" runat="server" Value='<%# Eval("DPR") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="35px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="MS_Import" HeaderText="MS_Import">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_MS_Import" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_MS_Import" runat="server" Text="MS Import" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="cb_MS_Import" runat="server" Checked='<%# Eval("MS_Import") %>'
                        Enabled="false" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="cb_MS_Import" runat="server" Checked='<%# Bind("MS_Import") %>' />
                    <asp:HiddenField ID="vhf_MS_Import" runat="server" Value='<%# Eval("MS_Import") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="35px" />
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
            <asp:TemplateField SortExpression="IsDairyFarm" HeaderText="IsDairyFarm">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_IsDairyFarm" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_IsDairyFarm" runat="server" Text="Dairy Farm" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="cb_IsDairyFarm" runat="server" Checked='<%# Eval("IsDairyFarm") %>'
                        Enabled="false" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="cb_IsDairyFarm" runat="server" Checked='<%# Bind("IsDairyFarm") %>' />
                    <asp:HiddenField ID="vhf_IsDairyFarm" runat="server" Value='<%# Eval("IsDairyFarm") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="35px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="ReportToNAIT" HeaderText="ReportToNAIT">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_ReportToNAIT" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_ReportToNAIT" runat="server" Text="Report To NAIT" OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="cb_ReportToNAIT" runat="server" Checked='<%# Eval("ReportToNAIT") %>'
                        Enabled="false"></asp:CheckBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="cb_ReportToNAIT" runat="server" Checked='<%# Bind("ReportToNAIT") %>'>
                    </asp:CheckBox>
                    <asp:HiddenField ID="vhf_ReportToNAIT" runat="server" Value='<%# Eval("ReportToNAIT") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="35px" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="DPRFeedEntryStartDate" HeaderText="DPRFeedEntryStartDate">
                <HeaderTemplate>
                    <asp:DropDownList ID="dd_DPRFeedEntryStartDate" runat="server" AutoPostBack="True"
                        CssClass="MatchDropdownList" OnSelectedIndexChanged="FilterGridView">
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="lb_DPRFeedEntryStartDate" runat="server" Text="DPR Feed Entry Start Date"
                        OnClick="lb_Sort_Click"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_DPRFeedEntryStartDate" runat="server" Text='<%# Eval("DPRFeedEntryStartDate", "{0:dd/MM/yyyy}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txb_DPRFeedEntryStartDate" runat="server" Text='<%# Bind("DPRFeedEntryStartDate", "{0:dd/MM/yyyy}") %>'
                        CssClass="TextboxRight" Width="65px" ValidationGroup="Edit"></asp:TextBox>
                    <cc1:CalendarExtender ID="txb_DPRFeedEntryStartDate_CalendarExtender" runat="server"
                        Enabled="True" Format="dd/MM/yyyy" TargetControlID="txb_DPRFeedEntryStartDate">
                    </cc1:CalendarExtender>
                    <asp:CompareValidator ID="cmp_txb_DPRFeedEntryStartDate" runat="server" ErrorMessage="*"
                        ControlToValidate="txb_DPRFeedEntryStartDate" Display="Dynamic" SetFocusOnError="True"
                        Operator="DataTypeCheck" Type="Date" ForeColor="Red" ValidationGroup="Edit"></asp:CompareValidator>
                    <asp:HiddenField ID="vhf_DPRFeedEntryStartDate" runat="server" Value='<%# Eval("DPRFeedEntryStartDate", "{0:dd/MM/yyyy}") %>' />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="73px" />
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <table class="NoBorder">
                        <tr>
                            <td colspan="2">
                                <asp:CheckBox ID="cb_Override" runat="server" Text="Override" ToolTip="Override new record from being created"
                                    ValidationGroup="Edit" />
                            </td>
                        </tr>
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
    <asp:Button ID="btn_EffectiveDate" runat="server" Text="Button" Style="display: none"
        OnClick="btn_Hidden_Click" />
    <cc1:ModalPopupExtender ID="mpe_EffectiveDate" runat="server" TargetControlID="btn_EffectiveDate"
        PopupControlID="pnl_EffectiveDate" Enabled="True" BackgroundCssClass="modalBackground"
        DropShadow="true">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnl_EffectiveDate" runat="server" CssClass="modalPopup" Style="display: none">
        <table>
            <tr>
                <td align="center" valign="top" width="400" height="250">
                    <table>
                        <tr>
                            <td align="center">
                                <asp:Label ID="lbl_EffectiveDate" runat="server" Text="Please choose the effective date:"
                                    CssClass="DetailsLabel"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:TextBox ID="txb_EffectiveDate" runat="server" CssClass="Textbox" Width="65px"
                                    CausesValidation="True" ValidationGroup="EffectiveDate"></asp:TextBox>
                                <cc1:CalendarExtender ID="txb_EffectiveDate_CalendarExtender" runat="server" Enabled="True"
                                    Format="dd/MM/yyyy" TargetControlID="txb_EffectiveDate" PopupPosition="TopRight">
                                </cc1:CalendarExtender>
                                <asp:RequiredFieldValidator ID="rf_txb_EffectiveDate" runat="server" ControlToValidate="txb_EffectiveDate"
                                    Display="Dynamic" Enabled="False" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"
                                    ValidationGroup="EffectiveDate"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmp_txb_EffectiveDate" runat="server" ControlToValidate="txb_EffectiveDate"
                                    Display="Dynamic" ErrorMessage="dd/MM/yyyy" ForeColor="Red" Operator="DataTypeCheck"
                                    Type="Date" SetFocusOnError="True" ValidationGroup="EffectiveDate" Enabled="False"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="bt_SaveEffectiveDate" runat="server" OnClick="bt_SaveEffectiveDate_Click"
                                    Text="Save" Width="75" ValidationGroup="EffectiveDate" />
                                <asp:Button ID="bt_CancelEffectiveDate" runat="server" CausesValidation="False" OnClick="bt_CancelEffectiveDate_Click"
                                    Text="Cancel" Width="75" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Button ID="btn_DeactivateFarmHidden" runat="server" Text="Button" Style="display: none"
        OnClick="btn_Hidden_Click" />
    <cc1:ModalPopupExtender ID="mpe_DeactivateFarm" runat="server" TargetControlID="btn_DeactivateFarmHidden"
        PopupControlID="pnl_DeactivateFarm" Enabled="True" BackgroundCssClass="modalBackground"
        DropShadow="true">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnl_DeactivateFarm" runat="server" CssClass="modalPopup" Style="display: none">
        <table>
            <tr>
                <td align="center" valign="top" width="400" height="250">
                    <table>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbl_DeactiveFarm" runat="server" Text="Farm:" CssClass="DetailsLabel"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="dd_DeactiveFarm" runat="server" CssClass="DropdownList" ValidationGroup="Deactivate"
                                    AutoPostBack="True" OnSelectedIndexChanged="dd_DeactiveFarm_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rf_DeactiveFarm" runat="server" ControlToValidate="dd_DeactiveFarm"
                                    Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="Deactivate"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbl_DeactiveDate" runat="server" Text="Date:" CssClass="DetailsLabel"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txb_DeactiveDate" runat="server" CssClass="Textbox" Width="65px"
                                    CausesValidation="true" ValidationGroup="Deactivate"></asp:TextBox>
                                <cc1:CalendarExtender ID="txb_DeactiveDate_CalendarExtender" runat="server" Enabled="True"
                                    Format="dd/MM/yyyy" TargetControlID="txb_DeactiveDate" PopupPosition="TopRight">
                                </cc1:CalendarExtender>
                                <asp:RequiredFieldValidator ID="rf_txb_DeactiveDate" runat="server" ControlToValidate="txb_DeactiveDate"
                                    Display="Dynamic" Enabled="False" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"
                                    ValidationGroup="Deactivate"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmp_txb_DeactiveDate" runat="server" ControlToValidate="txb_DeactiveDate"
                                    Display="Dynamic" Enabled="False" ErrorMessage="dd/MM/yyyy" ForeColor="Red" Operator="DataTypeCheck"
                                    SetFocusOnError="True" Type="Date" ValidationGroup="Deactivate"></asp:CompareValidator>
                                <asp:CustomValidator ID="cv_txb_DeactiveDate" runat="server" ControlToValidate="txb_DeactiveDate"
                                    Display="Dynamic" Enabled="False" ErrorMessage="CustomValidator" ForeColor="Red"
                                    OnServerValidate="cv_txb_DeactiveDate_ServerValidate" SetFocusOnError="True"
                                    ValidationGroup="Deactivate"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:Button ID="bt_SaveDeactivation" runat="server" OnClick="bt_SaveDeactivation_Click"
                                    Text="Save" ValidationGroup="Deactivate" Width="75" />
                                <asp:Button ID="bt_CancelDeactivation" runat="server" CausesValidation="False" OnClick="bt_CancelDeactivation_Click"
                                    Text="Cancel" Width="75" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Button ID="btn_SplitFarmsHidden" runat="server" Text="Button" Style="display: none"
        OnClick="btn_Hidden_Click" />
    <cc1:ModalPopupExtender ID="mpe_SplitFarms" runat="server" TargetControlID="btn_SplitFarmsHidden"
        PopupControlID="pnl_SplitFarms" Enabled="True" BackgroundCssClass="modalBackground"
        DropShadow="true">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnl_SplitFarms" runat="server" CssClass="modalPopup" Height="450px">
        <table>
            <tr>
                <td valign="top">
                    <asp:Panel ID="pnl_SplitFarm" runat="server" CssClass="FVPanel">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label16" runat="server" CssClass="DetailsLabel" Text="Choose Farm to Split:"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="dd_FarmToSplit" runat="server" CssClass="DropdownList" AutoPostBack="true"
                                        OnSelectedIndexChanged="dd_FarmToSplit_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label7" runat="server" CssClass="DetailsLabel" Text="Effective From:"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="stxb_ActiveFrom" runat="server" CausesValidation="True" CssClass="Textbox"
                                        ValidationGroup="SplitFarm" Width="65px" Enabled="false"></asp:TextBox>
                                    <cc1:CalendarExtender ID="stxb_ActiveFrom_CalendarExtender" runat="server" Enabled="True"
                                        Format="dd/MM/yyyy" PopupPosition="BottomRight" TargetControlID="stxb_ActiveFrom">
                                    </cc1:CalendarExtender>
                                    <asp:RequiredFieldValidator ID="srf_ActiveFrom" runat="server" ControlToValidate="stxb_ActiveFrom"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="SplitFarm"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="scv_ActiveFrom" runat="server" ControlToValidate="stxb_ActiveFrom"
                                        Display="Dynamic" ErrorMessage="dd/MM/yyyy" ForeColor="Red" Operator="DataTypeCheck"
                                        SetFocusOnError="True" Type="Date" ValidationGroup="SplitFarm"></asp:CompareValidator>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
                <td>
                    <asp:Panel ID="pnl_FarmToSplitInto" runat="server" CssClass="FVPanel">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text="Choose Farms to Split into:" CssClass="DetailsLabel"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text="Farm:" CssClass="DetailsLabel"></asp:Label>
                                    <asp:TextBox ID="txb_FarmsToSplitInto" runat="server" CssClass="Textbox" Width="150px"
                                        ValidationGroup="SplitFarmInto"> 
                                    </asp:TextBox>
                                    <asp:RequiredFieldValidator ID="srf_FarmsToSplitInto" runat="server" ControlToValidate="txb_FarmsToSplitInto"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="SplitFarmInto"></asp:RequiredFieldValidator>
                                    <asp:Button ID="bt_AddSplitFarm" runat="server" Text="Add" OnClick="bt_AddSplitFarm_Click"
                                        ValidationGroup="SplitFarmInto" CausesValidation="False" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gv_FarmsToSplitInto" runat="server" AutoGenerateColumns="False"
                                        SkinID="GridViewSkin" DataKeyNames="LC_Farm">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Farm">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_LC_Farm" runat="server" Text='<%# Eval("LC_Farm") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lb_DeleteFarmToSplitInto" runat="server" CausesValidation="False"
                                                        Text="Delete" OnClick="lb_DeleteFarmToSplitInto_Click"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
                <td valign="top">
                    <asp:Panel ID="pnl_DairySheds" runat="server" CssClass="FVPanel" Visible="false">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label18" runat="server" CssClass="DetailsLabel" Text="Assign Dairy Sheds:"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gv_DairySheds" runat="server" AutoGenerateColumns="False" DataKeyNames="SK_ShedId"
                                        ShowHeaderWhenEmpty="True" SkinID="GridViewSkin">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SK ShedId">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_SK_ShedId" runat="server" Text='<%# Eval("SK_ShedId") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="LC Shed Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_LC_ShedName" runat="server" Text='<%# Eval("LC_ShedName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="dd_LC_Farm" runat="server" CssClass="DropdownList">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="3">
                </td>
            </tr>
            <tr>
                <td align="center" colspan="3">
                    <asp:Button ID="bt_SaveSplitFarms" runat="server" OnClick="bt_SaveSplitFarms_Click"
                        Text="Save" ValidationGroup="SplitFarm" Width="75" Enabled="false" />
                    <asp:Button ID="bt_CancelSplitFarms" runat="server" CausesValidation="False" OnClick="bt_CancelSplitFarms_Click"
                        Text="Cancel" Width="75" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Button ID="btn_MergeFarmsHidden" runat="server" Text="Button" Style="display: none"
        OnClick="btn_Hidden_Click" />
    <cc1:ModalPopupExtender ID="mpe_MergeFarms" runat="server" TargetControlID="btn_MergeFarmsHidden"
        PopupControlID="pnl_MergeFarms" Enabled="True" BackgroundCssClass="modalBackground"
        DropShadow="true">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnl_MergeFarms" runat="server" CssClass="modalPopup" Style="display: none">
        <table>
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lbl_MergeFarms" runat="server" Text="Choose Farms to Merge:" CssClass="DetailsLabel"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label1" runat="server" Text="Farm:" CssClass="DetailsLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="dd_MergeFarm" runat="server" CssClass="DropdownList">
                                </asp:DropDownList>
                                <asp:Button ID="bt_AddMergeFarm" runat="server" Text="Add" OnClick="bt_AddMergeFarm_Click"
                                    CausesValidation="False" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:GridView ID="gv_FarmsToMerge" runat="server" AutoGenerateColumns="False" DataKeyNames="SK_FarmId"
                                    ShowHeaderWhenEmpty="True" SkinID="GridViewSkin">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SK FarmId">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_SK_FarmId" runat="server" Text='<%# Eval("SK_FarmId") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="LC Farm">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_LC_Farm" runat="server" Text='<%# Eval("LC_Farm") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lb_DeleteFarmToMerge" runat="server" CausesValidation="False"
                                                    OnClick="lb_DeleteFarmToMerge_Click" Text="Delete"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="10px">
                </td>
                <td valign="top">
                    <asp:Panel ID="pnl_MergeDetails" runat="server" CssClass="FVPanel" Visible="false">
                        <table>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="mlbl_DataFields" runat="server" Text="Fields" CssClass="DetailsLabel"></asp:Label>
                                </td>
                                <td align="center">
                                    <asp:Label ID="mlbl_OldFarmDetails" runat="server" Text="Old Farm Details" CssClass="DetailsLabel"></asp:Label>
                                </td>
                                <td align="center">
                                    <asp:Label ID="mlbl_NewFarmDetails" runat="server" Text="New Farm Details" CssClass="DetailsLabel"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_ActiveFrom" runat="server" Text="Active From:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_ActiveFrom" runat="server" CausesValidation="True"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" RepeatDirection="Horizontal"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_ActiveFrom" runat="server" CausesValidation="True" CssClass="Textbox"
                                        ValidationGroup="MergeFarm" Width="65px"></asp:TextBox>
                                    <cc1:CalendarExtender ID="mtxb_ActiveFrom_CalendarExtender" runat="server" Enabled="True"
                                        Format="dd/MM/yyyy" PopupPosition="BottomRight" TargetControlID="mtxb_ActiveFrom">
                                    </cc1:CalendarExtender>
                                    <asp:RequiredFieldValidator ID="mrf__ActiveFrom" runat="server" ControlToValidate="mtxb_ActiveFrom"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="MergeFarm"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="mcmp_ActiveFrom" runat="server" ControlToValidate="mtxb_ActiveFrom"
                                        Display="Dynamic" ErrorMessage="dd/MM/yyyy" ForeColor="Red" Operator="DataTypeCheck"
                                        SetFocusOnError="True" Type="Date" ValidationGroup="MergeFarm"></asp:CompareValidator>
                                    <asp:CustomValidator ID="mcv_ActiveFrom" runat="server" ClientValidationFunction="mcv_ActiveFrom_Validate"
                                        ControlToValidate="mtxb_ActiveFrom" Display="Dynamic" ErrorMessage="Must be &gt; than the other active from dates"
                                        ForeColor="Red" SetFocusOnError="True" ValidationGroup="MergeFarm"></asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_LC_Farm" runat="server" Text="LC Farm:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_LC_Farm" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_LC_Farm" runat="server" Width="100px" CssClass="Textbox" Enabled="false"
                                        CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="mtxb_LC_Farm_AutoCompleteExtender" runat="server" CompletionInterval="100"
                                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                                        CompletionListItemCssClass="listitem" CompletionSetCount="100" ContextKey="LC_Farm"
                                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="" TargetControlID="mtxb_LC_Farm" UseContextKey="True">
                                    </cc1:AutoCompleteExtender>
                                    <asp:CustomValidator ID="mcv_LC_Farm" runat="server" ClientValidationFunction="mcv_String_Validate"
                                        ControlToValidate="mtxb_LC_Farm" Display="Dynamic" ErrorMessage="*" ForeColor="Red"
                                        SetFocusOnError="True" ValidateEmptyText="True" ValidationGroup="MergeFarm"></asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_Island" runat="server" Text="Island:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_Island" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_Island" runat="server" Width="100px" CssClass="Textbox" Enabled="false"
                                        CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <asp:CustomValidator ID="mcv_Island" runat="server" ClientValidationFunction="mcv_String_Validate"
                                        ControlToValidate="mtxb_Island" Display="Dynamic" ErrorMessage="*" ForeColor="Red"
                                        SetFocusOnError="True" ValidateEmptyText="True" ValidationGroup="MergeFarm"></asp:CustomValidator>
                                    <cc1:AutoCompleteExtender ID="mtxb_Island_AutoCompleteExtender" runat="server" CompletionInterval="100"
                                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                                        CompletionListItemCssClass="listitem" CompletionSetCount="100" ContextKey="Island"
                                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="" TargetControlID="mtxb_Island" UseContextKey="True">
                                    </cc1:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_Region" runat="server" Text="Region:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_Region" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_Region" runat="server" Width="100px" CssClass="Textbox" Enabled="false"
                                        CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <asp:CustomValidator ID="mcv_Region" runat="server" ClientValidationFunction="mcv_String_Validate"
                                        ControlToValidate="mtxb_Region" Display="Dynamic" ErrorMessage="*" ForeColor="Red"
                                        SetFocusOnError="True" ValidateEmptyText="True" ValidationGroup="MergeFarm"></asp:CustomValidator>
                                    <cc1:AutoCompleteExtender ID="mtxb_Region_AutoCompleteExtender" runat="server" CompletionInterval="100"
                                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                                        CompletionListItemCssClass="listitem" CompletionSetCount="100" ContextKey="Region"
                                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="" TargetControlID="mtxb_Region" UseContextKey="True">
                                    </cc1:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_Cluster_Id" runat="server" Text="Cluster Id:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_Cluster_Id" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_Cluster_Id" runat="server" Width="50px" CssClass="TextboxRight"
                                        Enabled="false" CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <asp:CompareValidator ID="mcmp_Cluster_Id" runat="server" ControlToValidate="mtxb_Cluster_Id"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                                        Type="Integer" ValidationGroup="MergeFarm"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_PAM_ClientID" runat="server" Text="PAM Client ID:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_PAM_ClientID" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_PAM_ClientID" runat="server" Width="50px" CssClass="TextboxRight"
                                        Enabled="false" CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <asp:CompareValidator ID="mcmp_PAM_ClientID" runat="server" ControlToValidate="mtxb_PAM_ClientID"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                                        Type="Integer" ValidationGroup="MergeFarm"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_PAM_CustomerNum" runat="server" Text="PAM Customer Num:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_PAM_CustomerNum" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_PAM_CustomerNum" runat="server" Width="50px" CssClass="TextboxRight"
                                        Enabled="false" CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <asp:CompareValidator ID="mcmp_PAM_CustomerNum" runat="server" ControlToValidate="mtxb_PAM_CustomerNum"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                                        Type="Integer" ValidationGroup="MergeFarm"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_FMS_ClientId" runat="server" Text="FMS Client Id:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_FMS_ClientId" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_FMS_ClientId" runat="server" Width="50px" CssClass="TextboxRight"
                                        Enabled="false" CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <asp:CompareValidator ID="mcmp_FMS_ClientId" runat="server" ControlToValidate="mtxb_FMS_ClientId"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                                        Type="Integer" ValidationGroup="MergeFarm"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_BANId" runat="server" Text="BAN Id:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_BANId" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_BANId" runat="server" Width="50px" CssClass="TextboxRight"
                                        Enabled="false" CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <asp:CompareValidator ID="mcmp_BANId" runat="server" ControlToValidate="mtxb_BANId"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                                        Type="Integer" ValidationGroup="MergeFarm"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_LabTestId" runat="server" Text="Lab Test Id:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_LabTestId" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_LabTestId" runat="server" Width="50px" CssClass="TextboxRight"
                                        Enabled="false" CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <asp:CompareValidator ID="mcmp_LabTestId" runat="server" ControlToValidate="mtxb_LabTestId"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                                        Type="Integer" ValidationGroup="MergeFarm"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_AllianceId" runat="server" Text="Alliance Id:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_AllianceId" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_AllianceId" runat="server" Width="50px" CssClass="TextboxRight"
                                        Enabled="false" CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <asp:CompareValidator ID="mcmp_AllianceId" runat="server" ControlToValidate="mtxb_AllianceId"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                                        Type="Integer" ValidationGroup="MergeFarm"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_DPR" runat="server" Text="DPR:" CssClass="DetailsLabel" Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_DPR" runat="server" RepeatDirection="Horizontal" CssClass="RadioButtonList"
                                        onclick="RBLChanged(this)" CausesValidation="True" ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:CheckBox ID="mcb_DPR" runat="server" Width="100px" Enabled="false" ValidationGroup="MergeFarm">
                                    </asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_MS_Import" runat="server" Text="MS Import:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_MS_Import" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:CheckBox ID="mcb_MS_Import" runat="server" Width="100px" Enabled="false" ValidationGroup="MergeFarm">
                                    </asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_IsDairyFarm" runat="server" Text="Is Dairy Farm:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_IsDairyFarm" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:CheckBox ID="mcb_IsDairyFarm" runat="server" Width="100px" Enabled="false" ValidationGroup="MergeFarm">
                                    </asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_ReportToNAIT" runat="server" Text="Report To NAIT:" CssClass="DetailsLabel"
                                        Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_ReportToNAIT" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:CheckBox ID="mcb_ReportToNAIT" runat="server" Width="100px" Enabled="false"
                                        ValidationGroup="MergeFarm"></asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="mlbl_DPRFeedEntryStartDate" runat="server" Text="DPR Feed Entry Start Date:"
                                        CssClass="DetailsLabel" Width="100px"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="mrbl_DPRFeedEntryStartDate" runat="server" RepeatDirection="Horizontal"
                                        CssClass="RadioButtonList" onclick="RBLChanged(this)" CausesValidation="True"
                                        ValidationGroup="MergeFarm">
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:TextBox ID="mtxb_DPRFeedEntryStartDate" runat="server" Width="65px" CssClass="Textbox"
                                        CausesValidation="True" ValidationGroup="MergeFarm"></asp:TextBox>
                                    <cc1:CalendarExtender ID="mtxb_DPRFeedEntryStartDate_CalendarExtender" runat="server"
                                        Enabled="True" Format="dd/MM/yyyy" PopupPosition="TopRight" TargetControlID="mtxb_DPRFeedEntryStartDate">
                                    </cc1:CalendarExtender>
                                    <asp:CompareValidator ID="mcmp_DPRFeedEntryStartDate" runat="server" ControlToValidate="mtxb_DPRFeedEntryStartDate"
                                        Display="Dynamic" ErrorMessage="dd/MM/yyyy" ForeColor="Red" Operator="DataTypeCheck"
                                        SetFocusOnError="True" Type="Date" ValidationGroup="MergeFarm"></asp:CompareValidator>
                                    <asp:CompareValidator ID="mcmp_DPRFeedEntryStartDate_ActiveFrom" runat="server" ControlToCompare="mtxb_ActiveFrom"
                                        ControlToValidate="mtxb_DPRFeedEntryStartDate" Display="Dynamic" ErrorMessage="&lt; Active From"
                                        ForeColor="Red" Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date"
                                        ValidationGroup="MergeFarm"></asp:CompareValidator>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <asp:Button ID="bt_SaveMergeFarms" runat="server" OnClick="bt_SaveMergeFarms_Click"
                        Text="Save" ValidationGroup="MergeFarm" Width="75" />
                    <asp:Button ID="bt_CancelMergeFarms" runat="server" CausesValidation="False" OnClick="bt_CancelMergeFarms_Click"
                        Text="Cancel" Width="75" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Button ID="bt_NewFarmHidden" runat="server" Text="Button" Style="display: none"
        OnClick="btn_Hidden_Click" />
    <cc1:ModalPopupExtender ID="mpe_NewFarm" runat="server" TargetControlID="bt_NewFarmHidden"
        PopupControlID="pnl_NewFarm" Enabled="True" BackgroundCssClass="modalBackground"
        DropShadow="true">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnl_NewFarm" runat="server" CssClass="modalPopup" Style="display: none">
        <br />
        <table>
            <tr>
                <td align="center">
                    <asp:Label ID="nlbl_DataFields" runat="server" CssClass="DetailsLabel" Text="Fields"></asp:Label>
                </td>
                <td align="center">
                    <asp:Label ID="nlbl_NewFarmDetails" runat="server" CssClass="DetailsLabel" Text="New Farm Details"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_ActiveFrom" runat="server" CssClass="DetailsLabel" Text="Active From:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_ActiveFrom" runat="server" CausesValidation="True" CssClass="Textbox"
                        ValidationGroup="NewFarm" Width="65px"></asp:TextBox>
                    <cc1:CalendarExtender ID="ntxb_ActiveFrom_CalendarExtender" runat="server" Enabled="True"
                        Format="dd/MM/yyyy" PopupPosition="BottomRight" TargetControlID="ntxb_ActiveFrom">
                    </cc1:CalendarExtender>
                    <asp:RequiredFieldValidator ID="nrf_ActiveFrom" runat="server" ControlToValidate="ntxb_ActiveFrom"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="NewFarm"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="ncmp_ActiveFrom" runat="server" ControlToValidate="ntxb_ActiveFrom"
                        Display="Dynamic" ErrorMessage="dd/MM/yyyy" ForeColor="Red" Operator="DataTypeCheck"
                        SetFocusOnError="True" Type="Date" ValidationGroup="NewFarm"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_LC_Farm" runat="server" CssClass="DetailsLabel" Text="LC Farm:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_LC_Farm" runat="server" CausesValidation="True" CssClass="Textbox"
                        ValidationGroup="NewFarm" Width="100px"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="ntxb_LC_Farm_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="LC_Farm"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_LC_Farm" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_Island" runat="server" CssClass="DetailsLabel" Text="Island:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_Island" runat="server" CausesValidation="True" CssClass="Textbox"
                        ValidationGroup="NewFarm" Width="100px"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="ntxb_Island0_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="Island"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_Island" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_Region" runat="server" CssClass="DetailsLabel" Text="Region:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_Region" runat="server" CausesValidation="True" CssClass="Textbox"
                        ValidationGroup="NewFarm" Width="100px"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="ntxb_Region0_AutoCompleteExtender" runat="server" CompletionInterval="10"
                        CompletionListCssClass="list" CompletionListHighlightedItemCssClass="hoverlistitem"
                        CompletionListItemCssClass="listitem" CompletionSetCount="10" ContextKey="Region"
                        DelimiterCharacters="" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="" TargetControlID="ntxb_Region" UseContextKey="True">
                    </cc1:AutoCompleteExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_Cluster_Id" runat="server" CssClass="DetailsLabel" Text="Cluster Id:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_Cluster_Id" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewFarm" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_Cluster_Id" runat="server" ControlToValidate="ntxb_Cluster_Id"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewFarm"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_PAM_ClientID" runat="server" CssClass="DetailsLabel" Text="PAM Client ID:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_PAM_ClientID" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewFarm" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_PAM_ClientID" runat="server" ControlToValidate="ntxb_PAM_ClientID"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewFarm"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_PAM_CustomerNum" runat="server" CssClass="DetailsLabel" Text="PAM Customer Num:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_PAM_CustomerNum" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewFarm" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_PAM_CustomerNum" runat="server" ControlToValidate="ntxb_PAM_CustomerNum"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewFarm"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_FMS_ClientId" runat="server" CssClass="DetailsLabel" Text="FMS Client Id:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_FMS_ClientId" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewFarm" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_FMS_ClientId" runat="server" ControlToValidate="ntxb_FMS_ClientId"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewFarm"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_BANId" runat="server" CssClass="DetailsLabel" Text="BAN Id:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_BANId" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewFarm" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_BANId" runat="server" ControlToValidate="ntxb_BANId"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewFarm"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_LabTestId" runat="server" CssClass="DetailsLabel" Text="Lab Test Id:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_LabTestId" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewFarm" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_LabTestId" runat="server" ControlToValidate="ntxb_LabTestId"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewFarm"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_AllianceId" runat="server" CssClass="DetailsLabel" Text="Alliance Id:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_AllianceId" runat="server" CausesValidation="True" CssClass="TextboxRight"
                        ValidationGroup="NewFarm" Width="50px"></asp:TextBox>
                    <asp:CompareValidator ID="ncmp_AllianceId" runat="server" ControlToValidate="ntxb_AllianceId"
                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True"
                        Type="Integer" ValidationGroup="NewFarm"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_DPR" runat="server" CssClass="DetailsLabel" Text="DPR:" Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:CheckBox ID="ncb_DPR" runat="server" ValidationGroup="NewFarm" Width="100px" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_MS_Import" runat="server" CssClass="DetailsLabel" Text="MS Import:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:CheckBox ID="ncb_MS_Import" runat="server" ValidationGroup="NewFarm" Width="100px" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_IsDairyFarm" runat="server" CssClass="DetailsLabel" Text="Is Dairy Farm:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:CheckBox ID="ncb_IsDairyFarm" runat="server" ValidationGroup="NewFarm" Width="100px" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_ReportToNAIT" runat="server" CssClass="DetailsLabel" Text="Report To NAIT:"
                        Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:CheckBox ID="ncb_ReportToNAIT" runat="server" ValidationGroup="NewFarm" Width="100px" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="nlbl_DPRFeedEntryStartDate" runat="server" CssClass="DetailsLabel"
                        Text="DPR Feed Entry Start Date:" Width="100px"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="ntxb_DPRFeedEntryStartDate" runat="server" CausesValidation="True"
                        CssClass="Textbox" ValidationGroup="NewFarm" Width="65px"></asp:TextBox>
                    <cc1:CalendarExtender ID="ntxb_DPRFeedEntryStartDate_CalendarExtender" runat="server"
                        Enabled="True" Format="dd/MM/yyyy" PopupPosition="TopRight" TargetControlID="ntxb_DPRFeedEntryStartDate">
                    </cc1:CalendarExtender>
                    <asp:CompareValidator ID="ncmp_DPRFeedEntryStartDate" runat="server" ControlToValidate="ntxb_DPRFeedEntryStartDate"
                        Display="Dynamic" ErrorMessage="dd/MM/yyyy" ForeColor="Red" Operator="DataTypeCheck"
                        SetFocusOnError="True" Type="Date" ValidationGroup="NewFarm"></asp:CompareValidator>
                    <asp:CompareValidator ID="ncmp_DPRFeedEntryStartDate_ActiveFrom" runat="server" ControlToCompare="ntxb_ActiveFrom"
                        ControlToValidate="ntxb_DPRFeedEntryStartDate" Display="Dynamic" ErrorMessage="&lt; Active From"
                        ForeColor="Red" Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date"
                        ValidationGroup="NewFarm"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="bt_SaveNewFarms" runat="server" OnClick="bt_SaveNewFarms_Click" Text="Save"
                        ValidationGroup="NewFarm" Width="75" />
                    <asp:Button ID="bt_CancelNewFarms" runat="server" CausesValidation="False" OnClick="bt_CancelNewFarms_Click"
                        Text="Cancel" Width="75" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:HiddenField ID="hf_SK_FarmId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_LC_Farm" runat="server" Value="All" />
    <asp:HiddenField ID="hf_farm_id" runat="server" Value="All" />
    <asp:HiddenField ID="hf_PAM_ClientID" runat="server" Value="All" />
    <asp:HiddenField ID="hf_PAM_CustomerNum" runat="server" Value="All" />
    <asp:HiddenField ID="hf_FMS_ClientId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_DPR" runat="server" Value="All" />
    <asp:HiddenField ID="hf_MS_Import" runat="server" Value="All" />
    <asp:HiddenField ID="hf_IsActive" runat="server" Value="All" />
    <asp:HiddenField ID="hf_IsDairyFarm" runat="server" Value="All" />
    <asp:HiddenField ID="hf_Island" runat="server" Value="All" />
    <asp:HiddenField ID="hf_Region" runat="server" Value="All" />
    <asp:HiddenField ID="hf_Cluster_Id" runat="server" Value="All" />
    <asp:HiddenField ID="hf_ActiveFrom" runat="server" Value="All" />
    <asp:HiddenField ID="hf_ActiveTo" runat="server" Value="All" />
    <asp:HiddenField ID="hf_BANId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_LabTestId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_AllianceId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_LastFarmId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_MapsToFarmId" runat="server" Value="All" />
    <asp:HiddenField ID="hf_DPRFeedEntryStartDate" runat="server" Value="All" />
    <asp:HiddenField ID="hf_ReportToNAIT" runat="server" Value="All" />
    <asp:HiddenField ID="hdf_SortBy" runat="server" Value="LC_Farm" />
    <asp:HiddenField ID="hdf_SortDirection" runat="server" Value="ASC" />
    <asp:HiddenField ID="hdf_PopUpVisible" runat="server" Value="false" />
    <asp:HiddenField ID="hdf_PopUp" runat="server" Value="false" />
    <script type="text/javascript">

        function pageLoad() {
            fxheaderInit('<%= gv_Farms.ClientID %>', 750, 1, 0, $('#<%= gv_Farms.ClientID %>').width() + 18);
            fxheader();
        }

    </script>
</asp:Content>
