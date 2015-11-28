using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices.AccountManagement;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Text.RegularExpressions;

public partial class Unauthorised : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string connStr = ConfigurationManager.ConnectionStrings["Admin"].ConnectionString;
            SqlConnection sqlConn = new SqlConnection(connStr);
            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.Text;
            sqlCmd.CommandText = "usp_SaveApplicationError";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.CommandType = CommandType.StoredProcedure;

            SqlParameter pAppId = new SqlParameter("@AppId", SqlDbType.Int);
            SqlParameter pErrorType = new SqlParameter("@ErrorType", SqlDbType.NVarChar, 255);
            SqlParameter pErrorString = new SqlParameter("@ErrorString", SqlDbType.NVarChar, 4000);
            SqlParameter pUserName = new SqlParameter("@UserName", SqlDbType.NVarChar, 50);

            pAppId.Value = WebConfigurationManager.AppSettings["AppId"].ToString();
            pErrorType.Value = "Unauthorised";
            pErrorString.Value = Request["Page"].ToString();
            pUserName.Value = Regex.Replace(HttpContext.Current.User.Identity.Name, ".*\\\\(.*)", "$1", RegexOptions.None).ToUpper();

            sqlCmd.Parameters.Add(pAppId);
            sqlCmd.Parameters.Add(pErrorType);
            sqlCmd.Parameters.Add(pErrorString);
            sqlCmd.Parameters.Add(pUserName);

            sqlCmd.Connection = sqlConn;
            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            sqlConn.Close();
            sqlConn.Dispose();
        }
        catch (Exception)
        {
        }

        if (Session["FullName"] != null)
        {
            lbl_Name.Text = "Hi " + Session["FullName"].ToString() + ",";
        }
        else
        {
            lbl_Name.Text = "Hi " + Regex.Replace(HttpContext.Current.User.Identity.Name, ".*\\\\(.*)", "$1", RegexOptions.None).ToUpper() + ",";
        }
    }

    protected void gv_AppOwners_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink hpl_MailTo = (HyperLink)e.Row.FindControl("hpl_MailTo");
            HiddenField hf_EmailAddress = (HiddenField)e.Row.FindControl("hf_EmailAddress");
            hpl_MailTo.NavigateUrl = "mailto:" + hf_EmailAddress.Value + "?Subject=" + Session["AppName"].ToString() + " Access";
        }
    }
}