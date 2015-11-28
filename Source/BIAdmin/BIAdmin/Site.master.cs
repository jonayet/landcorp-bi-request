using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;
using System.IO;
using System.Web.Configuration;
using System.Net;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Init(object sender, EventArgs e)
    {
        SetSessionVariables();
        CheckPageAuthorisation();
    }

    protected void SetSessionVariables()
    {
        int AppId = int.Parse(WebConfigurationManager.AppSettings["AppId"].ToString());
        string UserName = GetUserName(AppId);

        Session["AppId"] = AppId;
        Session["UserName"] = UserName;

        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Admin"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.CommandText = "wsp_AppUserDetails_Get";
        sqlCmd.CommandTimeout = 300;
        sqlCmd.Connection = sqlConn;

        SqlParameter pAppId = new SqlParameter("@AppId", SqlDbType.Int);
        SqlParameter pUserName = new SqlParameter("@UserName", SqlDbType.NVarChar, 50);

        pAppId.Value = AppId;
        pUserName.Value = UserName;

        sqlCmd.Parameters.Add(pAppId);
        sqlCmd.Parameters.Add(pUserName);

        sqlConn.Open();

        SqlDataReader rd = sqlCmd.ExecuteReader();
        if (rd.HasRows)
        {
            while (rd.Read())
            {
                for (int c = 0; c < rd.FieldCount; c++)
                {
                    string FieldName = rd.GetName(c);
                    string FieldValue = rd[FieldName].ToString();
                    Session[FieldName] = FieldValue;
                }
            }
        }

        rd.Close();
        rd.Dispose();
        sqlConn.Close();
        sqlConn.Dispose();
    }

    protected string GetUserName(int AppId)
    {
        string UserName = Regex.Replace(HttpContext.Current.User.Identity.Name, ".*\\\\(.*)", "$1", RegexOptions.None).ToUpper();      
        UserName = "BAILEYD";

        string QueryUserName = UserName;

        if (Request["UserName"] != null)
        {
            QueryUserName = Request["UserName"].ToString().ToUpper();
        }

        if (UserName != QueryUserName)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Admin"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_AppUserCheckQueryAccess_Get";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pAppId = new SqlParameter("@AppId", SqlDbType.Int);
            SqlParameter pUserName = new SqlParameter("@UserName", SqlDbType.NVarChar, 50);
            SqlParameter pQueryUserName = new SqlParameter("@QueryUserName", SqlDbType.NVarChar, 50);

            pAppId.Value = AppId;
            pUserName.Value = UserName;
            pQueryUserName.Value = QueryUserName;

            sqlCmd.Parameters.Add(pAppId);
            sqlCmd.Parameters.Add(pUserName);
            sqlCmd.Parameters.Add(pQueryUserName);

            sqlConn.Open();

            SqlDataReader rd = sqlCmd.ExecuteReader();
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    for (int c = 0; c < rd.FieldCount; c++)
                    {
                        UserName = rd["Username"].ToString();
                    }
                }
            }

            rd.Close();
            rd.Dispose();
            sqlConn.Close();
            sqlConn.Dispose();
        }

        return UserName;
    }

    private void CheckPageAuthorisation()
    {
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Admin"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.CommandText = "wsp_CheckPageAuthorisation";
        sqlCmd.Connection = sqlConn;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pAppId = new SqlParameter("@AppId", SqlDbType.Int);
        SqlParameter pUserId = new SqlParameter("@UserId", SqlDbType.Int);
        SqlParameter pUserTypeId = new SqlParameter("@UserTypeId", SqlDbType.Int);
        SqlParameter pPageURL = new SqlParameter("@PageURL", SqlDbType.NVarChar, 255);
        SqlParameter pIsOK = new SqlParameter("@IsOK", SqlDbType.Bit);

        pAppId.Value = int.Parse(WebConfigurationManager.AppSettings["AppId"].ToString());
        pUserId.Value = int.Parse(Session["UserId"].ToString());
        pUserTypeId.Value = int.Parse(Session["UserTypeId"].ToString());
        pPageURL.Value = Path.GetFileName(Request.Url.AbsolutePath);
        pIsOK.Direction = ParameterDirection.Output;

        sqlCmd.Parameters.Add(pAppId);
        sqlCmd.Parameters.Add(pUserId);
        sqlCmd.Parameters.Add(pUserTypeId);
        sqlCmd.Parameters.Add(pPageURL);
        sqlCmd.Parameters.Add(pIsOK);

        bool ShowRibbon = false;
        string PageTitle = "";
        bool ShowNavigation = false;
        bool HeadingApp = false;
        bool HeadingPageTitle = false;

        sqlConn.Open();

        SqlDataReader rd = sqlCmd.ExecuteReader();
        if (rd.HasRows)
        {
            while (rd.Read())
            {

                if (rd["ShowRibbon"] != DBNull.Value)
                {
                    ShowRibbon = bool.Parse(rd["ShowRibbon"].ToString());
                }

                if (rd["PageTitle"] != DBNull.Value)
                {
                    PageTitle = rd["PageTitle"].ToString();
                }

                if (rd["ShowNavigation"] != DBNull.Value)
                {
                    ShowNavigation = bool.Parse(rd["ShowNavigation"].ToString());
                }

                if (rd["HeadingApp"] != DBNull.Value)
                {
                    HeadingApp = bool.Parse(rd["HeadingApp"].ToString());
                }

                if (rd["HeadingPageTitle"] != DBNull.Value)
                {
                    HeadingPageTitle = bool.Parse(rd["HeadingPageTitle"].ToString());
                }
            }
        }

        sqlConn.Close();
        sqlConn.Dispose();

        if (!bool.Parse(pIsOK.Value.ToString()))
        {
            Response.Redirect("~/ErrorPages/Unauthorised.aspx?Page=" + Request.Url.PathAndQuery);
        }
        else
        {
            Page.Title = PageTitle;
            divHeader.Visible = ShowRibbon;

            if (ShowRibbon && !Page.IsPostBack)
            {
                string AccessSource = " <font color=\"Red\">" + WebConfigurationManager.AppSettings["AccessSource"].ToString() + "</font>";
                lbl_Title.Text = "";

                if (HeadingApp && HeadingPageTitle)
                {
                    lbl_Title.Text = Session["AppName"].ToString() + " - " + PageTitle.ToString();
                }
                else if (HeadingApp)
                {
                    lbl_Title.Text = Session["AppName"].ToString();
                }
                else if (HeadingPageTitle)
                {
                    lbl_Title.Text = PageTitle.ToString();
                }

                lbl_Title.Text += AccessSource;
            }

            divMenuBar.Visible = ShowNavigation;
            if (ShowNavigation && !Page.IsPostBack)
            {
                PopulateMenu();
            }
        }
    }

    private void PopulateMenu()
    {
        DataTable menuData = GetMenuData();
        AddTopMenuItems(menuData);
    }

    private DataTable GetMenuData()
    {
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Admin"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.CommandText = "wsp_SiteMapNodes_Get";
        sqlCmd.Connection = sqlConn;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pAppId = new SqlParameter("@AppId", SqlDbType.Int);
        SqlParameter pUserId = new SqlParameter("@UserId", SqlDbType.Int);
        SqlParameter pUserTypeId = new SqlParameter("@UserTypeId", SqlDbType.Int);

        pAppId.Value = int.Parse(WebConfigurationManager.AppSettings["AppId"].ToString());
        pUserId.Value = int.Parse(Session["UserId"].ToString());
        pUserTypeId.Value = int.Parse(Session["UserTypeId"].ToString());

        sqlCmd.Parameters.Add(pAppId);
        sqlCmd.Parameters.Add(pUserId);
        sqlCmd.Parameters.Add(pUserTypeId);

        sqlConn.Open();

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        da.Dispose();
        sqlConn.Close();
        sqlConn.Dispose();
        return dt;
    }

    private void AddTopMenuItems(DataTable menuData)
    {
        DataView view = new DataView(menuData);
        view.RowFilter = "ParentId IS NULL";
        foreach (DataRowView row in view)
        {
            MenuItem newMenuItem = new MenuItem(row["Title"].ToString(), row["Id"].ToString(), null, row["URL"].ToString());

            if (row["URL"] == DBNull.Value)
            {
                newMenuItem.NavigateUrl = "javascript: void(0);";
            }

            WebMenu.Items.Add(newMenuItem);
            AddChildMenuItems(menuData, newMenuItem);
        }
    }

    private void AddChildMenuItems(DataTable menuData, MenuItem parentMenuItem)
    {
        DataView view = new DataView(menuData);
        view.RowFilter = "ParentId=" + parentMenuItem.Value;
        foreach (DataRowView row in view)
        {
            MenuItem newMenuItem = new MenuItem(row["Title"].ToString(), row["Id"].ToString(), null, row["URL"].ToString());

            if (row["URL"] == DBNull.Value)
            {
                newMenuItem.NavigateUrl = "javascript: void(0);";
            }

            parentMenuItem.ChildItems.Add(newMenuItem);
            AddChildMenuItems(menuData, newMenuItem);
        }
    }

    protected void lbl_UserName_Load(object sender, EventArgs e)
    {
        lbl_UserName.Text = "<b>" + Session["FullName"].ToString() + "</b><br />" + Session["UserType"].ToString();
    }
}