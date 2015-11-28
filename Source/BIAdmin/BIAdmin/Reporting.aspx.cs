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
using System.Web.Services;

public partial class _Reporting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetUserTypes(lbx_UserTypes, 0);
            GetLinks(true, gv_Links, 0);
            GetLinks(true, fv_Links, 0);
        }
        else
        {
            if (lbl_Response != null)
            {
                lbl_Response.Text = "";
            }
        }
    }

    protected void dd_Source_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetUserTypes(lbx_UserTypes, 0);
        GetLinks(true, gv_Links, 0);
        GetLinks(true, fv_Links, 0);
    }

    protected void GetUserTypes(ListBox lb, int URLId)
    {
        DataTable dt = new DataTable();
        string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_AdminReportingUserTypes_Get";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pURLId = new SqlParameter("URLId", SqlDbType.Int);
        pURLId.Value = URLId;
        sqlCmd.Parameters.Add(pURLId);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(dt);
        sqlCon.Close();
        sqlCon.Dispose();

        LoadLBXValues(lb, dt, "UserTypeId", "UserType");
    }

    protected void LoadDDValues(DropDownList dd, DataTable dt, string ValueField, string LabelField)
    {
        dd.Items.Clear();

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                string ddValue = null;
                if (dr[ValueField] != null)
                {
                    ddValue = dr[ValueField].ToString();
                }

                string ddLabel = null;
                if (dr[LabelField] != null)
                {
                    ddLabel = dr[LabelField].ToString();
                }

                ListItem li = new ListItem(ddLabel, ddValue);
                dd.Items.Add(li);
            }
        }
    }

    protected void LoadLBXValues(ListBox lb, DataTable dt, string ValueField, string LabelField)
    {
        lb.Items.Clear();

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                string ddValue = null;
                if (dr[ValueField] != null)
                {
                    ddValue = dr[ValueField].ToString();
                }

                string ddLabel = null;
                if (dr[LabelField] != null)
                {
                    ddLabel = dr[LabelField].ToString();
                }

                bool isSelected = false;
                if (dr["IsSelected"] != null)
                {
                    isSelected = bool.Parse(dr["IsSelected"].ToString());
                }

                ListItem li = new ListItem(ddLabel, ddValue);
                li.Selected = isSelected;
                lb.Items.Add(li);
            }
        }
    }

    protected void GetLinks(bool ResetIndex, Control c, int URLId)
    {
        if (c is GridView && ResetIndex)
        {
            gv_Links.EditIndex = -1;
            gv_Links.SelectedIndex = -1;
        }

        string UserTypes = "";

        foreach (ListItem li in lbx_UserTypes.Items)
        {
            if (li.Selected)
            {
                UserTypes = UserTypes + "," + li.Value;
            }
        }

        if (UserTypes.Length > 0)
        {
            UserTypes = UserTypes.Substring(1);
        }

        DataTable dt = new DataTable();
        string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_AdminReportingLinks_Get";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pURLId = new SqlParameter("URLId", SqlDbType.Int);
        SqlParameter pUserTypes = new SqlParameter("UserTypes", SqlDbType.VarChar, 50);

        pURLId.Value = URLId;
        pUserTypes.Value = UserTypes;

        sqlCmd.Parameters.Add(pURLId);
        sqlCmd.Parameters.Add(pUserTypes);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(dt);
        sqlCon.Close();
        sqlCon.Dispose();

        if (c is GridView)
        {
            gv_Links.DataSource = dt;
            gv_Links.DataBind();
        }
        else
        {
            fv_Links.DataSource = dt;
            fv_Links.DataBind();
        }
    }

    protected void dd_UserTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetLinks(true, gv_Links, 0);
    }

    protected void gv_Links_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hf_enabled = (HiddenField)e.Row.FindControl("hf_enabled");
            if (hf_enabled != null)
            {
                if (!bool.Parse(hf_enabled.Value))
                {
                    e.Row.ForeColor = System.Drawing.Color.Gray;
                }
            }

            if (e.Row.RowIndex == gv_Links.EditIndex)
            {
                DropDownList dd_Path = (DropDownList)e.Row.FindControl("dd_Path");
                if (dd_Path != null)
                {
                    HiddenField hf_ReportGUID = (HiddenField)e.Row.FindControl("hf_ReportGUID");
                    int URLId = int.Parse(gv_Links.DataKeys[e.Row.RowIndex].Value.ToString());
                    LoadReportsDD(dd_Path, URLId, hf_ReportGUID.Value);
                }

                CheckBox cb_IsReport = (CheckBox)e.Row.FindControl("cb_IsReport");
                TextBox txb_ReportAdditionalURL = (TextBox)e.Row.FindControl("txb_ReportAdditionalURL");
                TextBox txb_AltURL = (TextBox)e.Row.FindControl("txb_AltURL");
                RequiredFieldValidator rf_txb_AltURL = (RequiredFieldValidator)e.Row.FindControl("rf_txb_AltURL");
                RequiredFieldValidator rf_dd_Path = (RequiredFieldValidator)e.Row.FindControl("rf_dd_Path");

                dd_Path.Enabled = cb_IsReport.Checked;
                rf_dd_Path.Enabled = cb_IsReport.Checked;
                txb_ReportAdditionalURL.Enabled = cb_IsReport.Checked;
                txb_AltURL.Enabled = !cb_IsReport.Checked;
                rf_txb_AltURL.Enabled = !cb_IsReport.Checked;
            }
        }
    }

    protected void LoadReportsDD(DropDownList dd_Path, int URLId, string ReportGUID)
    {
        DataTable dt = new DataTable();
        string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_AdminReportingReports_Get";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pURLId = new SqlParameter("URLId", SqlDbType.Int);

        pURLId.Value = URLId;

        sqlCmd.Parameters.Add(pURLId);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(dt);
        sqlCon.Close();
        sqlCon.Dispose();

        LoadDDValues(dd_Path, dt, "ItemID", "Path");

        if (dd_Path.Items.FindByValue(ReportGUID) != null)
        {
            dd_Path.Items.FindByValue(ReportGUID).Selected = true;
        }
    }

    protected void lb_DeleteRow_Click(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        GridViewRow gvr = (GridViewRow)lb.NamingContainer;

        string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_AdminReportingLinks_Delete";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pURLId = new SqlParameter("URLId", SqlDbType.Int);
        pURLId.Value = int.Parse(gv_Links.DataKeys[gvr.RowIndex].Value.ToString());
        sqlCmd.Parameters.Add(pURLId);

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetLinks(true, gv_Links, 0);
    }

    protected bool ValidateNames(int URLId, string URLHeading, string URLName)
    {
        string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_AdminReportingLinks_Validate";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pURLId = new SqlParameter("URLId", SqlDbType.Int);
        SqlParameter pURLHeading = new SqlParameter("URLHeading", SqlDbType.NVarChar, 50);
        SqlParameter pURLName = new SqlParameter("URLName", SqlDbType.NVarChar, 50);
        SqlParameter pRecordCount = new SqlParameter("RecordCount", SqlDbType.Int);

        pURLId.Value = URLId;
        pURLHeading.Value = URLHeading;
        pURLName.Value = URLName;

        pRecordCount.Direction = ParameterDirection.Output;

        sqlCmd.Parameters.Add(pURLId);
        sqlCmd.Parameters.Add(pURLHeading);
        sqlCmd.Parameters.Add(pURLName);
        sqlCmd.Parameters.Add(pRecordCount);

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        if (int.Parse(pRecordCount.Value.ToString()) == 0)
        {
            return true;
        }
        else
        {
            lbl_Response.Text = "Heading and Name combination creates a duplicate!";
            return false;
        }
    }

    protected void fv_Links_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("New"))
        {
            fv_Links.ChangeMode(FormViewMode.Insert);
            GetLinks(false, fv_Links, 0);
        }

        if (e.CommandName.Equals("Cancel"))
        {
            fv_Links.ChangeMode(FormViewMode.ReadOnly);
            GetLinks(true, gv_Links, 0);
            GetLinks(false, fv_Links, 0);
        }

        if (e.CommandName.Equals("Insert") || e.CommandName.Equals("Update"))
        {
            TextBox txb_URLHeading = (TextBox)fv_Links.FindControl("txb_URLHeading");
            TextBox txb_URLName = (TextBox)fv_Links.FindControl("txb_URLName");
            CheckBox cb_IsReport = (CheckBox)fv_Links.FindControl("cb_IsReport");
            DropDownList dd_Path = (DropDownList)fv_Links.FindControl("dd_Path");
            RequiredFieldValidator rf_dd_Path = (RequiredFieldValidator)fv_Links.FindControl("rf_dd_Path");
            TextBox txb_ReportAdditionalURL = (TextBox)fv_Links.FindControl("txb_ReportAdditionalURL");
            TextBox txb_AltURL = (TextBox)fv_Links.FindControl("txb_AltURL");
            RequiredFieldValidator rf_txb_AltURL = (RequiredFieldValidator)fv_Links.FindControl("rf_txb_AltURL");
            TextBox txb_URLDescription = (TextBox)fv_Links.FindControl("txb_URLDescription");
            TextBox txb_Tags = (TextBox)fv_Links.FindControl("txb_Tags");
            CheckBox cb_Active = (CheckBox)fv_Links.FindControl("cb_Active");
            ListBox nlbx_UserTypes = (ListBox)fv_Links.FindControl("lbx_UserTypes");

            int URLId = 0;
            if(gv_Links.SelectedIndex != -1)
            {
                URLId = int.Parse(gv_Links.DataKeys[gv_Links.SelectedIndex].Value.ToString());
            }

            if (ValidateNames(URLId, txb_URLHeading.Text, txb_URLName.Text))
            {
                string UserTypes = "";

                foreach (ListItem li in nlbx_UserTypes.Items)
                {
                    if (li.Selected)
                    {
                        UserTypes = UserTypes + "," + li.Value;
                    }
                }

                if (UserTypes.Length > 0)
                {
                    UserTypes = UserTypes.Substring(1);
                }

                string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
                SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
                SqlCommand sqlCmd = new SqlCommand();
                sqlCmd.CommandText = "wsp_AdminReportingLinks_Add";
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Connection = sqlCon;
                sqlCmd.CommandTimeout = 300;

                SqlParameter pURLHeading = new SqlParameter("URLHeading", SqlDbType.NVarChar, 50);
                SqlParameter pURLName = new SqlParameter("URLName", SqlDbType.NVarChar, 50);
                SqlParameter pIsReport = new SqlParameter("IsReport", SqlDbType.Bit);
                SqlParameter pReportGUID = new SqlParameter("ReportGUID", SqlDbType.NVarChar, 255);
                SqlParameter pReportAdditionalURL = new SqlParameter("ReportAdditionalURL", SqlDbType.NVarChar, 1900);
                SqlParameter pAltURL = new SqlParameter("AltURL", SqlDbType.NVarChar, 2000);
                SqlParameter pURLDescription = new SqlParameter("URLDescription", SqlDbType.NVarChar, 255);
                SqlParameter pTags = new SqlParameter("Tags", SqlDbType.NVarChar);
                SqlParameter pActive = new SqlParameter("Active", SqlDbType.Bit);
                SqlParameter pUserTypes = new SqlParameter("UserTypes", SqlDbType.NVarChar, 255);

                pURLHeading.Value = txb_URLHeading.Text;
                pURLName.Value = txb_URLName.Text;
                pIsReport.Value = cb_IsReport.Checked;

                if (cb_IsReport.Checked)
                {
                    pReportGUID.Value = dd_Path.SelectedValue;
                    pReportAdditionalURL.Value = txb_ReportAdditionalURL.Text;
                    pAltURL.Value = DBNull.Value;
                }
                else
                {
                    pReportGUID.Value = DBNull.Value;
                    pReportAdditionalURL.Value = DBNull.Value;
                    pAltURL.Value = txb_AltURL.Text;
                }

                pURLDescription.Value = txb_URLDescription.Text;
                pTags.Value = txb_Tags.Text;
                pActive.Value = cb_Active.Checked;
                pUserTypes.Value = UserTypes;

                sqlCmd.Parameters.Add(pURLHeading);
                sqlCmd.Parameters.Add(pURLName);
                sqlCmd.Parameters.Add(pIsReport);
                sqlCmd.Parameters.Add(pReportGUID);
                sqlCmd.Parameters.Add(pReportAdditionalURL);
                sqlCmd.Parameters.Add(pAltURL);
                sqlCmd.Parameters.Add(pURLDescription);
                sqlCmd.Parameters.Add(pTags);
                sqlCmd.Parameters.Add(pActive);
                sqlCmd.Parameters.Add(pUserTypes);


                if (e.CommandName.Equals("Update"))
                {
                    sqlCmd.CommandText = "wsp_AdminReportingLinks_Update";
                    SqlParameter pURLId = new SqlParameter("URLId", SqlDbType.Int);
                    pURLId.Value = gv_Links.DataKeys[gv_Links.SelectedIndex].Value.ToString();
                    sqlCmd.Parameters.Add(pURLId);
                }

                sqlCon.Open();
                sqlCmd.ExecuteNonQuery();
                sqlCon.Close();
                sqlCon.Dispose();

                rf_dd_Path.Enabled = false;
                rf_txb_AltURL.Enabled = false;
            }
            else
            {
                lbl_Response.Text = "Heading and Name combination creates a duplicate!";
            }
        }
    }

    protected void fv_Links_ModeChanged(object sender, EventArgs e)
    {
    }

    protected void fv_Links_ModeChanging(object sender, FormViewModeEventArgs e)
    {
    }

    protected void fv_Links_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        fv_Links.ChangeMode(FormViewMode.ReadOnly);
        GetLinks(false, fv_Links, 0);
        GetLinks(true, gv_Links, 0);
    }

    protected void fv_Links_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
    }

    protected void fv_Links_DataBound(object sender, EventArgs e)
    {
        if (fv_Links.CurrentMode == FormViewMode.Insert || fv_Links.CurrentMode == FormViewMode.Edit)
        {
            int URLId = -1;
            string ReportGUID = "";

            HiddenField hf_URLId = (HiddenField)fv_Links.FindControl("hf_URLId");
            HiddenField hf_ReportGUID = (HiddenField)fv_Links.FindControl("hf_ReportGUID");

            if (hf_URLId != null)
            {
                URLId = int.Parse(hf_URLId.Value);
            }

            if (hf_ReportGUID != null)
            {
                ReportGUID = hf_ReportGUID.Value;
            }

            DropDownList dd_Path = (DropDownList)fv_Links.FindControl("dd_Path");
            if (dd_Path != null)
            {

                LoadReportsDD(dd_Path, URLId, ReportGUID);
            }

            ListBox lbx_UserTypes = (ListBox)fv_Links.FindControl("lbx_UserTypes");
            if (lbx_UserTypes != null)
            {
                GetUserTypes(lbx_UserTypes, URLId);
            }

            CheckBox cb_IsReport = (CheckBox)fv_Links.FindControl("cb_IsReport");
            TextBox txb_ReportAdditionalURL = (TextBox)fv_Links.FindControl("txb_ReportAdditionalURL");
            TextBox txb_AltURL = (TextBox)fv_Links.FindControl("txb_AltURL");
            RequiredFieldValidator rf_txb_AltURL = (RequiredFieldValidator)fv_Links.FindControl("rf_txb_AltURL");
            RequiredFieldValidator rf_dd_Path = (RequiredFieldValidator)fv_Links.FindControl("rf_dd_Path");

            dd_Path.Enabled = cb_IsReport.Checked;
            rf_dd_Path.Enabled = cb_IsReport.Checked;
            txb_ReportAdditionalURL.Enabled = cb_IsReport.Checked;
            txb_AltURL.Enabled = !cb_IsReport.Checked;
            rf_txb_AltURL.Enabled = !cb_IsReport.Checked;
        }
    }

    [WebMethod]
    public static bool ValidateNames(string Source, int URLId, string URLHeading, string URLName)
    {
        string myConnectionString = "Admin" + Source;
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_AdminReportingLinks_Validate";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pURLId = new SqlParameter("URLId", SqlDbType.Int);
        SqlParameter pURLHeading = new SqlParameter("URLHeading", SqlDbType.NVarChar, 50);
        SqlParameter pURLName = new SqlParameter("URLName", SqlDbType.NVarChar, 50);
        SqlParameter pRecordCount = new SqlParameter("RecordCount", SqlDbType.Int);

        pURLId.Value = URLId;
        pURLHeading.Value = URLHeading;
        pURLName.Value = URLName;

        pRecordCount.Direction = ParameterDirection.Output;

        sqlCmd.Parameters.Add(pURLId);
        sqlCmd.Parameters.Add(pURLHeading);
        sqlCmd.Parameters.Add(pURLName);
        sqlCmd.Parameters.Add(pRecordCount);

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        return int.Parse(pRecordCount.Value.ToString()) == 0;
    }

    protected void lbx_UserTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetLinks(true, gv_Links, 0);
    }

    protected void lb_Select_Click(object sender, EventArgs e)
    {
        LinkButton lb_Select = sender as LinkButton;
        GridViewRow gvr = (GridViewRow)lb_Select.NamingContainer;
        GridView gv = (GridView)gvr.NamingContainer;

        gv.SelectedIndex = gvr.RowIndex;
        GetLinks(false, gv_Links, 0);

        //GetFVLinks(int.Parse(gv.DataKeys[gvr.RowIndex].Value.ToString()));
        fv_Links.ChangeMode(FormViewMode.Edit);
        GetLinks(false, fv_Links, int.Parse(gv.DataKeys[gvr.RowIndex].Value.ToString()));
    }
    protected void fv_Links_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        fv_Links.ChangeMode(FormViewMode.ReadOnly);
        GetLinks(false, fv_Links, 0);
        GetLinks(true, gv_Links, 0);
    }
    protected void fv_Links_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {

    }
}