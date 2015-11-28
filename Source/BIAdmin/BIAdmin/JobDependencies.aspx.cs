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

public partial class _JobDependencies : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetCategories();
            GetJobs(true);
        }
    }

    protected void dd_Source_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetCategories();
        GetJobs(true);
    }

    protected void GetCategories()
    {
        DataTable dt = new DataTable();
        string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_JobDependenciesCategories_Get";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(dt);
        sqlCon.Close();
        sqlCon.Dispose();

        LoadDDValues(dd_Category, dt, "category_id", "name");
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

    protected void GetJobs(bool ResetIndex)
    {
        if (ResetIndex)
        {
            gv_Jobs.SelectedIndex = -1;
            pnl_Dependencies.Visible = false;
        }

        DataTable dt = new DataTable();
        string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_JobDependenciesJobs_Get";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pIncludeDisabled = new SqlParameter("IncludeDisabled", SqlDbType.Bit);
        SqlParameter pcategory_id = new SqlParameter("category_id", SqlDbType.Int);

        pIncludeDisabled.Value = cb_IncludeDisabled.Checked;
        pcategory_id.Value = dd_Category.SelectedValue;

        sqlCmd.Parameters.Add(pIncludeDisabled);
        sqlCmd.Parameters.Add(pcategory_id);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(dt);
        sqlCon.Close();
        sqlCon.Dispose();

        gv_Jobs.DataSource = dt;
        gv_Jobs.DataBind();

    }

    protected void cb_IncludeDisabled_CheckedChanged(object sender, EventArgs e)
    {
        GetJobs(true);
    }

    protected void dd_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetJobs(true);
    }

    protected void gv_Jobs_RowDataBound(object sender, GridViewRowEventArgs e)
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
        }
    }

    protected void gv_Dependencies_RowDataBound(object sender, GridViewRowEventArgs e)
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
        }
    }

    protected void lb_Dependents_Click(object sender, EventArgs e)
    {
        UnboldLinksButtons();
        LinkButton lb = sender as LinkButton;
        GridViewRow gvr = (GridViewRow)lb.NamingContainer;
        gv_Jobs.SelectedIndex = gvr.RowIndex;
        lb.Font.Bold = true;
        lb.ForeColor = System.Drawing.Color.Red;
        Label lbl_JobName = (Label)gvr.FindControl("lbl_JobName");
        pnl_Dependencies.Visible = true;
        lbl_Dependencies.Text = "Jobs that depend on \"" + lbl_JobName.Text + "\" ...";
        hf_Type.Value = "Dependencies";
        GetDependencies();
    }

    protected void lb_Dependencies_Click(object sender, EventArgs e)
    {
        UnboldLinksButtons();
        LinkButton lb = sender as LinkButton;
        GridViewRow gvr = (GridViewRow)lb.NamingContainer;
        gv_Jobs.SelectedIndex = gvr.RowIndex;
        lb.Font.Bold = true;
        lb.ForeColor = System.Drawing.Color.Red;
        Label lbl_JobName = (Label)gvr.FindControl("lbl_JobName");
        pnl_Dependencies.Visible = true;
        lbl_Dependencies.Text = "Jobs that \"" + lbl_JobName.Text + "\" depends on ...";
        hf_Type.Value = "Depend On";
        GetDependencies();
    }

    protected void GetDependencies()
    {
        DataTable dt = new DataTable();
        string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_JobDependencies_Get";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pjob_id = new SqlParameter("job_id", SqlDbType.NVarChar, 255);
        SqlParameter pType = new SqlParameter("Type", SqlDbType.NVarChar, 25);

        pjob_id.Value = gv_Jobs.SelectedValue;
        pType.Value = hf_Type.Value;

        sqlCmd.Parameters.Add(pjob_id);
        sqlCmd.Parameters.Add(pType);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(dt);
        sqlCon.Close();
        sqlCon.Dispose();

        gv_Dependencies.DataSource = dt;
        gv_Dependencies.DataBind();

        fv_Dependencies.ChangeMode(FormViewMode.ReadOnly);
        fv_Dependencies.DataSource = dt;
        fv_Dependencies.DataBind();
    }

    protected void lb_Delete_Click(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        GridViewRow gvr = (GridViewRow)lb.NamingContainer;
        string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_JobDependencies_Delete";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pjob_id = new SqlParameter("job_id", SqlDbType.NVarChar, 255);
        SqlParameter pdependon_job_id = new SqlParameter("dependon_job_id", SqlDbType.NVarChar, 255);
        SqlParameter pType = new SqlParameter("Type", SqlDbType.NVarChar, 25);

        pjob_id.Value = gv_Jobs.SelectedValue;
        pdependon_job_id.Value = gv_Dependencies.DataKeys[gvr.RowIndex].Value.ToString();
        pType.Value = hf_Type.Value;

        sqlCmd.Parameters.Add(pjob_id);
        sqlCmd.Parameters.Add(pdependon_job_id);
        sqlCmd.Parameters.Add(pType);

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetJobs(false);
        GetDependencies();
    }

    protected void lb_New_Click(object sender, EventArgs e)
    {
        fv_Dependencies.ChangeMode(FormViewMode.Insert);
        fv_Dependencies.DataBind();

        DropDownList dd_Jobs = (DropDownList)fv_Dependencies.FindControl("dd_Jobs");
        if (dd_Jobs != null)
        {
            DataTable dt = new DataTable();
            string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
            SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandText = "wsp_JobDependenciesJobsdd_Get";
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Connection = sqlCon;
            sqlCmd.CommandTimeout = 300;

            SqlParameter pjob_id = new SqlParameter("job_id", SqlDbType.NVarChar, 255);
            SqlParameter pIncludeDisabled = new SqlParameter("IncludeDisabled", SqlDbType.Bit);

            pjob_id.Value = gv_Jobs.SelectedValue;
            pIncludeDisabled.Value = cb_IncludeDisabled.Checked;

            sqlCmd.Parameters.Add(pjob_id);
            sqlCmd.Parameters.Add(pIncludeDisabled);

            sqlCon.Open();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            DataSet ds = new DataSet();
            da.Fill(dt);
            sqlCon.Close();
            sqlCon.Dispose();

            LoadDDValues(dd_Jobs, dt, "job_id", "name");
        }
    }

    protected void lb_Insert_Click(object sender, EventArgs e)
    {
        DropDownList dd_Jobs = (DropDownList)fv_Dependencies.FindControl("dd_Jobs");

        string myConnectionString = "Admin" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_JobDependencies_Add";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter pjob_id = new SqlParameter("job_id", SqlDbType.NVarChar, 255);
        SqlParameter pdependon_job_id = new SqlParameter("dependon_job_id", SqlDbType.NVarChar, 255);
        SqlParameter pType = new SqlParameter("Type", SqlDbType.NVarChar, 25);

        pjob_id.Value = gv_Jobs.SelectedValue;
        pdependon_job_id.Value = dd_Jobs.SelectedValue;
        pType.Value = hf_Type.Value;

        sqlCmd.Parameters.Add(pjob_id);
        sqlCmd.Parameters.Add(pdependon_job_id);
        sqlCmd.Parameters.Add(pType);

        sqlCon.Open();
        sqlCmd.ExecuteNonQuery();
        sqlCon.Close();
        sqlCon.Dispose();

        GetJobs(false);
        GetDependencies();
    }

    protected void lb_Cancel_Click(object sender, EventArgs e)
    {
        fv_Dependencies.ChangeMode(FormViewMode.ReadOnly);
        fv_Dependencies.DataBind();
    }

    protected void dd_Jobs_Load(object sender, EventArgs e)
    {

    }

    protected void UnboldLinksButtons()
    {
        foreach (GridViewRow gvr in gv_Jobs.Rows)
        {
            if (gvr.RowType == DataControlRowType.DataRow)
            {
                LinkButton lb_Dependencies = (LinkButton)gvr.FindControl("lb_Dependencies");
                if (lb_Dependencies != null)
                {
                    lb_Dependencies.Font.Bold = false;
                    lb_Dependencies.ForeColor = System.Drawing.Color.Black;
                }

                LinkButton lb_Dependents = (LinkButton)gvr.FindControl("lb_Dependents");
                if (lb_Dependents != null)
                {
                    lb_Dependents.Font.Bold = false;
                    lb_Dependents.ForeColor = System.Drawing.Color.Black;
                }
            }
        }
    }
}