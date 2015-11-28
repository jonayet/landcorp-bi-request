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

public partial class _LU_Farms : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request["farm_id"] != null)
            {
                hf_farm_id.Value = Request["farm_id"].ToString();
            }
            GetFarms(true);
        }
        else
        {
            if (hdf_PopUpVisible.Value == "true")
            {
                ShowPopUp(hdf_PopUp.Value);
            }
            if (lbl_Response != null)
            {
                lbl_Response.Text = "";
            }
        }
    }

    protected void BindFarmGridview(DataTable dt, DataView dv)
    {
        if (dt != null)
        {
            gv_Farms.DataSource = dt;
        }
        else
        {
            gv_Farms.DataSource = dv;
        }
        gv_Farms.DataBind();
    }

    protected void GetFarms(bool FullBind)
    {
        GetFlags();
        if (FullBind)
        {
            ContentPlaceHolder MainContent = (ContentPlaceHolder)this.Master.FindControl("MainContent");
            foreach (Control c in MainContent.Controls)
            {
                if (c is HiddenField)
                {
                    HiddenField hf = (HiddenField)c;
                    if (!Page.IsPostBack && Request["farm_id"] != null && hf.ID == "hf_farm_id")
                    {
                        hf.Value = Request["farm_id"].ToString();
                    }
                    else if (hf.ID.Contains("hf_"))
                    {
                        hf.Value = "All";
                    }
                }
            }
        }

        gv_Farms.EditIndex = -1;

        string myConnectionString = "OSOTT" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT * FROM LU_Farms ORDER BY LC_Farm, ActiveFrom";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "FarmData");
        sqlCon.Close();
        sqlCon.Dispose();

        DataTable dt = ds.Tables["FarmData"];
        Session["FarmData"] = dt;

        BindFarmGridview(dt, null);
        FilterData(false, 0);
    }

    protected void GetFlags()
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT * FROM LU_FarmsFlags";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "Flags");
        sqlCon.Close();
        sqlCon.Dispose();

        DataTable dt = ds.Tables["Flags"];
        Session["Flags"] = dt;
    }

    protected void getDropDownListValues(DropDownList dd, string ColumnName, string PreviousValue)
    {
        dd.Items.Clear();

        ListItem li = new ListItem();
        li.Value = "All";
        li.Text = "All";
        dd.Items.Add(li);

        DataTable dt = (DataTable)Session["FarmData"];
        DataView dv = dt.DefaultView;
        dv.Sort = ColumnName;
        DataTable distinctTable = dv.ToTable(true, ColumnName);

        foreach (DataRow dr in distinctTable.Rows)
        {
            ListItem dli = new ListItem();
            string DataType = dr[ColumnName].GetType().Name;
            if (DataType == "DateTime")
            {
                dli.Value = DateTime.Parse(dr[ColumnName].ToString()).ToString("dd/MM/yyyy");
                dli.Text = DateTime.Parse(dr[ColumnName].ToString()).ToString("dd/MM/yyyy");
            }
            else if (DataType == "Boolean")
            {
                string YesNo = "No";
                if (bool.Parse(dr[ColumnName].ToString()))
                {
                    YesNo = "Yes";
                }

                dli.Value = dr[ColumnName].ToString();
                dli.Text = YesNo;
            }
            else
            {
                dli.Value = dr[ColumnName].ToString();
                dli.Text = dr[ColumnName].ToString();
            }
            dd.Items.Add(dli);
        }

        if (dd.Items.FindByValue(PreviousValue) != null)
        {
            dd.Items.FindByValue(PreviousValue).Selected = true;
        }
    }

    protected void FilterGridView(object sender, EventArgs e)
    {
        gv_Farms.EditIndex = -1;
        FilterData(false, 0);
    }

    protected void FilterData(bool isEdit, int SK_FarmId)
    {
        GetFlags();
        int Filters = 0;
        string FilterExpression = "";

        GridView gv = gv_Farms;

        if (isEdit)
        {
            FilterExpression = "SK_FarmId = " + SK_FarmId.ToString();
            Filters++;
            gv.EditIndex = 0;
        }
        else
        {
            gv_Farms.EditIndex = -1;

            if (gv.HeaderRow != null)
            {
                foreach (TableCell headerCell in gv.HeaderRow.Cells)
                {
                    foreach (Control c in headerCell.Controls)
                    {
                        if (c is DropDownList)
                        {
                            DropDownList dd = (DropDownList)c;

                            ContentPlaceHolder MainContent = (ContentPlaceHolder)this.Master.FindControl("MainContent");
                            HiddenField hf = (HiddenField)MainContent.FindControl(dd.ID.Replace("dd", "hf"));
                            hf.Value = dd.SelectedValue;

                            if (Filters == 0)
                            {
                                if (dd.SelectedValue.Length == 0)
                                {
                                    FilterExpression = "(NULL = 'All' OR " + dd.ID.Replace("dd_", "") + " IS NULL)";
                                }
                                else
                                {
                                    FilterExpression = "('" + dd.SelectedValue + "' = 'All' OR " + dd.ID.Replace("dd_", "") + " = '" + dd.SelectedValue + "')";
                                }
                            }
                            else
                            {
                                if (dd.SelectedValue.Length == 0)
                                {
                                    FilterExpression = FilterExpression + " AND (NULL = 'All' OR " + dd.ID.Replace("dd_", "") + " IS NULL)";
                                }
                                else
                                {
                                    FilterExpression = FilterExpression + " AND ('" + dd.SelectedValue + "' = 'All' OR " + dd.ID.Replace("dd_", "") + " = '" + dd.SelectedValue + "')";
                                }
                            }
                            Filters++;
                        }
                    }
                }
            }
        }

        DataTable dt = (DataTable)Session["FarmData"];

        DataView dv = new DataView(dt);
        dv.RowFilter = FilterExpression;
        dv.Sort = hdf_SortBy.Value + " " + hdf_SortDirection.Value;
        BindFarmGridview(null, dv);
    }

    protected void gv_DataBound(object sender, EventArgs e)
    {
        GridView gv = sender as GridView;
        if (gv.HeaderRow != null)
        {
            foreach (TableCell headerCell in gv.HeaderRow.Cells)
            {
                foreach (Control c in headerCell.Controls)
                {
                    if (c is DropDownList)
                    {
                        DropDownList dd = (DropDownList)c;
                        ContentPlaceHolder MainContent = (ContentPlaceHolder)this.Master.FindControl("MainContent");
                        HiddenField hf = (HiddenField)MainContent.FindControl(dd.ID.Replace("dd", "hf"));
                        getDropDownListValues(dd, dd.ID.Replace("dd_", ""), hf.Value);
                    }
                }
            }
            HideColumns(gv);
        }
    }

    protected void HideColumns(GridView gv)
    {
        if (Session["Flags"] != null)
        {
            DataTable dt = (DataTable)Session["Flags"];
            foreach (DataRow dr in dt.Rows)
            {
                string FieldName = dr["FieldName"].ToString();
                bool Show = bool.Parse(dr["Show"].ToString());

                if (!Show)
                {
                    for (int i = 0; i < gv.Columns.Count - 1; i++)
                    {
                        if (gv.Columns[i].HeaderText == FieldName)
                        {
                            foreach (GridViewRow gvr in gv.Rows)
                            {
                                gvr.Cells[i].CssClass = "Hidden";
                            }
                            gv.HeaderRow.Cells[i].CssClass = "Hidden";
                        }
                    }
                }
            }
        }
    }

    protected void lb_Sort_Click(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        if (hdf_SortBy.Value == lb.ID.Replace("lb_", ""))
        {
            SwitchSorting();
        }
        else
        {
            hdf_SortBy.Value = lb.ID.Replace("lb_", "");
            hdf_SortDirection.Value = "ASC";
        }
        FilterData(false, 0);
    }

    protected void SwitchSorting()
    {
        if (hdf_SortDirection.Value == "ASC")
        {
            hdf_SortDirection.Value = "DESC";
        }
        else
        {
            hdf_SortDirection.Value = "ASC";
        }
    }

    protected void lb_Edit_Click(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        GridViewRow gvr = (GridViewRow)lb.NamingContainer;
        GridView gv = (GridView)gvr.NamingContainer;

        int SK_FarmId = int.Parse(gv.DataKeys[gvr.RowIndex].Value.ToString());
        FilterData(true, SK_FarmId);
    }

    protected void lb_Cancel_Click(object sender, EventArgs e)
    {
        FilterData(false, 0);
    }

    protected void lb_Update_Click(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        GridViewRow gvr = (GridViewRow)lb.NamingContainer;

        bool NewRecord = false;
        CheckBox cb_Override = (CheckBox)gvr.FindControl("cb_Override");
        if (!cb_Override.Checked)
        {
            NewRecord = CheckNewRecord(gvr);
        }

        if (!NewRecord)
        {
            UpdateData(NewRecord);
        }
        else
        {
            TextBox txb_ActiveFrom = (TextBox)gvr.FindControl("txb_ActiveFrom");
            try
            {
                txb_EffectiveDate_CalendarExtender.StartDate = DateTime.Parse(txb_ActiveFrom.Text).AddDays(1);
            }
            catch
            {
            }

            txb_EffectiveDate.Text = null;
            rf_txb_EffectiveDate.Enabled = true;
            cmp_txb_EffectiveDate.Enabled = true;
            lbl_EffectiveDate.Text = "A new record is required.<br />Please enter the date that new record will START.";
            ShowPopUp(mpe_EffectiveDate.ID);
        }
    }

    protected bool CheckNewRecord(GridViewRow gvr)
    {
        bool NewRecord = false;
        if (Session["Flags"] != null)
        {
            DataTable dt = (DataTable)Session["Flags"];
            foreach (DataRow dr in dt.Rows)
            {
                string FieldName = dr["FieldName"].ToString();
                bool Updatable = bool.Parse(dr["Updatable"].ToString());
                bool TriggersNewRecord = bool.Parse(dr["NewRecord"].ToString());

                if (Updatable && TriggersNewRecord)
                {
                    HiddenField hf = (HiddenField)gvr.FindControl("vhf_" + FieldName);

                    TextBox txb = (TextBox)gvr.FindControl("txb_" + FieldName);
                    if (txb != null)
                    {
                        if (txb.Text != hf.Value)
                        {
                            NewRecord = true;
                        }
                    }

                    CheckBox cb = (CheckBox)gvr.FindControl("cb_" + FieldName);
                    if (cb != null)
                    {
                        if (cb.Checked != bool.Parse(hf.Value))
                        {
                            NewRecord = true;
                        }
                    }
                }
            }
        }
        return NewRecord;
    }

    protected void UpdateData(bool NewRecord)
    {
        int SK_FarmId = int.Parse(gv_Farms.DataKeys[gv_Farms.EditIndex].Value.ToString());
        GridViewRow gvr = (GridViewRow)gv_Farms.Rows[gv_Farms.EditIndex];
        TextBox txb_LC_Farm = (TextBox)gvr.FindControl("txb_LC_Farm");

        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_Farms_Update";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pSK_FarmId = new SqlParameter("@SK_FarmId", SqlDbType.Int);
        pSK_FarmId.Value = SK_FarmId;
        sqlCmd.Parameters.Add(pSK_FarmId);

        SqlParameter pNewRecord = new SqlParameter("@NewRecord", SqlDbType.Bit);
        pNewRecord.Value = NewRecord;
        sqlCmd.Parameters.Add(pNewRecord);

        SqlParameter pEffectiveDate = new SqlParameter("@EffectiveDate", SqlDbType.DateTime);
        if (txb_EffectiveDate.Text.Length > 0)
        {
            try
            {
                pEffectiveDate.Value = DateTime.Parse(txb_EffectiveDate.Text);
            }
            catch (Exception)
            {
                pEffectiveDate.Value = DBNull.Value;
            }
        }
        else
        {
            pEffectiveDate.Value = DBNull.Value;
        }
        sqlCmd.Parameters.Add(pEffectiveDate);

        DataTable dt = (DataTable)Session["Flags"];
        foreach (DataRow dr in dt.Rows)
        {
            string FieldName = dr["FieldName"].ToString();
            bool Updatable = bool.Parse(dr["Updatable"].ToString());
            if (FieldName != "SK_FarmId")
            {
                SqlParameter p = new SqlParameter();
                p.ParameterName = "@" + FieldName;

                HiddenField hf = (HiddenField)gvr.FindControl("vhf_" + FieldName);

                TextBox txb = (TextBox)gvr.FindControl("txb_" + FieldName);
                if (txb != null)
                {
                    SqlDbType FieldType = GetFieldType(FieldName);
                    p.SqlDbType = FieldType;

                    if (FieldType == SqlDbType.DateTime)
                    {
                        p.SqlDbType = SqlDbType.DateTime;
                        try
                        {
                            p.Value = DateTime.Parse(txb.Text);
                        }
                        catch (Exception)
                        {
                            p.Value = DBNull.Value;
                        }
                    }
                    else
                    {
                        if (txb.Text.Length == 0)
                        {
                            p.Value = DBNull.Value;
                        }
                        else
                        {
                            p.Value = txb.Text;
                        }
                    }
                }

                CheckBox cb = (CheckBox)gvr.FindControl("cb_" + FieldName);
                if (cb != null)
                {
                    p.SqlDbType = SqlDbType.Bit;
                    p.Value = cb.Checked;
                }

                sqlCmd.Parameters.Add(p);
            }
        }

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetFarms(false);
        FilterData(false, 0);

        lbl_Response.Text = txb_LC_Farm.Text + " Updated.";
    }

    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static string[] GetCompletionList(string prefixText, int count, string contextKey)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT DISTINCT TOP " + count.ToString() + " " + contextKey + " FROM LU_Farms WHERE " + contextKey + " LIKE'%" + prefixText + "%' ORDER BY " + contextKey;
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "AutoComplete");
        sqlCon.Close();
        sqlCon.Dispose();

        DataTable dt = ds.Tables["AutoComplete"];

        List<string> items = new List<string>(dt.Rows.Count);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            items.Add(dt.Rows[i][contextKey].ToString());
        }

        return items.ToArray();
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridView gv = sender as GridView;
        if (gv.EditIndex > -1 && e.Row.RowIndex == gv.EditIndex)
        {
            if (Session["Flags"] != null)
            {
                DataTable dt = (DataTable)Session["Flags"];
                foreach (DataRow dr in dt.Rows)
                {
                    string FieldName = dr["FieldName"].ToString();
                    bool Updatable = bool.Parse(dr["Updatable"].ToString());
                    if (!Updatable)
                    {
                        for (int i = 0; i < gv.Columns.Count - 1; i++)
                        {
                            if (gv.Columns[i].HeaderText == FieldName)
                            {
                                DataControlFieldCell dc = (DataControlFieldCell)e.Row.Cells[i];
                                foreach (Control c in dc.Controls)
                                {
                                    if (c is TextBox)
                                    {
                                        ((TextBox)c).Enabled = false;
                                    }
                                    else if (c is CheckBox)
                                    {
                                        ((CheckBox)c).Enabled = false;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl_ActiveFrom = (Label)e.Row.FindControl("lbl_ActiveFrom");
            Label lbl_ActiveTo = (Label)e.Row.FindControl("lbl_ActiveTo");
            LinkButton lb_Edit = (LinkButton)e.Row.FindControl("lb_Edit");
            if (lbl_ActiveFrom != null && lbl_ActiveTo != null && lb_Edit != null && (lbl_ActiveTo.Text.Length > 0 || (lbl_ActiveFrom.Text.Length == 0 && lbl_ActiveTo.Text.Length == 0)))
            {
                lb_Edit.Visible = false;
            }
        }
    }

    protected void btn_Hidden_Click(object sender, EventArgs e)
    {
    }

    protected void HidePopUp()
    {
        hdf_PopUpVisible.Value = "false";
        ContentPlaceHolder MainContent = (ContentPlaceHolder)this.Master.FindControl("MainContent");
        ModalPopupExtender mpe = (ModalPopupExtender)MainContent.FindControl(hdf_PopUp.Value);
        if (mpe != null)
        {
            mpe.Hide();
        }
    }

    protected void ShowPopUp(string PopUpName)
    {
        hdf_PopUpVisible.Value = "true";
        hdf_PopUp.Value = PopUpName;

        ContentPlaceHolder MainContent = (ContentPlaceHolder)this.Master.FindControl("MainContent");
        ModalPopupExtender mpe = (ModalPopupExtender)MainContent.FindControl(PopUpName);
        if (mpe != null)
        {
            mpe.Show();
        }
    }

    protected void bt_SaveEffectiveDate_Click(object sender, EventArgs e)
    {
        rf_txb_EffectiveDate.Validate();
        cmp_txb_EffectiveDate.Validate();

        if (rf_txb_EffectiveDate.IsValid && cmp_txb_EffectiveDate.IsValid)
        {
            UpdateData(true);

            rf_txb_EffectiveDate.Enabled = false;
            cmp_txb_EffectiveDate.Enabled = false;
            txb_EffectiveDate.Text = "";

            HidePopUp();
        }
    }

    protected void bt_CancelEffectiveDate_Click(object sender, EventArgs e)
    {
        rf_txb_EffectiveDate.Enabled = false;
        cmp_txb_EffectiveDate.Enabled = false;
        txb_EffectiveDate.Text = "";
        HidePopUp();
    }

    protected void bt_SaveDeactivation_Click(object sender, EventArgs e)
    {
        rf_txb_DeactiveDate.Validate();
        cmp_txb_DeactiveDate.Validate();
        cv_txb_DeactiveDate.Validate();

        if (rf_txb_DeactiveDate.IsValid && cmp_txb_DeactiveDate.IsValid && cv_txb_DeactiveDate.IsValid)
        {
            DeactivateFarm();

            rf_txb_DeactiveDate.Enabled = false;
            cmp_txb_DeactiveDate.Enabled = false;
            txb_DeactiveDate.Text = "";
            GetFarms(true);

            HidePopUp();

            lbl_Response.Text = dd_DeactiveFarm.SelectedItem.Text + " Deactivated";
        }
    }

    protected void bt_CancelDeactivation_Click(object sender, EventArgs e)
    {
        rf_txb_DeactiveDate.Enabled = false;
        cmp_txb_DeactiveDate.Enabled = false;
        cv_txb_DeactiveDate.Enabled = false;
        txb_DeactiveDate.Text = "";
        HidePopUp();
    }

    protected void DeactivateFarm()
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "UPDATE LU_Farms SET ActiveTo = DATEADD(MINUTE, -1, DATEADD(DAY, 1, @ActiveTo)) WHERE SK_FarmId = @SK_FarmId";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pSK_FarmId = new SqlParameter("@SK_FarmId", SqlDbType.Int);
        SqlParameter pActiveTo = new SqlParameter("@ActiveTo", SqlDbType.DateTime);

        pSK_FarmId.Value = dd_DeactiveFarm.SelectedValue;
        try
        {
            pActiveTo.Value = DateTime.Parse(txb_DeactiveDate.Text);
        }
        catch (Exception)
        {
            pActiveTo.Value = DBNull.Value;
        }

        sqlCmd.Parameters.Add(pSK_FarmId);
        sqlCmd.Parameters.Add(pActiveTo);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "AutoComplete");
        sqlCon.Close();
        sqlCon.Dispose();

    }

    protected void lb_DeactiveFarm_Click(object sender, EventArgs e)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT SK_FarmId, LC_Farm FROM LU_Farms WHERE ActiveTo IS NULL ORDER BY LC_Farm";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "FarmsToDeactivate");
        sqlCon.Close();
        sqlCon.Dispose();

        DataTable dt = ds.Tables["FarmsToDeactivate"];

        dd_DeactiveFarm.Items.Clear();

        ListItem dli = new ListItem();
        dli.Value = null;
        dli.Text = "";
        dd_DeactiveFarm.Items.Add(dli);

        foreach (DataRow dr in dt.Rows)
        {
            int SK_FarmId = int.Parse(dr["SK_FarmId"].ToString());
            string LC_Farm = dr["LC_Farm"].ToString();

            ListItem li = new ListItem();
            li.Value = SK_FarmId.ToString();
            li.Text = LC_Farm;
            dd_DeactiveFarm.Items.Add(li);
        }

        txb_DeactiveDate.Text = null;
        rf_txb_DeactiveDate.Enabled = true;
        cmp_txb_DeactiveDate.Enabled = true;
        cv_txb_DeactiveDate.Enabled = true;
        ShowPopUp(mpe_DeactivateFarm.ID);
    }

    protected void cv_txb_DeactiveDate_ServerValidate(object source, ServerValidateEventArgs args)
    {
        bool isOk = true;
        CustomValidator cv = source as CustomValidator;
        string ErrorMessage = "";

        DataTable dt = (DataTable)Session["FarmData"];
        foreach (DataRow dr in dt.Rows)
        {
            int SK_FarmId = int.Parse(dr["SK_FarmId"].ToString());
            if (SK_FarmId == int.Parse(dd_DeactiveFarm.SelectedValue))
            {
                if (dr["ActiveFrom"].ToString().Length > 0)
                {
                    DateTime ActiveFrom = DateTime.Parse(dr["ActiveFrom"].ToString());
                    DateTime ActiveTo = DateTime.Parse(txb_DeactiveDate.Text).AddDays(1).AddMinutes(-1);

                    if (ActiveTo < ActiveFrom)
                    {
                        isOk = false;
                        ErrorMessage = "Date is less than the active from date - " + ActiveFrom.ToString("dd/MM/yyyy");
                    }
                }
            }
        }

        cv.ErrorMessage = ErrorMessage;
        args.IsValid = isOk;
    }

    protected void lb_MergeFarms_Click(object sender, EventArgs e)
    {
        DataTable dtm = new DataTable();

        dtm.Columns.Add("SK_FarmId", typeof(Int32));
        dtm.Columns.Add("LC_Farm", typeof(string));
        Session["FarmsToMerge"] = dtm;

        gv_FarmsToMerge.DataSource = dtm;
        gv_FarmsToMerge.DataBind();

        DataTable dtd = ((DataTable)Session["FarmData"]).Clone();
        Session["MergeFarmDetails"] = dtd;

        PopulateMergeFarmdd();
        PopulateRBLs();
        ShowPopUp(mpe_MergeFarms.ID);
    }

    protected void PopulateMergeFarmdd()
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT SK_FarmId, LC_Farm + ' (' + CAST(SK_FarmId AS NVARCHAR(25)) + ')' AS LC_Farm FROM LU_Farms WHERE ActiveTo IS NULL AND ActiveFrom IS NOT NULL ORDER BY LC_Farm";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "FarmsToMergedd");
        sqlCon.Close();
        sqlCon.Dispose();

        DataTable dt = ds.Tables["FarmsToMergedd"];

        dd_MergeFarm.Items.Clear();

        foreach (DataRow dr in dt.Rows)
        {
            int SK_FarmId = int.Parse(dr["SK_FarmId"].ToString());
            bool Match = false;
            DataTable dtmf = (DataTable)Session["FarmsToMerge"];
            foreach (DataRow dmr in dtmf.Rows)
            {
                if (SK_FarmId == int.Parse(dmr["SK_FarmId"].ToString()))
                {
                    Match = true;
                }
            }

            if (!Match)
            {
                string LC_Farm = dr["LC_Farm"].ToString();

                ListItem li = new ListItem();
                li.Value = SK_FarmId.ToString();
                li.Text = LC_Farm;
                dd_MergeFarm.Items.Add(li);
            }
        }
    }

    protected void bt_SaveMergeFarms_Click(object sender, EventArgs e)
    {
        string SK_FarmIds = GetSK_FarmIds("MergeFarmDetails");
        if (SK_FarmIds.Length > 0)
        {
            SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandText = "wsp_LU_Farms_Merge";
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Connection = sqlCon;
            sqlCmd.CommandTimeout = 300;

            SqlParameter pSK_FarmIds = new SqlParameter("@SK_FarmIds", SqlDbType.NVarChar, 255);
            pSK_FarmIds.Value = SK_FarmIds;
            sqlCmd.Parameters.Add(pSK_FarmIds);

            foreach (Control c in pnl_MergeDetails.Controls)
            {
                if (c is TextBox)
                {
                    TextBox txb = (TextBox)c;
                    if (txb.ID.Contains("mtxb_"))
                    {
                        string fieldName = txb.ID.Replace("mtxb_", "");
                        SqlParameter p = new SqlParameter();
                        p.ParameterName = "@" + fieldName;
                        SqlDbType FieldType = GetFieldType(fieldName);
                        p.SqlDbType = FieldType;

                        if (FieldType == SqlDbType.DateTime)
                        {
                            p.SqlDbType = SqlDbType.DateTime;
                            try
                            {
                                p.Value = DateTime.Parse(txb.Text);
                            }
                            catch (Exception)
                            {
                                p.Value = DBNull.Value;
                            }
                        }
                        else
                        {
                            if (txb.Text.Length == 0)
                            {
                                p.Value = DBNull.Value;
                            }
                            else
                            {
                                p.Value = txb.Text;
                            }
                        }

                        sqlCmd.Parameters.Add(p);
                    }
                }
                else if (c is CheckBox)
                {
                    CheckBox cb = (CheckBox)c;
                    if (cb.ID.Contains("mcb_"))
                    {
                        string fieldName = cb.ID.Replace("mcb_", "");
                        SqlParameter p = new SqlParameter();
                        p.SqlDbType = SqlDbType.Bit;
                        p.ParameterName = "@" + fieldName;
                        p.Value = cb.Checked;
                        sqlCmd.Parameters.Add(p);
                    }
                }
            }

            sqlCon.Open();
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            sqlCon.Dispose();
            HidePopUp();
            GetFarms(true);

            string MergedFarms = GetLC_Farm("MergeFarmDetails");

            lbl_Response.Text = "Farms (" + MergedFarms + ") merged into " + mtxb_LC_Farm.Text + ".";
        }
    }

    protected string GetSK_FarmIds(string Table)
    {
        string SK_FarmIds = "";
        DataTable dt = (DataTable)Session[Table];

        List<string> myIds = new List<string>();
        foreach (DataRow dr in dt.Rows)
        {
            myIds.Add(Convert.ToString(dr["SK_FarmId"]));
        }
        SK_FarmIds = string.Join(",", myIds);

        return SK_FarmIds;
    }

    protected string GetLC_Farm(string Table)
    {
        string LC_Farm = "";
        DataTable dt = (DataTable)Session[Table];

        List<string> myIds = new List<string>();
        foreach (DataRow dr in dt.Rows)
        {
            myIds.Add(Convert.ToString(dr["LC_Farm"]));
        }
        LC_Farm = string.Join(", ", myIds);

        return LC_Farm;
    }

    protected SqlDbType GetFieldType(string FieldName)
    {
        DataTable dt = (DataTable)Session["FarmData"];
        DataColumn dc = dt.Columns[FieldName];
        string sourceDataType = dc.DataType.Name;

        switch (sourceDataType)
        {
            case "DateTime":
                return SqlDbType.DateTime;
            case "Int":
                return SqlDbType.Int;
            case "Int32":
                return SqlDbType.Int;
            case "Int64":
                return SqlDbType.BigInt;
            case "Boolean":
                return SqlDbType.Bit;
            case "String":
                return SqlDbType.NVarChar;
            default:
                return SqlDbType.NVarChar;
        }
    }

    protected void bt_CancelMergeFarms_Click(object sender, EventArgs e)
    {
        HidePopUp();
    }

    protected void bt_AddMergeFarm_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)Session["FarmsToMerge"];
        dt.Rows.Add(dd_MergeFarm.SelectedValue, dd_MergeFarm.SelectedItem.Text);

        dt.AcceptChanges();

        gv_FarmsToMerge.DataSource = dt;
        gv_FarmsToMerge.DataBind();

        Session["FarmsToMerge"] = dt;

        DataTable dtd = (DataTable)Session["FarmData"];
        DataTable dtmd = (DataTable)Session["MergeFarmDetails"];

        DataRow[] orderRows = dtd.Select("SK_FarmId = " + dd_MergeFarm.SelectedValue);

        foreach (DataRow dr in orderRows)
        {
            dtmd.ImportRow(dr);
        }

        Session["MergeFarmDetails"] = dtmd;
        PopulateRBLs();
        PopulateMergeFarmdd();
    }

    protected void lb_DeleteFarmToMerge_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        GridViewRow gvr = (GridViewRow)lb.NamingContainer;
        int SK_FarmId = int.Parse(gv_FarmsToMerge.DataKeys[gvr.RowIndex].Value.ToString());
        DataTable dt = (DataTable)Session["FarmsToMerge"];

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (SK_FarmId == int.Parse(dt.Rows[i]["SK_FarmId"].ToString()))
            {
                dt.Rows.RemoveAt(i);
            }
        }

        dt.AcceptChanges();

        gv_FarmsToMerge.DataSource = dt;
        gv_FarmsToMerge.DataBind();
        Session["FarmsToMerge"] = dt;

        DataTable dtmd = (DataTable)Session["MergeFarmDetails"];

        for (int i = 0; i < dtmd.Rows.Count; i++)
        {
            if (SK_FarmId == int.Parse(dtmd.Rows[i]["SK_FarmId"].ToString()))
            {
                dtmd.Rows.RemoveAt(i);
            }
        }

        dtmd.AcceptChanges();
        PopulateRBLs();
    }

    protected void PopulateRBLs()
    {
        DataTable dtmd = (DataTable)Session["MergeFarmDetails"];
        bt_SaveMergeFarms.Enabled = dtmd.Rows.Count > 1;
        pnl_MergeDetails.Visible = dtmd.Rows.Count > 1;

        foreach (Control c in pnl_MergeDetails.Controls)
        {
            if (c is TextBox)
            {
                TextBox txb = (TextBox)c;
                if (txb.ID.Contains("mtxb_") && txb.ID != "mtxb_ActiveFrom" && txb.ID != "mtxb_DPRFeedEntryStartDate")
                {
                    txb.Enabled = false;
                }
            }
            else if (c is CheckBox)
            {
                CheckBox cb = (CheckBox)c;
                if (cb.ID.Contains("mcb_"))
                {
                    cb.Enabled = false;
                }
            }
            else if (c is RadioButtonList)
            {
                RadioButtonList rbl = (RadioButtonList)c;
                if (rbl.ID.Contains("mrbl_"))
                {
                    string fieldName = rbl.ID.Replace("mrbl_", "");
                    rbl.Items.Clear();
                    foreach (DataRow dr in dtmd.Rows)
                    {
                        ListItem li = new ListItem();
                        string FieldValue = "";

                        if (dr[fieldName].GetType() == typeof(DateTime))
                        {
                            try
                            {
                                DateTime fieldDate = DateTime.Parse(dr[fieldName].ToString());
                                FieldValue = fieldDate.ToString("dd/MM/yyyy");
                            }
                            catch (Exception)
                            {
                            }
                        }
                        else if (dr[fieldName].GetType() == typeof(int))
                        {
                            try
                            {
                                int fieldInt = int.Parse(dr[fieldName].ToString());
                                FieldValue = fieldInt.ToString();
                            }
                            catch (Exception)
                            {
                            }
                        }
                        else if (dr[fieldName].GetType() == typeof(bool))
                        {
                            try
                            {
                                bool fieldBool = bool.Parse(dr[fieldName].ToString());
                                FieldValue = fieldBool.ToString();
                            }
                            catch (Exception)
                            {
                            }
                        }
                        else
                        {
                            try
                            {
                                FieldValue = dr[fieldName].ToString();
                            }
                            catch (Exception)
                            {
                            }
                        }

                        li.Text = FieldValue;
                        li.Value = FieldValue;
                        rbl.Items.Add(li);
                    }

                    TextBox tb = (TextBox)pnl_MergeDetails.FindControl("mtxb_" + fieldName);
                    if (rbl.Items.Count > 0)
                    {
                        ListItem oli = new ListItem();
                        oli.Text = "Other";
                        oli.Value = "Other";
                        rbl.Items.Add(oli);

                        if (fieldName == "ActiveFrom" || fieldName == "DPRFeedEntryStartDate")
                        {
                            rbl.Enabled = false;
                            rbl.SelectedIndex = rbl.Items.Count - 1;
                        }
                        else
                        {
                            rbl.SelectedIndex = 0;
                        }

                        if (tb != null)
                        {
                            if (fieldName == "ActiveFrom" || fieldName == "DPRFeedEntryStartDate")
                            {
                                try
                                {
                                    DateTime MaxDate = DateTime.Parse(dtmd.Compute("max(ActiveFrom)", string.Empty).ToString());
                                    mtxb_ActiveFrom_CalendarExtender.StartDate = MaxDate.AddDays(1);
                                    mtxb_DPRFeedEntryStartDate_CalendarExtender.StartDate = MaxDate.AddDays(1);
                                }
                                catch (Exception)
                                {
                                }

                                if (fieldName == "ActiveFrom")
                                {
                                    tb.Text = DateTime.Today.ToString("dd/MM/yyyy");
                                }
                                else
                                {
                                    tb.Text = "";
                                }
                            }
                            else
                            {
                                tb.Text = rbl.SelectedItem.Text;
                            }
                        }
                    }
                    else
                    {
                        if (tb != null)
                        {
                            tb.Text = "";
                        }
                    }
                }
            }
        }
    }

    protected void lb_HighlightDifferencesLIVE_Click(object sender, EventArgs e)
    {
        Highlight("OSOTTLIVE");
    }

    protected void lb_HighlightDifferencesDEV_Click(object sender, EventArgs e)
    {
        Highlight("OSOTTDEV");
    }

    protected void lb_HighlightDifferencesUAT_Click(object sender, EventArgs e)
    {
        Highlight("OSOTTUAT");
    }

    protected void Highlight(string myConnectionString)
    {
        FilterData(false, 0);
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT * FROM LU_Farms";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "Highlight");
        sqlCon.Close();
        sqlCon.Dispose();

        DataTable dt = ds.Tables["Highlight"];
        Session["Highlight"] = dt;

        foreach (GridViewRow gvr in gv_Farms.Rows)
        {
            if (gvr.RowType == DataControlRowType.DataRow && gvr.RowIndex != gv_Farms.EditIndex)
            {
                int SK_FarmId = int.Parse(gv_Farms.DataKeys[gvr.RowIndex].Value.ToString());
                DataView dv = dt.DefaultView;
                dv.RowFilter = "SK_FarmId = " + SK_FarmId.ToString();
                DataTable tb = dv.ToTable();
                if (tb.Rows.Count == 0)
                {
                    gvr.BackColor = System.Drawing.Color.OrangeRed;
                    gvr.ToolTip = "Record missing";
                }
                else
                {
                    foreach (TableCell rowCell in gvr.Cells)
                    {
                        string FieldName = "";
                        string BaseValue = "";

                        foreach (Control c in rowCell.Controls)
                        {
                            if (c is Label)
                            {
                                Label lbl = (Label)c;
                                FieldName = lbl.ID.Replace("lbl_", "");
                                BaseValue = lbl.Text;
                            }
                            if (c is CheckBox)
                            {
                                CheckBox cb = (CheckBox)c;
                                FieldName = cb.ID.Replace("cb_", "");
                                BaseValue = cb.Checked.ToString();
                            }
                        }

                        if (FieldName != "")
                        {
                            DataRow dr = tb.Rows[0];

                            if (!dr.Table.Columns.Contains(FieldName))
                            {
                                rowCell.BackColor = System.Drawing.Color.OrangeRed;
                                rowCell.ToolTip = "Field does not exist!";
                            }
                            else
                            {
                                string DataType = dr[FieldName].GetType().Name;
                                string CompareValue = "";

                                if (DataType == "DateTime")
                                {
                                    if (dr[FieldName] == DBNull.Value)
                                    {
                                        CompareValue = "";
                                    }
                                    else
                                    {
                                        CompareValue = DateTime.Parse(dr[FieldName].ToString()).ToString("dd/MM/yyyy");
                                    }
                                }
                                else
                                {
                                    CompareValue = dr[FieldName].ToString();
                                }

                                if (BaseValue != CompareValue)
                                {
                                    rowCell.BackColor = System.Drawing.Color.Orange;
                                    rowCell.ToolTip = "Different: " + CompareValue;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    protected void lb_SnapShot_Click(object sender, EventArgs e)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTTDEV"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_Farms_Copy";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetFarms(true);

        lbl_Response.Text = "Finished copying from RPT-PW1.";

    }

    protected void lb_CopyToLive_Click(object sender, EventArgs e)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTTLIVE"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_Farms_Copy";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetFarms(true);

        lbl_Response.Text = "Finished copying to RPT-PW1.";
    }

    protected void lb_CopyToUAT_Click(object sender, EventArgs e)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTTUAT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_Farms_Copy";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetFarms(true);

        lbl_Response.Text = "Finished copying to SQL-UAT.";
    }

    protected void dd_DeactiveFarm_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = (DataTable)Session["FarmData"];
            int SK_FarmId = int.Parse(dd_DeactiveFarm.SelectedValue);
            DateTime MaxDate = DateTime.Parse(dt.Compute("max(ActiveFrom)", "SK_FarmId = " + SK_FarmId.ToString()).ToString());
            txb_DeactiveDate_CalendarExtender.StartDate = MaxDate.AddDays(1); ;
        }
        catch (Exception)
        {
            txb_DeactiveDate_CalendarExtender.StartDate = null;
        }
    }

    protected void bt_SaveNewFarms_Click(object sender, EventArgs e)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_Farms_Add";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        foreach (Control c in pnl_NewFarm.Controls)
        {
            if (c is TextBox)
            {
                TextBox txb = (TextBox)c;
                if (txb.ID.Contains("ntxb_"))
                {
                    string fieldName = txb.ID.Replace("ntxb_", "");
                    SqlParameter p = new SqlParameter();
                    p.ParameterName = "@" + fieldName;
                    SqlDbType FieldType = GetFieldType(fieldName);
                    p.SqlDbType = FieldType;

                    if (FieldType == SqlDbType.DateTime)
                    {
                        p.SqlDbType = SqlDbType.DateTime;
                        try
                        {
                            p.Value = DateTime.Parse(txb.Text);
                        }
                        catch (Exception)
                        {
                            p.Value = DBNull.Value;
                        }
                    }
                    else
                    {
                        if (txb.Text.Length == 0)
                        {
                            p.Value = DBNull.Value;
                        }
                        else
                        {
                            p.Value = txb.Text;
                        }
                    }

                    sqlCmd.Parameters.Add(p);
                }
            }
            else if (c is CheckBox)
            {
                CheckBox cb = (CheckBox)c;
                if (cb.ID.Contains("ncb_"))
                {
                    string fieldName = cb.ID.Replace("ncb_", "");
                    SqlParameter p = new SqlParameter();
                    p.SqlDbType = SqlDbType.Bit;
                    p.ParameterName = "@" + fieldName;
                    p.Value = cb.Checked;
                    sqlCmd.Parameters.Add(p);
                }
            }
        }

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        HidePopUp();
        GetFarms(true);

        lbl_Response.Text = "New farm, " + ntxb_LC_Farm.Text + ", created.";
    }

    protected void bt_CancelNewFarms_Click(object sender, EventArgs e)
    {
        HidePopUp();
    }

    protected void lb_NewFarm_Click(object sender, EventArgs e)
    {
        foreach (Control c in pnl_NewFarm.Controls)
        {
            if (c is TextBox)
            {
                TextBox txb = (TextBox)c;
                txb.Text = "";
            }

            if (c is CheckBox)
            {
                CheckBox cb = (CheckBox)c;
                cb.Checked = false;
            }
        }
        ShowPopUp(mpe_NewFarm.ID);
    }

    protected void gv_Farms_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv_Farms.PageIndex = e.NewPageIndex;
        FilterData(false, 0);
    }

    protected void dd_Source_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetFarms(true);
    }

    protected void lb_Edit_Load(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        lb.Visible = dd_Source.SelectedValue == "DEV";
    }

    protected void ToggelLinkButton(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        lb.Enabled = dd_Source.SelectedValue == "DEV";
    }

    protected void ToggelLinkButtonLIVE(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        lb.Visible = dd_Source.SelectedValue != "LIVE";
    }

    protected void ToggelLinkButtonUAT(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        lb.Visible = dd_Source.SelectedValue != "UAT";
    }

    protected void ToggelLinkButtonDEV(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        lb.Visible = dd_Source.SelectedValue != "DEV";
    }

    protected void bt_AddSplitFarm_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)Session["FarmsToSplitInto"];
        dt.Rows.Add(txb_FarmsToSplitInto.Text);

        dt.AcceptChanges();

        gv_FarmsToSplitInto.DataSource = dt;
        gv_FarmsToSplitInto.DataBind();

        Session["FarmsToSplitInto"] = dt;

        txb_FarmsToSplitInto.Text = "";
        CheckSplitActiveFromDate();
    }

    protected void CheckSplitActiveFromDate()
    {
        int i = 0;
        int d = 0;
        DataTable dt = (DataTable)Session["FarmsToSplitInto"];
        foreach (DataRow dr in dt.Rows)
        {
            foreach (GridViewRow gvr in gv_DairySheds.Rows)
            {
                if (gvr.RowType == DataControlRowType.DataRow)
                {
                    DropDownList dd_LC_Farm = (DropDownList)gvr.FindControl("dd_LC_Farm");

                    if (i == 0)
                    {
                        dd_LC_Farm.Items.Clear();
                    }

                    ListItem li = new ListItem(dr["LC_Farm"].ToString(), dr["LC_Farm"].ToString());
                    dd_LC_Farm.Items.Add(li);
                    d++;
                }
            }
            i++;
        }

        stxb_ActiveFrom.Enabled = i > 1;
        bt_SaveSplitFarms.Enabled = i > 1;
        pnl_DairySheds.Visible = i > 1 && d > 0;
    }

    protected void lb_DeleteFarmToSplitInto_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        GridViewRow gvr = (GridViewRow)lb.NamingContainer;
        GridView gv = (GridView)gvr.NamingContainer;
        string LC_Farm = gv.DataKeys[gvr.RowIndex].Value.ToString();

        DataTable dt = (DataTable)Session["FarmsToSplitInto"];

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (LC_Farm == dt.Rows[i]["LC_Farm"].ToString())
            {
                dt.Rows.RemoveAt(i);
            }
        }

        dt.AcceptChanges();

        gv_FarmsToSplitInto.DataSource = dt;
        gv_FarmsToSplitInto.DataBind();

        Session["FarmsToSplitInto"] = dt;

        CheckSplitActiveFromDate();
    }

    protected void bt_SaveSplitFarms_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)Session["FarmsToSplitInto"];
        foreach (DataRow dr in dt.Rows)
        {
            string NewLC_Farm = dr["LC_Farm"].ToString();
            SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandText = "wsp_LU_Farms_Split";
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Connection = sqlCon;
            sqlCmd.CommandTimeout = 300;

            SqlParameter pSK_FarmId = new SqlParameter("@SK_FarmId", SqlDbType.Int);
            pSK_FarmId.Value = dd_FarmToSplit.SelectedValue;
            sqlCmd.Parameters.Add(pSK_FarmId);

            SqlParameter pNewLC_Farm = new SqlParameter("@NewLC_Farm", SqlDbType.NVarChar, 255);
            pNewLC_Farm.Value = NewLC_Farm;
            sqlCmd.Parameters.Add(pNewLC_Farm);

            SqlParameter pActiveFrom = new SqlParameter("@ActiveFrom", SqlDbType.Date);
            pActiveFrom.Value = stxb_ActiveFrom.Text;
            sqlCmd.Parameters.Add(pActiveFrom);

            SqlParameter pNewSK_FarmId = new SqlParameter("@NewSK_FarmId", SqlDbType.Int);
            pNewSK_FarmId.Direction = ParameterDirection.Output;
            sqlCmd.Parameters.Add(pNewSK_FarmId);

            sqlCon.Open();
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            sqlCon.Dispose();

            if (pNewSK_FarmId.Value != DBNull.Value && gv_DairySheds.Rows.Count > 0)
            {
                foreach (GridViewRow gvr in gv_DairySheds.Rows)
                {
                    if (gvr.RowType == DataControlRowType.DataRow)
                    {
                        DropDownList dd_LC_Farm = (DropDownList)gvr.FindControl("dd_LC_Farm");
                        if (dd_LC_Farm.SelectedValue == NewLC_Farm)
                        {
                            int SK_ShedId = int.Parse(gv_DairySheds.DataKeys[gvr.RowIndex].Value.ToString());
                            SqlConnection sqlCon1 = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
                            SqlCommand sqlCmd1 = new SqlCommand();
                            sqlCmd1.CommandText = "wsp_LU_DairyShed_Split";
                            sqlCmd1.CommandType = CommandType.StoredProcedure;
                            sqlCmd1.Connection = sqlCon1;
                            sqlCmd1.CommandTimeout = 300;

                            SqlParameter pSK_ShedId = new SqlParameter("@SK_ShedId", SqlDbType.Int);
                            pSK_ShedId.Value = SK_ShedId;
                            sqlCmd1.Parameters.Add(pSK_ShedId);

                            SqlParameter pNewSK_FarmId1 = new SqlParameter("@NewSK_FarmId", SqlDbType.Int);
                            pNewSK_FarmId1.Value = pNewSK_FarmId.Value;
                            sqlCmd1.Parameters.Add(pNewSK_FarmId1);

                            sqlCon1.Open();
                            sqlCmd1.ExecuteNonQuery();
                            sqlCon1.Close();
                            sqlCon1.Dispose();
                        }
                    }
                }
            }
        }


        HidePopUp();
        GetFarms(true);

        string SplitFarms = GetLC_Farm("FarmsToSplitInto");
        lbl_Response.Text = "Farm " + dd_FarmToSplit.SelectedItem.Text + " split into (" + SplitFarms + ").";
    }

    protected void bt_CancelSplitFarms_Click(object sender, EventArgs e)
    {
        HidePopUp();
    }

    protected void lb_SplitFarm_Click(object sender, EventArgs e)
    {
        DataTable dtm = new DataTable();
        dtm.Columns.Add("LC_Farm", typeof(string));
        Session["FarmsToSplitInto"] = dtm;

        gv_FarmsToSplitInto.DataSource = dtm;
        gv_FarmsToSplitInto.DataBind();

        DataTable dtd = ((DataTable)Session["FarmData"]).Clone();
        Session["MergeFarmDetails"] = dtd;

        stxb_ActiveFrom.Text = "";
        stxb_ActiveFrom.Enabled = false;
        stxb_ActiveFrom_CalendarExtender.StartDate = null;

        PopulateSplitFarmdd(dd_FarmToSplit);
        getDairySheds();
        ShowPopUp(mpe_SplitFarms.ID);
    }

    protected void PopulateSplitFarmdd(DropDownList dd)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT SK_FarmId, LC_Farm + ' (' + CAST(SK_FarmId AS NVARCHAR(25)) + ')' AS LC_Farm FROM LU_Farms WHERE ActiveTo IS NULL AND ActiveFrom IS NOT NULL ORDER BY LC_Farm";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "FarmsToSplitdd");
        sqlCon.Close();
        sqlCon.Dispose();

        DataTable dt = ds.Tables["FarmsToSplitdd"];

        dd.Items.Clear();

        foreach (DataRow dr in dt.Rows)
        {
            int SK_FarmId = int.Parse(dr["SK_FarmId"].ToString());
            bool Match = false;
            DataTable dtmf = (DataTable)Session["FarmsToSplitInto"];
            foreach (DataRow dmr in dtmf.Rows)
            {
                if (SK_FarmId == int.Parse(dmr["SK_FarmId"].ToString()))
                {
                    Match = true;
                }
            }

            if (dd != dd_FarmToSplit && int.Parse(dd_FarmToSplit.SelectedValue) == int.Parse(dr["SK_FarmId"].ToString()))
            {
                Match = true;
            }

            if (!Match)
            {
                string LC_Farm = dr["LC_Farm"].ToString();

                ListItem li = new ListItem();
                li.Value = SK_FarmId.ToString();
                li.Text = LC_Farm;
                dd.Items.Add(li);
            }
        }
        dd.SelectedIndex = 0;
    }

    protected void dd_FarmToSplit_SelectedIndexChanged(object sender, EventArgs e)
    {
        getDairySheds();
    }

    protected void getDairySheds()
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT SK_ShedId, LC_ShedName + ' (' + CAST(CO_SupplyNumber AS NVARCHAR(25)) + ')' AS LC_ShedName FROM LU_DairySheds WHERE SK_FarmId = @SK_FarmId AND IsActive = 1 ORDER BY LC_ShedName";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pSK_FarmId = new SqlParameter("@SK_FarmId", SqlDbType.Int);
        pSK_FarmId.Value = dd_FarmToSplit.SelectedValue;
        sqlCmd.Parameters.Add(pSK_FarmId);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "DairySheds");
        sqlCon.Close();
        sqlCon.Dispose();

        DataTable dt = ds.Tables["DairySheds"];
        gv_DairySheds.DataSource = dt;
        gv_DairySheds.DataBind();
        CheckSplitActiveFromDate();
    }

}