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



public partial class _CompanyHierarchy : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        PopulateRootLevel();
    }

    private void PopulateRootLevel()
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["Admin"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT m.UserId, m.UserName, m.FullName, m.Title, m.ManagerUserName, (SELECT COUNT(*) FROM ActiveDirectoryUsers c WHERE c.ManagerUserName = m.UserName) AS ChildCount FROM ActiveDirectoryUsers m WHERE m.ManagerUserName IS NULL AND m.IsActive = 1 ORDER BY m.FullName";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        sqlCon.Close();
        sqlCon.Close();
        sqlCon.Dispose();

        PopulateNodes(dt, tv_CompanyHierarchy.Nodes);
    }

    private void PopulateNodes(DataTable dt, TreeNodeCollection nodes)
    {
        foreach (DataRow dr in dt.Rows)
        {
            TreeNode tn = new TreeNode();
            int UserId = 0;
            string UserName = "";
            string FullName = "";
            string Title = "";

            if (dr["UserId"] != DBNull.Value)
            {
                UserId = int.Parse(dr["UserId"].ToString());
            }

            if (dr["UserName"] != DBNull.Value)
            {
                UserName = dr["UserName"].ToString();
            }

            if (dr["FullName"] != DBNull.Value)
            {
                FullName = dr["FullName"].ToString();
            }

            if (dr["Title"] != DBNull.Value)
            {
                Title = dr["Title"].ToString();
            }

            tn.Text = "<b>" + FullName + "</b><br/><i>" + Title + "</i>";
            tn.Value = UserName;
            tn.NavigateUrl = "~/ADUsers.aspx?UserId=" + UserId.ToString();
            tn.ImageUrl = "~/Thumbnail.ashx?UserName=" + UserName;
            nodes.Add(tn);

            tn.PopulateOnDemand = ((int)(dr["ChildCount"]) > 0);
        }
    }


    private void PopulateSubLevel(string UserName, TreeNode parentNode)
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["Admin"].ConnectionString);
        SqlCommand sqlCmd = new SqlCommand();
        sqlCmd.CommandText = "SELECT m.UserId, m.UserName, m.FullName, m.Title, m.ManagerUserName, (SELECT COUNT(*) FROM ActiveDirectoryUsers c WHERE c.ManagerUserName = m.UserName) AS ChildCount FROM ActiveDirectoryUsers m WHERE m.ManagerUserName = @UserName AND m.IsActive = 1 ORDER BY m.FullName";
        sqlCmd.CommandType = CommandType.Text;
        sqlCmd.Connection = sqlCon;
        sqlCmd.CommandTimeout = 300;
        sqlCmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = UserName;

        sqlCon.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        sqlCon.Close();
        sqlCon.Close();
        sqlCon.Dispose();

        PopulateNodes(dt, parentNode.ChildNodes);
    }


    protected void tv_CompanyHierarchy_TreeNodePopulate(object sender, TreeNodeEventArgs e)
    {
        PopulateSubLevel(e.Node.Value, e.Node);
    }

    protected void lb_CollapseAll_Click(object sender, EventArgs e)
    {
        tv_CompanyHierarchy.CollapseAll();
    }

    protected void lb_ExpandAll_Click(object sender, EventArgs e)
    {
        tv_CompanyHierarchy.ExpandAll();
    }
}