<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="_Reporting" MaintainScrollPositionOnPostback="true" Codebehind="Reporting.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <script src="Scripts/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <script src="Scripts/ui.dropdownchecklist-1.4-min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            $(document).ready(function () {
                $('#<%= lbl_Response.ClientID %>').delay(3000).fadeOut(4000, function () {
                });
            });
        });

        function pageLoad() {
            $("select[name*='lbx_UserTypes']").dropdownchecklist({
                emptyText: "Please select role ..."
                , width: 150
                , onComplete: function (selector) {
                    if (selector.id.indexOf("fv_") < 0) {
                        __doPostBack(document.getElementById("#<%= lbx_UserTypes.UniqueID %>"), '');
                    }
                }
            });


        }

        function cbIsReportChecked(sender) {
            var cbIsReport = document.getElementById(sender.id);

            var dd_Path = document.getElementById(sender.id.replace("cb_IsReport", "dd_Path"));
            var rf_dd_Path = document.getElementById(sender.id.replace("cb_IsReport", "rf_dd_Path"));
            var txb_ReportAdditionalURL = document.getElementById(sender.id.replace("cb_IsReport", "txb_ReportAdditionalURL"));
            var txb_AltURL = document.getElementById(sender.id.replace("cb_IsReport", "txb_AltURL"));
            var rf_txb_AltURL = document.getElementById(sender.id.replace("cb_IsReport", "rf_txb_AltURL"));

            dd_Path.disabled = cbIsReport.checked == false ? true : false;
            rf_dd_Path.enabled = cbIsReport.checked;
            txb_ReportAdditionalURL.disabled = cbIsReport.checked == false ? true : false;
            txb_AltURL.disabled = cbIsReport.checked;
            rf_txb_AltURL.enabled = cbIsReport.checked == false ? true : false;
            Page_ClientValidate();

            //            alert(dd_Path.disabled + " : " + rf_dd_Path.enabled + " : " + txb_ReportAdditionalURL.disabled + " : " + txb_AltURL.disabled + " : " + rf_txb_AltURL.enabled);
        }

        var LinkButton;
        function CheckNames(source, replaceText) {
            var dd_Source = document.getElementById('<%= dd_Source.ClientID %>');

            var hf_URLId = document.getElementById(source.id.replace(replaceText, "hf_URLId"));
            var txb_URLHeading = document.getElementById(source.id.replace(replaceText, "txb_URLHeading"));
            var txb_URLName = document.getElementById(source.id.replace(replaceText, "txb_URLName"));

            var Source = dd_Source.options[dd_Source.selectedIndex].value;
            var URLId = hf_URLId.value;
            var URLHeading = txb_URLHeading.value;
            var URLName = txb_URLName.value;

            LinkButton = document.getElementById(source.id.replace(replaceText, "lb_Commit"));

            PageMethods.ValidateNames(Source, URLId, URLHeading, URLName, cv_txb_URLName_Result);
        }

        function cv_txb_URLName_Result(result) {
            if (!result) {
                var lbl_Response = document.getElementById('<%= lbl_Response.ClientID %>');
                lbl_Response.innerHTML = "Heading and Name combination creates a duplicate!";
                $('#<%= lbl_Response.ClientID %>').show().delay(3000).fadeOut(4000, function () {
                });
            }
            LinkButton.disabled = result == false ? true : false;
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
                    <asp:ListItem>UAT</asp:ListItem>
                    <asp:ListItem>LIVE</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label ID="lbl_UserTypes" runat="server" CssClass="Label" Text="Role"></asp:Label>
            </td>
            <td>
                <asp:ListBox ID="lbx_UserTypes" runat="server" SelectionMode="Multiple" OnSelectedIndexChanged="lbx_UserTypes_SelectedIndexChanged">
                </asp:ListBox>
            </td>
            <td>
            </td>
            <td>
                <asp:Label ID="lbl_Response" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td valign="top">
                <asp:GridView ID="gv_Links" runat="server" SkinID="GridViewSkin" AutoGenerateColumns="False"
                    OnRowDataBound="gv_Links_RowDataBound" DataKeyNames="URLId">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lb_Select" runat="server" CausesValidation="False" Text="Select"
                                    OnClick="lb_Select_Click"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="hdl_URLHeading" runat="server" CssClass="Label" Text="Heading"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_URLHeading" runat="server" CssClass="Label" Text='<%# Eval("URLHeading") %>'></asp:Label>
                                <asp:HiddenField ID="hf_enabled" runat="server" Value='<%# Eval("Active") %>'></asp:HiddenField>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="hdl_URLName" runat="server" CssClass="Label" Text="Name"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:HyperLink ID="hpl_URL" runat="server" CssClass="Label" Text='<%# Eval("URLName") %>'
                                    NavigateUrl='<%# Eval("URL") %>' Target="_blank"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="hdl_URLDescription" runat="server" CssClass="Label" Text="Description"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_URLDescription" runat="server" CssClass="Label" Text='<%# Eval("URLDescription") %>'
                                    Width="275px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="hdl_Tags" runat="server" CssClass="Label" Text="Tags"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_Tags" runat="server" CssClass="Label" Text='<%# Eval("Tags") %>'
                                    Width="150px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="hdl_Active" runat="server" CssClass="Label" Text="Active"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="cb_Active" runat="server" Checked='<%# Eval("Active") %>' Enabled="false" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lb_DeleteRow" runat="server" CausesValidation="False" Text="Delete"
                                    CssClass="Label" OnClick="lb_DeleteRow_Click"></asp:LinkButton>
                                <cc1:ConfirmButtonExtender ID="lb_DeleteRowConfirmButtonExtender" runat="server"
                                    ConfirmText="Delete???" Enabled="True" TargetControlID="lb_DeleteRow">
                                </cc1:ConfirmButtonExtender>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:HiddenField ID="hf_Type" runat="server" />
            </td>
            <td valign="top" width="10px">
            </td>
            <td valign="top">
                <asp:FormView ID="fv_Links" runat="server" DataKeyNames="URLId" OnItemCommand="fv_Links_ItemCommand"
                    OnItemInserted="fv_Links_ItemInserted" OnItemInserting="fv_Links_ItemInserting"
                    OnModeChanged="fv_Links_ModeChanged" OnModeChanging="fv_Links_ModeChanging" OnDataBound="fv_Links_DataBound"
                    OnItemUpdated="fv_Links_ItemUpdated" OnItemUpdating="fv_Links_ItemUpdating">
                    <EmptyDataTemplate>
                        <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CssClass="Label"
                            Text="New Link" CommandName="New" />
                    </EmptyDataTemplate>
                    <InsertItemTemplate>
                        <asp:Panel ID="pnl_New" runat="server" CssClass="FVPanel">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_URLHeading" runat="server" CssClass="Label" Text="Heading:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_URLHeading" runat="server" CssClass="Textbox" Text="" MaxLength="50"
                                            Width="275px" ValidationGroup="New" onchange="CheckNames(this, 'txb_URLHeading')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rf_txb_URLHeading" runat="server" ControlToValidate="txb_URLHeading"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="New"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_URLName" runat="server" CssClass="Label" Text="Name:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_URLName" runat="server" CssClass="Textbox" Text="" MaxLength="50"
                                            Width="275px" ValidationGroup="New" onchange="CheckNames(this, 'txb_URLName')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rf_txb_URLName" runat="server" ControlToValidate="txb_URLName"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="New"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_IsReport" runat="server" CssClass="Label" Text="Is Report:"></asp:Label>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="cb_IsReport" runat="server" Checked="true" onclick="cbIsReportChecked(this)"
                                                        ValidationGroup="New" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="dd_Path" runat="server" CssClass="DropdownList" ValidationGroup="New">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="rf_dd_Path" runat="server" ControlToValidate="dd_Path"
                                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="New"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_ReportAdditionalURL" runat="server" CssClass="Label" Text="Parameters:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_ReportAdditionalURL" runat="server" CssClass="Textbox" Text=""
                                            MaxLength="1900" Width="275px" ValidationGroup="New"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_AltURL" runat="server" CssClass="Label" Text="Alt URL:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_AltURL" runat="server" CssClass="Textbox" Text="" MaxLength="2000"
                                            Width="275px" ValidationGroup="New"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rf_txb_AltURL" runat="server" ControlToValidate="txb_AltURL"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="New"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_Description" runat="server" CssClass="Label" Text="Description:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_URLDescription" runat="server" CssClass="Textbox" Text="" MaxLength="255"
                                            Width="275px" ValidationGroup="New" Height="40px" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_Tags" runat="server" CssClass="Label" Text="Tags:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_Tags" runat="server" CssClass="Textbox" Text="" Width="275px"
                                            ValidationGroup="New" Height="40px" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_Active" runat="server" CssClass="Label" Text="Active:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="cb_Active" runat="server" Checked="true" ValidationGroup="New" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_Roles" runat="server" CssClass="Label" Text="Roles:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:ListBox ID="lbx_UserTypes" runat="server" SelectionMode="Multiple"></asp:ListBox>
                                        <asp:RequiredFieldValidator ID="rf_lbx_UserTypes" runat="server" ControlToValidate="lbx_UserTypes"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="New"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <asp:LinkButton ID="lb_Commit" runat="server" CausesValidation="True" CssClass="Label"
                                Text="Insert" ValidationGroup="New" CommandName="Insert" />
                            <asp:LinkButton ID="lb_Cancel" runat="server" CausesValidation="False" CssClass="Label"
                                Text="Cancel" CommandName="Cancel" />
                            <asp:HiddenField ID="hf_URLId" runat="server" Value="0" />
                        </asp:Panel>
                    </InsertItemTemplate>
                    <EditItemTemplate>
                        <asp:Panel ID="pnl_New" runat="server" CssClass="FVPanel">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_URLHeading" runat="server" CssClass="Label" Text="Heading:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_URLHeading" runat="server" CssClass="Textbox" Text='<%# Bind("URLHeading") %>'
                                            MaxLength="50" Width="275px" ValidationGroup="New" onchange="CheckNames(this, 'txb_URLHeading')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rf_txb_URLHeading" runat="server" ControlToValidate="txb_URLHeading"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="New"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_URLName" runat="server" CssClass="Label" Text="Name:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_URLName" runat="server" CssClass="Textbox" Text='<%# Bind("URLName") %>'
                                            MaxLength="50" Width="275px" ValidationGroup="New" onchange="CheckNames(this, 'txb_URLName')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rf_txb_URLName" runat="server" ControlToValidate="txb_URLName"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="New"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_IsReport" runat="server" CssClass="Label" Text="Report:"></asp:Label>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="cb_IsReport" runat="server" Checked='<%# Bind("IsReport") %>' onclick="cbIsReportChecked(this)"
                                                        ValidationGroup="New" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="dd_Path" runat="server" CssClass="DropdownList" ValidationGroup="New">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                        <asp:RequiredFieldValidator ID="rf_dd_Path" runat="server" ControlToValidate="dd_Path"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="New"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_ReportAdditionalURL" runat="server" CssClass="Label" Text="Parameters:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_ReportAdditionalURL" runat="server" CssClass="Textbox" Text='<%# Bind("ReportAdditionalURL") %>'
                                            MaxLength="1900" Width="275px" ValidationGroup="New"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_AltURL" runat="server" CssClass="Label" Text="Alt URL:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_AltURL" runat="server" CssClass="Textbox" Text='<%# Bind("AltURL") %>'
                                            MaxLength="2000" Width="275px" ValidationGroup="New"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rf_txb_AltURL" runat="server" ControlToValidate="txb_AltURL"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="New"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_Description" runat="server" CssClass="Label" Text="Description:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_URLDescription" runat="server" CssClass="Textbox" Text='<%# Bind("URLDescription") %>'
                                            MaxLength="255" Width="275px" ValidationGroup="New" Height="40px" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_Tags" runat="server" CssClass="Label" Text="Tags:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txb_Tags" runat="server" CssClass="Textbox" Text='<%# Bind("Tags") %>'
                                            Width="275px" ValidationGroup="New" Height="40px" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_Active" runat="server" CssClass="Label" Text="Active:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="cb_Active" runat="server" Checked='<%# Bind("Active") %>' ValidationGroup="New" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lhl_Roles" runat="server" CssClass="Label" Text="Roles:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:ListBox ID="lbx_UserTypes" runat="server" SelectionMode="Multiple"></asp:ListBox>
                                        <asp:RequiredFieldValidator ID="rf_lbx_UserTypes" runat="server" ControlToValidate="lbx_UserTypes"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationGroup="New"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <asp:LinkButton ID="lb_Commit" runat="server" CausesValidation="True" CssClass="Label"
                                Text="Update" ValidationGroup="New" CommandName="Update" />
                            <asp:LinkButton ID="lb_Cancel" runat="server" CausesValidation="False" CssClass="Label"
                                Text="Cancel" CommandName="Cancel" />
                            <asp:HiddenField ID="hf_URLId" runat="server" Value='<%# Eval("URLId") %>' />
                            <asp:HiddenField ID="hf_ReportGUID" runat="server" Value='<%# Eval("ReportGUID") %>' />
                        </asp:Panel>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="lb_New" runat="server" CausesValidation="False" CssClass="Label"
                            Text="New Link" CommandName="New" />
                    </ItemTemplate>
                </asp:FormView>
            </td>
        </tr>
    </table>
</asp:Content>
