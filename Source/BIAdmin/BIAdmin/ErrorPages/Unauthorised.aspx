<%@ Page Language="C#" AutoEventWireup="true" Inherits="Unauthorised" StylesheetTheme="Theme"
    Title="Unauthorised" CodeBehind="Unauthorised.aspx.cs" %>

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
                                <asp:Image ID="img_Oops" runat="server" ImageUrl="~/Images/Unauthorised.jpg" />
                            </td>
                            <td valign="top" align="left" width="450px">
                                <asp:Label ID="lbl_Header" runat="server" CssClass="DateLabel" 
                                    Text="Unauthorised!" ForeColor="Red"></asp:Label>
                                <br />
                                <br />
                                <asp:Label ID="lbl_Name" runat="server" Text="Hi" CssClass="Label"></asp:Label>
                                <br />
                                <br />
                                <asp:Label ID="Label2" runat="server" CssClass="Label" Text="You are not authorised to view this page please contact an administrator for access."></asp:Label>
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
