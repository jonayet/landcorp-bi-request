<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" ValidateRequest="false" Inherits="_ApplicationErrors" MaintainScrollPositionOnPostback="true" Codebehind="ApplicationErrors.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    </asp:ScriptManagerProxy>
    <script src="Scripts/LU_Farms.js" type="text/javascript"></script>
    <script src="Scripts/fxHeader.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
    <script src="Scripts/gridviewScroll.js" type="text/javascript"></script>
    <table>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Start Date:" CssClass="Label"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txb_StartDate" runat="server" CssClass="Textbox" Width="65px" 
                    onload="txb_StartDate_Load" AutoPostBack="True" 
                    ontextchanged="txb_StartDate_TextChanged"></asp:TextBox>
                <cc1:CalendarExtender ID="txb_StartDate_CalendarExtender" runat="server" 
                    Enabled="True" Format="dd/MM/yyyy" TargetControlID="txb_StartDate">
                </cc1:CalendarExtender>
            </td>
            <td>
                <asp:Label ID="Label2" runat="server" Text="End Date:" CssClass="Label"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txb_EndDate" runat="server" CssClass="Textbox" Width="65px" 
                    onload="txb_EndDate_Load" AutoPostBack="True" 
                    ontextchanged="txb_EndDate_TextChanged"></asp:TextBox>
                <cc1:CalendarExtender ID="txb_EndDate_CalendarExtender" runat="server" 
                    Enabled="True" Format="dd/MM/yyyy" TargetControlID="txb_EndDate">
                </cc1:CalendarExtender>
            </td>
            <td>
                <asp:Label ID="lbl_Response" runat="server" Text="Finished" Visible="False" ForeColor="Red"
                    Font-Bold="True"></asp:Label>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td valign="top">
                <asp:GridView ID="gv_Errors" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        OnDataBound="gv_DataBound" ShowHeaderWhenEmpty="True" SkinID="GridViewSkin" OnRowDataBound="gv_RowDataBound"
        OnPageIndexChanging="gv_Errors_PageIndexChanging" PageSize="20">
                    <Columns>
                        <asp:TemplateField SortExpression="AppName" HeaderText="AppName">
                            <HeaderTemplate>
                                <asp:DropDownList ID="dd_AppName" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                                </asp:DropDownList>
                                <br />
                                <asp:LinkButton ID="lb_AppName" runat="server" Text="Application" OnClick="lb_Sort_Click"></asp:LinkButton>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_AppName" runat="server" Text='<%# Eval("AppName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="FullName" HeaderText="FullName">
                            <HeaderTemplate>
                                <asp:DropDownList ID="dd_FullName" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                                </asp:DropDownList>
                                <br />
                                <asp:LinkButton ID="lb_FullName" runat="server" Text="Full Name" OnClick="lb_Sort_Click"></asp:LinkButton>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_FullName" runat="server" Text='<%# Eval("FullName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="TheDate" HeaderText="TheDate">
                            <HeaderTemplate>
                                <asp:DropDownList ID="dd_TheDate" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                                </asp:DropDownList>
                                <br />
                                <asp:LinkButton ID="lb_TheDate" runat="server" Text="Date" OnClick="lb_Sort_Click"></asp:LinkButton>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_TheDate" runat="server" Text='<%# Eval("AddedDate", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="ErrorType" HeaderText="ErrorType">
                            <HeaderTemplate>
                                <asp:DropDownList ID="dd_ErrorType" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                                </asp:DropDownList>
                                <br />
                                <asp:LinkButton ID="lb_ErrorType" runat="server" Text="Type" OnClick="lb_Sort_Click"></asp:LinkButton>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_ErrorType" runat="server" Text='<%# Eval("ErrorType") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="TrimmedErrorString" HeaderText="TrimmedErrorString">
                            <HeaderTemplate>
                                <asp:DropDownList ID="dd_TrimmedErrorString" runat="server" AutoPostBack="True" CssClass="MatchDropdownList"
                        OnSelectedIndexChanged="FilterGridView">
                                </asp:DropDownList>
                                <br />
                                <asp:LinkButton ID="lb_TrimmedErrorString" runat="server" Text="Error" OnClick="lb_Sort_Click"></asp:LinkButton>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="lb_TrimmedErrorString" runat="server" 
                        Text='<%# Eval("TrimmedErrorString") %>' onclick="lb_TrimmedErrorString_Click" Enabled='<%# Eval("LBActive") %>'></asp:LinkButton>
                                <asp:HiddenField ID="hf_ErrorString" runat="server" Value='<%# Eval("ErrorString") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle VerticalAlign="Top" />
                </asp:GridView>
            </td>
            <td width="10px">
            </td>
            <td valign="top">
                <asp:TextBox ID="txb_ErrorString" runat="server" Height="750px" ReadOnly="True" 
                    TextMode="MultiLine" Width="600px" CssClass="Textbox" Visible="False"></asp:TextBox>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hf_AppName" runat="server" Value="All" />
    <asp:HiddenField ID="hf_FullName" runat="server" Value="All" />
    <asp:HiddenField ID="hf_AddedDate" runat="server" Value="All" />
    <asp:HiddenField ID="hf_TheDate" runat="server" Value="All" />
    <asp:HiddenField ID="hf_ErrorType" runat="server" Value="All" />
    <asp:HiddenField ID="hf_TrimmedErrorString" runat="server" Value="All" />
    <asp:HiddenField ID="hdf_SortBy" runat="server" Value="AddedDate" />
    <asp:HiddenField ID="hdf_SortDirection" runat="server" Value="ASC" />
    <script type="text/javascript">

//        function pageLoad() {
//            fxheaderInit('<%= gv_Errors.ClientID %>', 750, 1, 0, $('#<%= gv_Errors.ClientID %>').width() + 18);
//            fxheader();
//        }

    </script>
</asp:Content>
