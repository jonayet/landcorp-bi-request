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

public partial class _LU_DairySheds : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetSheds(true);
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

    protected void BindShedGridview(DataTable dt, DataView dv)
    {
        if (dt != null)
        {
            gv_Sheds.DataSource = dt;
        }
        else
        {
            gv_Sheds.DataSource = dv;
        }
        gv_Sheds.DataBind();
    }

    protected void GetSheds(bool FullBind)
    {
        if (FullBind)
        {
            ContentPlaceHolder MainContent = (ContentPlaceHolder)this.Master.FindControl("MainContent");
            foreach (Control c in MainContent.Controls)
            {
                if (c is HiddenField)
                {
                    HiddenField hf = (HiddenField)c;
                    if (!Page.IsPostBack && Request["SK_ShedId"] != null && hf.ID == "hf_SK_ShedId")
                    {
                        hf.Value = Request["SK_ShedId"].ToString();
                    }
                    else if (hf.ID.Contains("hf_"))
                    {
                        hf.Value = "All";
                    }
                }
            }
        }

        gv_Sheds.EditIndex = -1;

        string myConnectionString = "OSOTT" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT * FROM LU_DairySheds ORDER BY LC_ShedName, IsActive";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "ShedData");
        sqlCon.Close();
        sqlCon.Dispose();

        DataTable dt = ds.Tables["ShedData"];
        Session["ShedData"] = dt;

        BindShedGridview(dt, null);
        FilterData(false, 0);
    }

    protected void getDropDownListValues(DropDownList dd, string ColumnName, string PreviousValue)
    {
        dd.Items.Clear();

        ListItem li = new ListItem();
        li.Value = "All";
        li.Text = "All";
        dd.Items.Add(li);

        DataTable dt = (DataTable)Session["ShedData"];
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
        gv_Sheds.EditIndex = -1;
        FilterData(false, 0);
    }

    protected void FilterData(bool isEdit, int SK_ShedId)
    {
        int Filters = 0;
        string FilterExpression = "";

        GridView gv = gv_Sheds;

        if (isEdit)
        {
            FilterExpression = "SK_ShedId = " + SK_ShedId.ToString();
            Filters++;
            gv.EditIndex = 0;
        }
        else
        {
            gv_Sheds.EditIndex = -1;

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

        DataTable dt = (DataTable)Session["ShedData"];

        DataView dv = new DataView(dt);
        dv.RowFilter = FilterExpression;
        dv.Sort = hdf_SortBy.Value + " " + hdf_SortDirection.Value;
        BindShedGridview(null, dv);
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

        int SK_ShedId = int.Parse(gv.DataKeys[gvr.RowIndex].Value.ToString());
        FilterData(true, SK_ShedId);
    }

    protected void lb_Cancel_Click(object sender, EventArgs e)
    {
        FilterData(false, 0);
    }

    protected void lb_Update_Click(object sender, EventArgs e)
    {        
        GridViewRow gvr = (GridViewRow)gv_Sheds.Rows[gv_Sheds.EditIndex];
        TextBox txb_farm_Id = (TextBox)gvr.FindControl("txb_farm_Id");
        TextBox txb_SK_FarmId = (TextBox)gvr.FindControl("txb_SK_FarmId");

        if (IsOK(int.Parse(txb_farm_Id.Text), int.Parse(txb_SK_FarmId.Text)))
        {
            UpdateData();
        }
        else
        {
            lbl_Response.Text = "farm id and SK Farm Id are not a pair!";
        }
    }

    protected bool IsOK(int farm_Id, int SK_FarmId)
    {
        bool IsOK = false;

        int RecordCount = 0;

        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT COUNT(*) AS RecordCount FROM LU_Farms WHERE farm_id = @farm_Id AND SK_FarmId = @SK_FarmId";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pfarm_id = new SqlParameter("@farm_id", SqlDbType.Int);
        pfarm_id.Value = farm_Id;
        sqlCmd.Parameters.Add(pfarm_id);

        SqlParameter pSK_FarmId = new SqlParameter("@SK_FarmId", SqlDbType.Int);
        pSK_FarmId.Value = SK_FarmId;
        sqlCmd.Parameters.Add(pSK_FarmId);

        sqlCmd.Connection = sqlCon;
        sqlCon.Open();

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

        if (RecordCount > 0)
        {
            IsOK = true;
        }

        rd.Close();
        rd.Dispose();
        sqlCon.Close();
        sqlCon.Dispose();

        return IsOK;
    }

    protected void UpdateData()
    {
        int SK_ShedId = int.Parse(gv_Sheds.DataKeys[gv_Sheds.EditIndex].Value.ToString());
        GridViewRow gvr = (GridViewRow)gv_Sheds.Rows[gv_Sheds.EditIndex];
        TextBox txb_LC_ShedName = (TextBox)gvr.FindControl("txb_LC_ShedName");

        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_DairySheds_Update";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pSK_ShedId = new SqlParameter("@SK_ShedId", SqlDbType.Int);
        pSK_ShedId.Value = SK_ShedId;
        sqlCmd.Parameters.Add(pSK_ShedId);

        GridView gv = (GridView)gvr.NamingContainer;
        if (gv.HeaderRow != null)
        {
            foreach (TableCell headerCell in gv.HeaderRow.Cells)
            {
                foreach (Control c in headerCell.Controls)
                {
                    if (c is DropDownList)
                    {
                        DropDownList dd = (DropDownList)c;
                        string FieldName = dd.ID.Replace("dd_", "");
                        if (FieldName != "SK_ShedId")
                        {
                            SqlParameter p = new SqlParameter();
                            p.ParameterName = "@" + FieldName;

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
                }
            }
        }

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetSheds(false);
        FilterData(false, 0);

        lbl_Response.Text = txb_LC_ShedName.Text + " Updated.";
    }

    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static string[] GetCompletionList(string prefixText, int count, string contextKey)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT DISTINCT TOP " + count.ToString() + " " + contextKey + " FROM LU_DairySheds WHERE " + contextKey + " LIKE'%" + prefixText + "%' ORDER BY " + contextKey;
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

    protected string GetSK_ShedIds(string Table)
    {
        string SK_ShedIds = "";
        DataTable dt = (DataTable)Session[Table];

        List<string> myIds = new List<string>();
        foreach (DataRow dr in dt.Rows)
        {
            myIds.Add(Convert.ToString(dr["SK_ShedId"]));
        }
        SK_ShedIds = string.Join(",", myIds);

        return SK_ShedIds;
    }

    protected string GetLC_ShedName(string Table)
    {
        string LC_Shed = "";
        DataTable dt = (DataTable)Session[Table];

        List<string> myIds = new List<string>();
        foreach (DataRow dr in dt.Rows)
        {
            myIds.Add(Convert.ToString(dr["LC_Shed"]));
        }
        LC_Shed = string.Join(", ", myIds);

        return LC_Shed;
    }

    protected SqlDbType GetFieldType(string FieldName)
    {
        DataTable dt = (DataTable)Session["ShedData"];
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
        sqlCmd.CommandText = "SELECT * FROM LU_DairySheds";
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

        foreach (GridViewRow gvr in gv_Sheds.Rows)
        {
            if (gvr.RowType == DataControlRowType.DataRow && gvr.RowIndex != gv_Sheds.EditIndex)
            {
                int SK_ShedId = int.Parse(gv_Sheds.DataKeys[gvr.RowIndex].Value.ToString());
                DataView dv = dt.DefaultView;
                dv.RowFilter = "SK_ShedId = " + SK_ShedId.ToString();
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
        sqlCmd.CommandText = "wsp_LU_DairySheds_Copy";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetSheds(true);

        lbl_Response.Text = "Finished copying from RPT-PW1.";

    }

    protected void lb_CopyToLive_Click(object sender, EventArgs e)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTTLIVE"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_DairySheds_Copy";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetSheds(true);

        lbl_Response.Text = "Finished copying to RPT-PW1.";
    }

    protected void lb_CopyToUAT_Click(object sender, EventArgs e)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTTUAT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_DairySheds_Copy";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetSheds(true);

        lbl_Response.Text = "Finished copying to SQL-UAT.";
    }

    protected void bt_SaveNewSheds_Click(object sender, EventArgs e)
    {
        if (IsOK(int.Parse(ntxb_farm_Id.Text), int.Parse(ntxb_SK_FarmId.Text)))
        {
            SaveShed();
        }
        else
        {
            lbl_Response.Text = "farm id and SK Farm Id are not a pair!";
        }
    }
    protected void SaveShed()
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["OSOTT"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_DairySheds_Add";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        foreach (Control c in pnl_NewShed.Controls)
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
        GetSheds(true);

        lbl_Response.Text = "New Shed, " + ntxb_LC_ShedName.Text + ", created.";
    }

    protected void bt_CancelNewSheds_Click(object sender, EventArgs e)
    {
        HidePopUp();
    }

    protected void lb_NewShed_Click(object sender, EventArgs e)
    {
        foreach (Control c in pnl_NewShed.Controls)
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
        ShowPopUp(mpe_NewShed.ID);
    }

    protected void gv_Sheds_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv_Sheds.PageIndex = e.NewPageIndex;
        FilterData(false, 0);
    }

    protected void dd_Source_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetSheds(true);
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
}