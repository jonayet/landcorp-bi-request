<%@ Page Language="C#" AutoEventWireup="true" Inherits="_404" StylesheetTheme="Theme"
    Title="Eaten!" CodeBehind="404.aspx.cs" %>

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
                            <td>
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/404.jpg" />
                            </td>
                            <td align="left">
                                <asp:Label ID="lbl_ErrorHeader" runat="server" CssClass="DateLabel" Text="Oh no it looks like the page has been eaten!"></asp:Label>
                                <br />
                                <br />
                                <asp:Label ID="Label2" runat="server" CssClass="Label" Text="It has been logged."></asp:Label>
                                <br />
                                <asp:Label ID="Label3" runat="server" CssClass="Label" Text="If it happens again please contact an Administrator."></asp:Label>
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
