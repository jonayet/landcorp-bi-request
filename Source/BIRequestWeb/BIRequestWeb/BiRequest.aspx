<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BiRequest.aspx.cs" Inherits="BiRequestWeb.BiRequest" %>

<asp:Content ID="BiRequestForm" ContentPlaceHolderID="MainContent" runat="server">
    <p>Do you have a name?</p>

    <div class="form-group">
        <label for="" class="col-sm-3 control-label">Name of Requestor</label>
        <div class="col-sm-9">
            <asp:TextBox runat="server" ID="NameBox" class="form-control" ClientIDMode="Static" SkinID="nameOfRequestor" placeholder="Name of Requestor"/>
        </div>
    </div>

    <p>
        <asp:Label runat="server" ID="TextBox1" />
        <input type="submit" value="Submit" />
    </p>
</asp:Content>
