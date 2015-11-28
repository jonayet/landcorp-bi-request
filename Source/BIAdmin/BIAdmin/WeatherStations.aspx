<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="_WeatherStations" Codebehind="WeatherStations.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
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
                <asp:CheckBox ID="cb_ActiveOnly" runat="server" AutoPostBack="True" Checked="True"
                    Text="Active Only" oncheckedchanged="cb_ActiveOnly_CheckedChanged" />
            </td>
            <td>
                <asp:Label ID="lbl_Response" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:GridView ID="gv_WeatherStations" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        SkinID="GridViewSkin" OnSorting="gv_WeatherStations_Sorting" DataKeyNames="SK_WTHStationFarmId">
        <Columns>
            <asp:TemplateField SortExpression="LC_Farm" HeaderText="Farm">
                <ItemTemplate>
                    <asp:Label ID="lbl_LC_Farm" runat="server" Text='<%# Eval("LC_Farm") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="dd_farm_id" runat="server" CssClass="DropdownList" OnLoad="dd_farm_id_Load"
                        SelectedValue='<%# Bind("farm_id") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField SortExpression="FarmDesc" HeaderText="Weather Station">
                <ItemTemplate>
                    <asp:Label ID="lbl_FarmDesc" runat="server" Text='<%# Eval("FarmDesc") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="dd_WTH_StationId" runat="server" SelectedValue='<%# Bind("WTH_StationId") %>'
                        CssClass="DropdownList" OnLoad="dd_WTH_StationId_Load">
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField SortExpression="FarmIsActive" HeaderText="Farm Is Active">
                <ItemTemplate>
                    <asp:CheckBox ID="cb_FarmIsActive" runat="server" Checked='<%# Eval("FarmIsActive") %>'
                        Enabled="false"></asp:CheckBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="cb_FarmIsActive" runat="server" Checked='<%# Eval("FarmIsActive") %>'
                        Enabled="false"></asp:CheckBox>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="WeatherStationIsActive" HeaderText="Weather Station Is Active">
                <ItemTemplate>
                    <asp:CheckBox ID="cb_WeatherStationIsActive" runat="server" Checked='<%# Eval("WeatherStationIsActive") %>'
                        Enabled="false"></asp:CheckBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="cb_WeatherStationIsActive" runat="server" Checked='<%# Eval("WeatherStationIsActive") %>'
                        Enabled="false"></asp:CheckBox>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField SortExpression="MappingIsActive" HeaderText="Mapping Is Active">
                <ItemTemplate>
                    <asp:CheckBox ID="cb_MappingIsActive" runat="server" Checked='<%# Eval("MappingIsActive") %>'
                        Enabled="false"></asp:CheckBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="cb_MappingIsActive" runat="server" Checked='<%# Eval("MappingIsActive") %>'
                        Enabled="false"></asp:CheckBox>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="lb_Update" runat="server" CausesValidation="True" Text="Update"
                        CssClass="Label" OnClick="lb_Update_Click"></asp:LinkButton>
                    <asp:LinkButton ID="lb_Cancel" runat="server" CausesValidation="False" Text="Cancel"
                        CssClass="Label" OnClick="lb_Cancel_Click"></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="lb_Edit" runat="server" CausesValidation="False" Text="Edit"
                        CssClass="Label" OnClick="lb_Edit_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:HiddenField ID="hdf_SortBy" runat="server" Value="LC_Farm" />
    <asp:HiddenField ID="hdf_SortDirection" runat="server" Value="ASC" />
</asp:Content>
