<%@ Page Language="C#" AutoEventWireup="true" Inherits="BiRequestWeb.ErrorPages._Oops" StylesheetTheme="Theme" Title="Oops" CodeBehind="Oops.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
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
                                <asp:Image ID="img_Oops" runat="server" ImageUrl="~/Images/Oops.jpg" />
                            </td>
                            <td valign="top" align="left" width="450px">
                                <asp:Label ID="lbl_ErrorHeader" runat="server" CssClass="DateLabel" Text="An Error Has Occured"></asp:Label>
                                <br />
                                <br />
                                <asp:Label ID="Label1" runat="server" CssClass="Label" Text="An unexpected error occured on our website."></asp:Label>
                                <br />
                                <asp:Label ID="Label2" runat="server" CssClass="Label" Text="It has been logged."></asp:Label>
                                <br />
                                <asp:Label ID="Label3" runat="server" CssClass="Label" Text="If it happens again please contact an Administrator."></asp:Label>
                                <br />
                                <br />
                                <asp:LinkButton ID="lb_ShowDetails" runat="server">Details</asp:LinkButton>
                                <asp:Panel ID="pnl_Details" runat="server" CssClass="FVPanel">
                                    <asp:Label ID="lbl_DetailsHeader" runat="server" Font-Bold="True"
                                        Font-Underline="True" OnLoad="lbl_DetailsHeader_Load" Width="400px"></asp:Label>
                                    <br />
                                    <asp:Label ID="lbl_Details" runat="server" OnLoad="lbl_Details_Load" Width="400px"></asp:Label>
                                </asp:Panel>
                                <cc1:CollapsiblePanelExtender ID="pnl_Details_CollapsiblePanelExtender" ExpandControlID="lb_ShowDetails"
                                    SuppressPostBack="True" AutoCollapse="False" AutoExpand="False" Collapsed="true"
                                    CollapseControlID="lb_ShowDetails" runat="server" TargetControlID="pnl_Details">
                                </cc1:CollapsiblePanelExtender>
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
