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
using System.Web.Configuration;
using System.Web.UI.HtmlControls;

public partial class _Applications : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            HookOnFocus(this.Page as Control);
        }
        SetConnectionStrings();
    }

    private void HookOnFocus(Control CurrentControl)
    {
        if ((CurrentControl is TextBox))
        {
            (CurrentControl as WebControl).Attributes.Add("onfocus", "this.select()");
        }

        if (CurrentControl.HasControls())
        {
            foreach (Control CurrentChildControl in CurrentControl.Controls)
            {
                HookOnFocus(CurrentChildControl);
            }
        }
    }

    protected void cv_AppName_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string AppName = args.Value.ToString();
        bool IsOK = false;
        int RecordCount = 1;
        int AppId = 0;

        CustomValidator cv = source as CustomValidator;

        if (AppName.Length > 0)
        {
            if (cv.NamingContainer is GridViewRow)
            {
                GridViewRow gvr = (GridViewRow)cv.NamingContainer;
                GridView gv = (GridView)gvr.NamingContainer;
                AppId = int.Parse(gv.DataKeys[gvr.RowIndex].Value.ToString());
            }

            string connStr = ConfigurationManager.ConnectionStrings["Admin" + dd_Source.SelectedValue].ConnectionString;
            SqlConnection sqlConn = new SqlConnection(connStr);
            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_ApplicationAppName_Validate";
            sqlCmd.CommandTimeout = 300;

            SqlParameter pAppId = new SqlParameter("@AppId", SqlDbType.Int);
            SqlParameter pAppName = new SqlParameter("@AppName", SqlDbType.NVarChar, 255);

            pAppId.Value = AppId;
            pAppName.Value = AppName;

            sqlCmd.Parameters.Add(pAppId);
            sqlCmd.Parameters.Add(pAppName);

            sqlCmd.Connection = sqlConn;
            sqlConn.Open();

            SqlDataReader rd = sqlCmd.ExecuteReader();
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    if (rd["RecordCount"] != DBNull.Value)
                    {
                        RecordCount = int.Parse(rd["RecordCount"].ToString());
                    }
                }
            }

            if (RecordCount == 0)
            {
                IsOK = true;
            }

            rd.Close();
            rd.Dispose();
            sqlConn.Close();
            sqlConn.Dispose();
        }

        args.IsValid = IsOK;
    }

    protected void gv_Applications_RowEditing(object sender, GridViewEditEventArgs e)
    {
        fv_Applications.ChangeMode(FormViewMode.ReadOnly);
        gv_Applications.SelectedIndex = -1;
        TogglePanel();
    }

    protected void gv_Applications_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gv_Applications.SelectedIndex != -1)
        {
            fv_Applications.ChangeMode(FormViewMode.ReadOnly);
            gv_Applications.EditIndex = -1;

            CheckBox cb = (CheckBox)gv_Applications.SelectedRow.FindControl("cb_UsesFarms");
            hf_UsesFarms.Value = cb.Checked.ToString();

            //foreach (TabPanel tp in tc_Application.Tabs)
            //{
            //    if (tp.HeaderText == "Farm Access Types")
            //    {
            //        tp.Enabled = cb.Checked;
            //    }
            //}

            pnl_AccessTypes.Enabled = cb.Checked;

            string Source = "AccessURL" + dd_Source.SelectedValue;
            string AccessURL = WebConfigurationManager.AppSettings[Source].ToString();
            Uri uri = Request.Url;
            string baseURL = AccessURL + "?AppId=" + gv_Applications.SelectedValue + "&AccessUserId=" + Session["UserId"].ToString();
            myIframe.Attributes.Add("src", baseURL);

            TogglePanel();
        }
    }

    protected void TogglePanel()
    {
        pnl_Single.Visible = gv_Applications.SelectedIndex > -1;
    }

    protected void fv_Applications_ModeChanged(object sender, EventArgs e)
    {
        if (fv_Applications.CurrentMode == FormViewMode.Insert)
        {
            gv_Applications.EditIndex = -1;
            gv_Applications.SelectedIndex = -1;
        }

        TogglePanel();
    }

    protected void gv_ApplicationPages_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gv_ApplicationPages.SelectedIndex != -1)
        {
            pnl_Users.Visible = true;

            fv_ApplicationPages.ChangeMode(FormViewMode.ReadOnly);
            fv_ApplicationPageUsers.ChangeMode(FormViewMode.ReadOnly);

            gv_ApplicationPages.EditIndex = -1;
            gv_ApplicationPageUsers.EditIndex = -1;
        }
    }

    protected void gv_ApplicationPages_RowEditing(object sender, GridViewEditEventArgs e)
    {
        pnl_Users.Visible = false;

        fv_ApplicationPages.ChangeMode(FormViewMode.ReadOnly);
        fv_ApplicationPageUsers.ChangeMode(FormViewMode.ReadOnly);

        gv_ApplicationPages.SelectedIndex = -1;
        gv_ApplicationPageUsers.EditIndex = -1;
    }

    protected void fv_ApplicationPages_ModeChanged(object sender, EventArgs e)
    {
        if (fv_ApplicationPages.CurrentMode == FormViewMode.Insert)
        {
            pnl_Users.Visible = false;

            fv_ApplicationPageUsers.ChangeMode(FormViewMode.ReadOnly);

            gv_ApplicationPages.SelectedIndex = -1;
            gv_ApplicationPages.EditIndex = -1;
            gv_ApplicationPageUsers.EditIndex = -1;
        }
    }

    protected void gv_ApplicationPageUsers_RowEditing(object sender, GridViewEditEventArgs e)
    {
        fv_ApplicationPages.ChangeMode(FormViewMode.ReadOnly);
        fv_ApplicationPageUsers.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void fv_ApplicationPageUsers_ModeChanged(object sender, EventArgs e)
    {
        if (fv_ApplicationPageUsers.CurrentMode == FormViewMode.Insert)
        {
            fv_ApplicationPages.ChangeMode(FormViewMode.ReadOnly);
            gv_ApplicationPages.EditIndex = -1;
            gv_ApplicationPageUsers.EditIndex = -1;
        }
    }

    protected void gv_AppUserTypes_RowEditing(object sender, GridViewEditEventArgs e)
    {
        fv_AppUserTypes.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void gv_AppUserTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gv_AppUserTypes.SelectedIndex != -1)
        {
            gv_AppUserTypes.EditIndex = -1;
            fv_AppUserTypes.ChangeMode(FormViewMode.ReadOnly);
        }
    }

    protected void fv_AppUserTypes_ModeChanged(object sender, EventArgs e)
    {
        if (fv_AppUserTypes.CurrentMode == FormViewMode.Insert)
        {
            gv_AppUserTypes.EditIndex = -1;
            gv_AppUserTypes.SelectedIndex = -1;
        }
    }

    protected void cb_IsFarmUser_Load(object sender, EventArgs e)
    {
        CheckBox cb = sender as CheckBox;
        cb.Enabled = bool.Parse(hf_UsesFarms.Value);
    }

    protected void gv_AccessTypes_RowEditing(object sender, GridViewEditEventArgs e)
    {
        fv_AccessTypes.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void gv_AccessTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gv_AccessTypes.SelectedIndex != -1)
        {
            gv_AccessTypes.EditIndex = -1;
            fv_AccessTypes.ChangeMode(FormViewMode.ReadOnly);
        }
    }

    protected void fv_AccessTypes_ModeChanged(object sender, EventArgs e)
    {
        if (fv_AccessTypes.CurrentMode == FormViewMode.Insert)
        {
            gv_AccessTypes.EditIndex = -1;
            gv_AccessTypes.SelectedIndex = -1;
        }
    }

    protected void dd_Source_SelectedIndexChanged(object sender, EventArgs e)
    {
        gv_Applications.SelectedIndex = -1;
        gv_Applications.EditIndex = -1;
        gv_Applications.DataBind();
        fv_AccessTypes.ChangeMode(FormViewMode.ReadOnly);
        TogglePanel();
    }

    protected void gv_AppUserTypes_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (!bool.Parse(hf_UsesFarms.Value))
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[4].CssClass = "Hidden";
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[4].CssClass = "Hidden";
            }
        }

        if (gv_Applications.SelectedIndex != -1 && int.Parse(gv_Applications.SelectedValue.ToString()) != 1)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[1].CssClass = "Hidden";
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[1].CssClass = "Hidden";
            }
        }
    }

    protected void fv_AppUserTypes_DataBound(object sender, EventArgs e)
    {
        if (fv_AppUserTypes.CurrentMode == FormViewMode.Insert)
        {
            if (int.Parse(gv_Applications.SelectedValue.ToString()) != 1)
            {
                HtmlTableRow tr_IsFinAdminUser = (HtmlTableRow)fv_AppUserTypes.FindControl("tr_IsFinAdminUser");
                if (tr_IsFinAdminUser != null)
                {
                    tr_IsFinAdminUser.Attributes.Add("class", "Hidden");
                }
            }

            if (!bool.Parse(hf_UsesFarms.Value))
            {
                HtmlTableRow tr_IsFarmUser = (HtmlTableRow)fv_AppUserTypes.FindControl("tr_IsFarmUser");
                if (tr_IsFarmUser != null)
                {
                    tr_IsFarmUser.Attributes.Add("class", "Hidden");
                }
            }
        }
    }

    protected void SetConnectionStrings()
    {
        if (dd_Source != null)
        {
            string Source = "Admin" + dd_Source.SelectedValue;
            ds_Applications.ConnectionString = ConfigurationManager.ConnectionStrings[Source].ConnectionString;
            ds_AppUserTypes.ConnectionString = ConfigurationManager.ConnectionStrings[Source].ConnectionString;
            ds_AccessTypes.ConnectionString = ConfigurationManager.ConnectionStrings[Source].ConnectionString;
            ds_AccessTypesAll.ConnectionString = ConfigurationManager.ConnectionStrings[Source].ConnectionString;
            ds_ApplicationPages.ConnectionString = ConfigurationManager.ConnectionStrings[Source].ConnectionString;
            ds_ApplicationPagesDD.ConnectionString = ConfigurationManager.ConnectionStrings[Source].ConnectionString;
            ds_ApplicationPageUsers.ConnectionString = ConfigurationManager.ConnectionStrings[Source].ConnectionString;
            ds_ApplicationUserTypes.ConnectionString = ConfigurationManager.ConnectionStrings[Source].ConnectionString;
        }
    }
}