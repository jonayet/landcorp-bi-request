using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace BiRequestWeb.ErrorPages
{
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

                pAppId.Value = WebConfigurationManager.AppSettings["AppId"];
                pErrorType.Value = "Unauthorised";
                pErrorString.Value = Request["Page"];
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
                lbl_Name.Text = "Hi " + Session["FullName"] + ",";
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
                HyperLink hplMailTo = (HyperLink)e.Row.FindControl("hpl_MailTo");
                HiddenField hfEmailAddress = (HiddenField)e.Row.FindControl("hf_EmailAddress");
                hplMailTo.NavigateUrl = "mailto:" + hfEmailAddress.Value + "?Subject=" + Session["AppName"] + " Access";
            }
        }
    }
}