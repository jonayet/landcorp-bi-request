using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Text;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;

public partial class _USPDifferences : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Load_dd_SourceDatabase();
            Load_dd_SourceStoredProcedure();

            Load_dd_CompareDatabase();
            Load_dd_CompareStoredProcedure();
            
            LoadLabelsAndHighlight();
        }
    }

    protected void Load_dd_SourceDatabase()
    {
        DataTable dt = new DataTable();

        SqlConnection sqlCon = new SqlConnection("Data Source=" + dd_SourceServer.SelectedValue + ";Initial Catalog=Master;Integrated Security=true;Connection Timeout=60");
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT name FROM Sys.Databases WHERE name NOT IN('master', 'model', 'msdb', 'tempdb') ORDER BY name";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        da.Fill(dt);
        sqlCon.Close();
        da.Dispose();

        LoadDDValues(dd_SourceDatabase, dt, "name", "name");
    }

    protected void Load_dd_CompareDatabase()
    {
        DataTable dt = new DataTable();

        SqlConnection sqlCon = new SqlConnection("Data Source=" + dd_CompareServer.SelectedValue + ";Initial Catalog=Master;Integrated Security=true;Connection Timeout=60");
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT name FROM Sys.Databases WHERE name NOT IN('master', 'model', 'msdb', 'tempdb') ORDER BY name";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        da.Fill(dt);
        sqlCon.Close();
        da.Dispose();

        LoadDDValues(dd_CompareDatabase, dt, "name", "name");

        if (dd_CompareDatabase.Items.FindByValue(dd_SourceDatabase.SelectedValue) != null)
        {
            dd_CompareDatabase.SelectedIndex = -1;
            dd_CompareDatabase.Items.FindByValue(dd_SourceDatabase.SelectedValue).Selected = true;
        }
    }

    protected void Load_dd_SourceStoredProcedure()
    {
        DataTable dt = new DataTable();

        SqlConnection sqlCon = new SqlConnection("Data Source=" + dd_SourceServer.SelectedValue + ";Initial Catalog=" + dd_SourceDatabase.SelectedValue + ";Integrated Security=true;Connection Timeout=60");
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT ROUTINE_SCHEMA + '.' + ROUTINE_NAME AS USPName FROM INFORMATION_SCHEMA.ROUTINES ORDER BY USPName";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        da.Fill(dt);
        sqlCon.Close();
        da.Dispose();

        LoadDDValues(dd_SourceStoredProcedure, dt, "USPName", "USPName");
    }

    protected void Load_dd_CompareStoredProcedure()
    {
        DataTable dt = new DataTable();

        SqlConnection sqlCon = new SqlConnection("Data Source=" + dd_CompareServer.SelectedValue + ";Initial Catalog=" + dd_CompareDatabase.SelectedValue + ";Integrated Security=true;Connection Timeout=60");
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT ROUTINE_SCHEMA + '.' + ROUTINE_NAME AS USPName FROM INFORMATION_SCHEMA.ROUTINES ORDER BY USPName";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        da.Fill(dt);
        sqlCon.Close();
        da.Dispose();

        LoadDDValues(dd_CompareStoredProcedure, dt, "USPName", "USPName");

        if (dd_CompareStoredProcedure.Items.FindByValue(dd_SourceStoredProcedure.SelectedValue) != null)
        {
            dd_CompareStoredProcedure.SelectedIndex = -1;
            dd_CompareStoredProcedure.Items.FindByValue(dd_SourceStoredProcedure.SelectedValue).Selected = true;
        }
    }

    protected void Load_lbl_SourceDefinition()
    {
        SqlConnection sqlConn = new SqlConnection("Data Source=" + dd_SourceServer.SelectedValue + ";Initial Catalog=" + dd_SourceDatabase.SelectedValue + ";Integrated Security=true;Connection Timeout=60");
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT OBJECT_DEFINITION (OBJECT_ID(N'" + dd_SourceStoredProcedure.SelectedValue + "')) AS ROUTINE_DEFINITION";
        //sqlCmd.CommandText = "SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA + '.' + ROUTINE_NAME = '" + dd_SourceStoredProcedure.SelectedValue + "'";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlConn;
        sqlCmd.CommandTimeout = 300;

        sqlCmd.Connection = sqlConn;
        sqlConn.Open();

        string strUSP = "";
        SqlDataReader rd = sqlCmd.ExecuteReader();
        if (rd.HasRows)
        {
            while (rd.Read())
            {
                if (rd["ROUTINE_DEFINITION"] != DBNull.Value)
                {
                    strUSP = rd["ROUTINE_DEFINITION"].ToString();
                }
            }
        }

        rd.Close();
        rd.Dispose();
        sqlConn.Close();
        sqlConn.Dispose();

        ltl_SourceDefinition.Text = strUSP.Replace("<", "&lt;").Replace(">", "&gt;").Replace("\r\n", "<br/>").Replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
    }

    protected void Load_lbl_CompareDefinition()
    {
        SqlConnection sqlConn = new SqlConnection("Data Source=" + dd_CompareServer.SelectedValue + ";Initial Catalog=" + dd_CompareDatabase.SelectedValue + ";Integrated Security=true;Connection Timeout=60");
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT OBJECT_DEFINITION (OBJECT_ID(N'" + dd_CompareStoredProcedure.SelectedValue + "')) AS ROUTINE_DEFINITION";
        //sqlCmd.CommandText = "SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA + '.' + ROUTINE_NAME = '" + dd_CompareStoredProcedure.SelectedValue + "'";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlConn;
        sqlCmd.CommandTimeout = 300;

        sqlCmd.Connection = sqlConn;
        sqlConn.Open();

        string strUSP = "";
        SqlDataReader rd = sqlCmd.ExecuteReader();
        if (rd.HasRows)
        {
            while (rd.Read())
            {
                if (rd["ROUTINE_DEFINITION"] != DBNull.Value)
                {
                    strUSP = rd["ROUTINE_DEFINITION"].ToString();
                }
            }
        }

        rd.Close();
        rd.Dispose();
        sqlConn.Close();
        sqlConn.Dispose();

        ltl_CompareDefinition.Text = strUSP.Replace("<", "&lt;").Replace(">", "&gt;").Replace("\r\n", "<br/>").Replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
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

    protected void LoadLabelsAndHighlight()
    {
        Load_lbl_SourceDefinition();
        Load_lbl_CompareDefinition();
        HighlLightDifferences();
    }

    protected void dd_SourceServer_SelectedIndexChanged(object sender, EventArgs e)
    {
        Load_dd_SourceDatabase();
        Load_dd_SourceStoredProcedure();
        Load_dd_CompareDatabase();
        Load_dd_CompareStoredProcedure();
        LoadLabelsAndHighlight();
    }

    protected void dd_CompareServer_SelectedIndexChanged(object sender, EventArgs e)
    {
        Load_dd_CompareDatabase();
        Load_dd_CompareStoredProcedure();
        LoadLabelsAndHighlight();
    }

    protected void dd_SourceDatabase_SelectedIndexChanged(object sender, EventArgs e)
    {
        Load_dd_SourceStoredProcedure();
        Load_dd_CompareDatabase();
        Load_dd_CompareStoredProcedure();
        LoadLabelsAndHighlight();
    }

    protected void dd_CompareDatabase_SelectedIndexChanged(object sender, EventArgs e)
    {
        Load_dd_CompareStoredProcedure();
        LoadLabelsAndHighlight();
    }

    protected void dd_SourceStoredProcedure_SelectedIndexChanged(object sender, EventArgs e)
    {
        Load_dd_CompareStoredProcedure();
        LoadLabelsAndHighlight();
    }

    protected void dd_CompareStoredProcedure_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadLabelsAndHighlight();
    }

    protected void HighlLightDifferences()
    {
        string[] strSourceArray = ltl_SourceDefinition.Text.Split(new string[] { "<br/>" }, StringSplitOptions.None);
        string[] strCompareArray = ltl_CompareDefinition.Text.Split(new string[] { "<br/>" }, StringSplitOptions.None);

        for (int s = 0; s < strSourceArray.Length; s++)
        {
            string strSourceLine = strSourceArray[s];
            string strCompareLine = "";

            if (strCompareArray.Length > s)
            {
                strCompareLine = strCompareArray[s];
            }

            if (strSourceLine.Length > 0 && strSourceLine != "" && strSourceLine != strCompareLine)
            {
                bool found = false;
                for (int c = 0; c < strCompareArray.Length; c++)
                {
                    string strCompare = strCompareArray[c];
                    if (strSourceLine == strCompare)
                    {
                        found = true;
                    }
                }
                string newSourceLine;
                if (found)
                {
                    newSourceLine = "<font color=\"Green\">" + strSourceLine + "</font>";
                }
                else
                {
                    newSourceLine = "<font color=\"Red\">" + strSourceLine + "</font>";
                }
                strSourceArray[s] = newSourceLine;
            }
        }

        ltl_SourceDefinition.Text = string.Join("<br/>", strSourceArray);
    }
}