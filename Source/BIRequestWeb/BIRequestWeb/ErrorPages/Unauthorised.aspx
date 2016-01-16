<%@ Page Title="Unauthorised" Language="C#" AutoEventWireup="true" CodeBehind="Unauthorised.aspx.cs" Inherits="BiRequestWeb.ErrorPages.Unauthorised" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%">
                <tr>
                    <td align="center" valign="middle">
                        <br />
                        <br />
                        <br />
                        <br />
                        <br />
                        <br />
                        <table>
                            <tr>
                                <td valign="top">
                                    <asp:Image ID="img_Unauthorised" runat="server" ImageUrl="~/Images/Unauthorised.jpg" />
                                </td>
                                <td valign="top" align="left" width="450px">
                                    <asp:Label ID="lbl_Header" runat="server" CssClass="DateLabel"
                                        Text="Unauthorised!" ForeColor="Red"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Label ID="lbl_Name" runat="server" Text="Hi" CssClass="Label"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Label ID="Label2" runat="server" CssClass="Label" Text="You are not authorised to view this page please contact an one of the following for access."></asp:Label>
                                    <br />
                                    <br />
                                    <asp:GridView ID="gv_AppOwners" runat="server" AllowSorting="True"
                                        AutoGenerateColumns="False" DataKeyNames="FullName" DataSourceID="ds_AppOwners" ShowHeader="false"
                                        OnRowDataBound="gv_AppOwners_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Full Name" SortExpression="FullName">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hpl_MailTo" runat="server"
                                                        Text='<%# Eval("FullName")%>'></asp:HyperLink>
                                                    <asp:HiddenField ID="hf_EmailAddress" runat="server" Value='<%# Eval("EmailAddress") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Phone Number" SortExpression="PhoneNumber">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_PhoneNumber" runat="server" CssClass="Label"
                                                        Text='<%# Eval("PhoneNumber") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="ds_AppOwners" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:Admin %>"
                                        ProviderName="<%$ ConnectionStrings:Admin.ProviderName %>"
                                        SelectCommand="wsp_AppOwnerDetails_Get" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="AppId" SessionField="AppId" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
