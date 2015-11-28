using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.Configuration;

public partial class _404 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["aspxerrorpath"] != null)
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
                pErrorType.Value = "Web Error 404";
                pErrorString.Value = Request["aspxerrorpath"].ToString();
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
        }
    }
}