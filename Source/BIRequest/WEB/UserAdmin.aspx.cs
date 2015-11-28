using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using AjaxControlToolkit;
using System.DirectoryServices.AccountManagement;
using System.Web.Configuration;

public partial class UserAdmin : System.Web.UI.Page
{
    protected void myIframe_Load(object sender, EventArgs e)
    {
        string AccessURL = WebConfigurationManager.AppSettings["AccessURL"].ToString();
        Uri uri = Request.Url;
        string baseURL = AccessURL + "?AppId=" + Session["AppId"].ToString() + "&AccessUserId=" + Session["UserId"].ToString();
        myIframe.Attributes.Add("src", baseURL);
    }
}