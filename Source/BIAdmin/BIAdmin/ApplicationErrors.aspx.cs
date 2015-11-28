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

public partial class _ApplicationErrors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (txb_StartDate.Text.Length > 0 && txb_EndDate.Text.Length > 0)
            {
                GetFarms(true);
            }
        }
        else
        {
            if (lbl_Response != null)
            {
                lbl_Response.Visible = false;
            }
        }
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (txb_StartDate.Text.Length > 0 && txb_EndDate.Text.Length > 0)
            {
                GetFarms(true);
            }
        }
    }

    protected void BindErrorGridview(DataTable dt, DataView dv)
    {
        if (dt != null)
        {
            gv_Errors.DataSource = dt;
        }
        else
        {
            gv_Errors.DataSource = dv;
        }
        gv_Errors.DataBind();

        txb_ErrorString.Text = "";
        txb_ErrorString.Visible = false;
    }

    protected void GetFarms(bool FullBind)
    {
        if (FullBind)
        {
            ContentPlaceHolder MainContent = (ContentPlaceHolder)this.Master.FindControl("MainContent");
            foreach (Control c in MainContent.Controls)
            {
                if (c is HiddenField)
                {
                    HiddenField hf = (HiddenField)c;
                    if (hf.ID.Contains("hf_"))
                    {
                        hf.Value = "All";
                    }
                }
            }
        }

        gv_Errors.EditIndex = -1;

        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["Admin"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_ApplicationErrors_Get";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pStartDate = new SqlParameter("@StartDate", SqlDbType.Date);
        SqlParameter pEndDate = new SqlParameter("@EndDate", SqlDbType.Date);

        pStartDate.Value = txb_StartDate.Text;
        pEndDate.Value = txb_EndDate.Text;

        sqlCmd.Parameters.Add(pStartDate);
        sqlCmd.Parameters.Add(pEndDate);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "AllErrors");
        sqlCon.Close();
        sqlCon.Dispose();

        DataTable dt = ds.Tables["AllErrors"];
        Session["AllErrors"] = dt;

        BindErrorGridview(dt, null);
        FilterData(false, 0);
    }

    protected void getDropDownListValues(DropDownList dd, string ColumnName, string PreviousValue)
    {
        dd.Items.Clear();

        ListItem li = new ListItem();
        li.Value = "All";
        li.Text = "All";
        dd.Items.Add(li);

        DataTable dt = (DataTable)Session["AllErrors"];
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
        gv_Errors.EditIndex = -1;
        FilterData(false, 0);
    }

    protected void FilterData(bool isEdit, int SK_FarmId)
    {
        int Filters = 0;
        string FilterExpression = "";

        GridView gv = gv_Errors;

        gv_Errors.EditIndex = -1;

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
                        HiddenField hf = (HiddenField)MainContent.FindControl(dd.ID.Replace("dd_", "hf_"));
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

        DataTable dt = (DataTable)Session["AllErrors"];

        DataView dv = new DataView(dt);
        dv.RowFilter = FilterExpression;
        dv.Sort = hdf_SortBy.Value + " " + hdf_SortDirection.Value;
        BindErrorGridview(null, dv);
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
                        HiddenField hf = (HiddenField)MainContent.FindControl(dd.ID.Replace("dd_", "hf_"));
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

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //GridView gv = sender as GridView;
        //if (gv.EditIndex > -1 && e.Row.RowIndex == gv.EditIndex)
        //{
        //    if (Session["Flags"] != null)
        //    {
        //        DataTable dt = (DataTable)Session["Flags"];
        //        foreach (DataRow dr in dt.Rows)
        //        {
        //            string FieldName = dr["FieldName"].ToString();
        //            bool Updatable = bool.Parse(dr["Updatable"].ToString());
        //            if (!Updatable)
        //            {
        //                for (int i = 0; i < gv.Columns.Count - 1; i++)
        //                {
        //                    if (gv.Columns[i].HeaderText == FieldName)
        //                    {
        //                        DataControlFieldCell dc = (DataControlFieldCell)e.Row.Cells[i];
        //                        foreach (Control c in dc.Controls)
        //                        {
        //                            if (c is TextBox)
        //                            {
        //                                ((TextBox)c).Enabled = false;
        //                            }
        //                            else if (c is CheckBox)
        //                            {
        //                                ((CheckBox)c).Enabled = false;
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }
        //    }
        //}
        //else if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    Label lbl_ActiveFrom = (Label)e.Row.FindControl("lbl_ActiveFrom");
        //    Label lbl_ActiveTo = (Label)e.Row.FindControl("lbl_ActiveTo");
        //    LinkButton lb_Edit = (LinkButton)e.Row.FindControl("lb_Edit");
        //    if (lbl_ActiveFrom != null && lbl_ActiveTo != null && lb_Edit != null && (lbl_ActiveTo.Text.Length > 0 || (lbl_ActiveFrom.Text.Length == 0 && lbl_ActiveTo.Text.Length == 0)))
        //    {
        //        lb_Edit.Visible = false;
        //    }
        //}
    }

    protected SqlDbType GetFieldType(string FieldName)
    {
        DataTable dt = (DataTable)Session["AllErrors"];
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

    protected void gv_Errors_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv_Errors.PageIndex = e.NewPageIndex;
        FilterData(false, 0);
    }

    protected void txb_StartDate_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txb_StartDate.Text = DateTime.Today.AddDays(-6).ToString("dd/MM/yyy");
        }
    }

    protected void txb_EndDate_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txb_EndDate.Text = DateTime.Today.ToString("dd/MM/yyy");
        }
    }

    protected void txb_StartDate_TextChanged(object sender, EventArgs e)
    {
        GetFarms(true);
    }

    protected void txb_EndDate_TextChanged(object sender, EventArgs e)
    {
        GetFarms(true);
    }

    protected void lb_TrimmedErrorString_Click(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        GridViewRow gvr = (GridViewRow)lb.NamingContainer;
        HiddenField hf = (HiddenField)gvr.FindControl("hf_ErrorString");

        txb_ErrorString.Text = hf.Value;
        txb_ErrorString.Visible = true;
    }
}