using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BiRequestWeb
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            SetSessionVariables();
            CheckPageAuthorisation();
        }

        protected void SetSessionVariables()
        {
            int appId = int.Parse(WebConfigurationManager.AppSettings["AppId"]);

            string userName = GetUserName(appId);

            Session["AppId"] = appId;
            Session["UserName"] = userName;

            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Admin"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_AppUserDetails_Get";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pAppId = new SqlParameter("@AppId", SqlDbType.Int);
            SqlParameter pUserName = new SqlParameter("@UserName", SqlDbType.NVarChar, 50);

            pAppId.Value = appId;
            pUserName.Value = userName;

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
                        string fieldName = rd.GetName(c);
                        string fieldValue = rd[fieldName].ToString();
                        Session[fieldName] = fieldValue;
                    }
                }
            }

            rd.Close();
            rd.Dispose();
            sqlConn.Close();
            sqlConn.Dispose();

            if (Session["AppOnline"] != null && bool.Parse(Session["AppOnline"].ToString()) == false)
            {
                Response.Redirect("Offline.htm");
            }
        }

        protected string GetUserName(int appId)
        {
            //string userName = Regex.Replace(HttpContext.Current.User.Identity.Name, ".*\\\\(.*)", "$1", RegexOptions.None).ToUpper();
            var userName = "BAILEYD";//"FORDM";

            string queryUserName = userName;

            if (Request["UserName"] != null)
            {
                queryUserName = Request["UserName"].ToUpper();
            }

            if (userName != queryUserName)
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

                pAppId.Value = appId;
                pUserName.Value = userName;
                pQueryUserName.Value = queryUserName;

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
                            userName = rd["Username"].ToString();
                        }
                    }
                }

                rd.Close();
                rd.Dispose();
                sqlConn.Close();
                sqlConn.Dispose();
            }

            return userName;
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
            SqlParameter pPageUrl = new SqlParameter("@PageURL", SqlDbType.NVarChar, 255);
            SqlParameter pIsOk = new SqlParameter("@IsOK", SqlDbType.Bit);

            pAppId.Value = int.Parse(WebConfigurationManager.AppSettings["AppId"]);
            pUserId.Value = int.Parse(Session["UserId"].ToString());
            pUserTypeId.Value = int.Parse(Session["UserTypeId"].ToString());
            pPageUrl.Value = Path.GetFileName(Request.Url.AbsolutePath);
            pIsOk.Direction = ParameterDirection.Output;

            sqlCmd.Parameters.Add(pAppId);
            sqlCmd.Parameters.Add(pUserId);
            sqlCmd.Parameters.Add(pUserTypeId);
            sqlCmd.Parameters.Add(pPageUrl);
            sqlCmd.Parameters.Add(pIsOk);

            bool showRibbon = true;
            string pageTitle = "";
            bool showNavigation = true;
            bool headingApp = true;
            bool headingPageTitle = true;

            sqlConn.Open();

            SqlDataReader rd = sqlCmd.ExecuteReader();
            if (rd.HasRows)
            {
                while (rd.Read())
                {

                    if (rd["ShowRibbon"] != DBNull.Value)
                    {
                        showRibbon = bool.Parse(rd["ShowRibbon"].ToString());
                    }

                    if (rd["PageTitle"] != DBNull.Value)
                    {
                        pageTitle = rd["PageTitle"].ToString();
                    }

                    if (rd["ShowNavigation"] != DBNull.Value)
                    {
                        showNavigation = bool.Parse(rd["ShowNavigation"].ToString());
                    }

                    if (rd["HeadingApp"] != DBNull.Value)
                    {
                        headingApp = bool.Parse(rd["HeadingApp"].ToString());
                    }

                    if (rd["HeadingPageTitle"] != DBNull.Value)
                    {
                        headingPageTitle = bool.Parse(rd["HeadingPageTitle"].ToString());
                    }
                }
            }

            sqlConn.Close();
            sqlConn.Dispose();

            if (!bool.Parse(pIsOk.Value.ToString()))
            {
                //Response.Redirect("~/ErrorPages/Unauthorised.aspx?Page=" + Request.Url.PathAndQuery);
            }
            else
            {
                Page.Title = pageTitle;
                divHeader.Visible = showRibbon;

                if (showRibbon && !Page.IsPostBack)
                {
                    string accessSource = "<font color=\"Red\">" + WebConfigurationManager.AppSettings["AccessSource"] + "</font>";
                    lbl_Title.Text = "";

                    if (headingApp && headingPageTitle)
                    {
                        lbl_Title.Text = Session["AppName"] + " - " + pageTitle;
                    }
                    else if (headingApp)
                    {
                        lbl_Title.Text = Session["AppName"].ToString();
                    }
                    else if (headingPageTitle)
                    {
                        lbl_Title.Text = pageTitle;
                    }

                    lbl_Title.Text += accessSource;
                }

                divMenuBar.Visible = showNavigation;
                if (showNavigation && !Page.IsPostBack)
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
            SqlCommand sqlCmd = new SqlCommand
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "wsp_SiteMapNodes_Get",
                Connection = sqlConn,
                CommandTimeout = 300
            };

            SqlParameter pAppId = new SqlParameter("@AppId", SqlDbType.Int);
            SqlParameter pUserId = new SqlParameter("@UserId", SqlDbType.Int);
            SqlParameter pUserTypeId = new SqlParameter("@UserTypeId", SqlDbType.Int);

            pAppId.Value = WebConfigurationManager.AppSettings["AppId"];
            pUserId.Value = Session["UserId"].ToString();
            pUserTypeId.Value = Session["UserTypeId"].ToString();

            sqlCmd.Parameters.Add(pAppId);
            sqlCmd.Parameters.Add(pUserId);
            sqlCmd.Parameters.Add(pUserTypeId);

            sqlConn.Open();

            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
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
            lbl_UserName.Text = "<b>" + Session["FullName"] + "</b>,&nbsp;" + Session["UserType"];
        }
    }
}