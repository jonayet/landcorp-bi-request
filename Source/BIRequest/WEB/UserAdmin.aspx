<%@ Page Title="User Admin" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    Inherits="UserAdmin" MaintainScrollPositionOnPostback="true" CodeBehind="UserAdmin.aspx.cs" %>

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

            var myIframe = $('#<%= myIframe.ClientID %>').offset();

            var innerwidth = window.innerWidth - 25;
            var innerheight = window.innerHeight - 35;

            newheight = innerheight - parseInt(myIframe.top);
            newwidth = innerwidth - (parseInt(myIframe.left) * 2);

            if (newheight < 0) {
                newheight = 0;
            }

            if (newwidth < 0) {
                newwidth = 0;
            }

            document.getElementById('<%= myIframe.ClientID %>').height = (newheight) + "px";
            document.getElementById('<%= myIframe.ClientID %>').width = (newwidth) + "px";
        }

    </script>
    <iframe id="myIframe" runat="server" class="FVPanel" onload="myIframe_Load"></iframe>
</asp:Content>
