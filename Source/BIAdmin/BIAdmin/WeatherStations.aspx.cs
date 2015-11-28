using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class _WeatherStations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetWeatherStations(-1);
        }
    }

    protected void dd_Source_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetWeatherStations(-1);
    }

    protected void GetWeatherStations(int iEditIndex)
    {
        DataTable dt = new DataTable();
        gv_WeatherStations.EditIndex = iEditIndex;

        string myConnectionString = "OSOTT" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_WeatherStations_Get";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter p1 = new SqlParameter("@ShowOnlyActive", SqlDbType.Bit);
        p1.Value = cb_ActiveOnly.Checked;
        sqlCmd.Parameters.Add(p1);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(dt);
        sqlCon.Close();
        sqlCon.Dispose();

        DataView dv = dt.DefaultView;
        dv.Sort = hdf_SortBy.Value + " " + hdf_SortDirection.Value;

        gv_WeatherStations.DataSource = dv;
        gv_WeatherStations.DataBind();
    }

    protected void cb_ActiveOnly_CheckedChanged(object sender, EventArgs e)
    {
        GetWeatherStations(-1);
    }

    protected void gv_WeatherStations_Sorting(object sender, GridViewSortEventArgs e)
    {
        if (hdf_SortBy.Value == e.SortExpression)
        {
            SwitchSorting();
        }
        else
        {
            hdf_SortBy.Value = e.SortExpression;
            hdf_SortDirection.Value = GetSortDirection(e.SortDirection);
        }

        GetWeatherStations(-1);
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

    string GetSortDirection(SortDirection sSortDirCmd)
    {
        string sSortDir;
        if ((SortDirection.Ascending == sSortDirCmd))
        {
            sSortDir = "ASC";
        }
        else
        {
            sSortDir = "DESC";
        }
        return sSortDir;
    }

    protected void dd_farm_id_Load(object sender, EventArgs e)
    {
        DropDownList dd = sender as DropDownList;
        dd.Items.Clear();

        DataTable dt = new DataTable();

        string myConnectionString = "OSOTT" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_WeatherStationsFarms_Get";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter p1 = new SqlParameter("@ShowOnlyActive", SqlDbType.Bit);
        p1.Value = cb_ActiveOnly.Checked;
        sqlCmd.Parameters.Add(p1);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(dt);
        sqlCon.Close();
        sqlCon.Dispose();

        LoadDDValues(dd, dt, "farm_id", "LC_Farm");
    }

    protected void dd_WTH_StationId_Load(object sender, EventArgs e)
    {
        DropDownList dd = sender as DropDownList;
        dd.Items.Clear();

        DataTable dt = new DataTable();

        string myConnectionString = "OSOTT" + dd_Source.SelectedValue.ToString();
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings[myConnectionString].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "wsp_LU_WeatherStationsWeatherStations_Get";
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        SqlParameter p1 = new SqlParameter("@ShowOnlyActive", SqlDbType.Bit);
        p1.Value = cb_ActiveOnly.Checked;
        sqlCmd.Parameters.Add(p1);

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(dt);
        sqlCon.Close();
        sqlCon.Dispose();

        LoadDDValues(dd, dt, "FarmID", "FarmDesc");
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

    protected void lb_Edit_Click(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        GridViewRow gvr = (GridViewRow)lb.NamingContainer;
        GridView gv = (GridView)gvr.NamingContainer;

        GetWeatherStations(gvr.RowIndex);
    }

    protected void lb_Cancel_Click(object sender, EventArgs e)
    {
        GetWeatherStations(-1);
    }

    protected void lb_Update_Click(object sender, EventArgs e)
    {
        GetWeatherStations(-1);
    }
}