using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.DirectoryServices.AccountManagement;
using System.Web.Configuration;
using System.Configuration;

namespace BIAdmin
{
    public class Global : System.Web.HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
        }

        void Application_End(object sender, EventArgs e)
        {
        }

        void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();
            HttpContext context = HttpContext.Current;
            if (context != null && context.Session != null)
            {
                Session["ErrorPageName"] = Request.Url.PathAndQuery;
                Session["ErrorMessage"] = ex.Message;
                Session["InnerException"] = ex.InnerException;

                try
                {
                    string ErrorPageName = "Error Page Name: " + Request.Url.PathAndQuery;
                    string ErrorMessage = "Error Message: " + ex.Message;
                    string InnerException = "Inner Exception: " + ex.InnerException;

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
                    pErrorType.Value = "Web Error";
                    pErrorString.Value = ErrorPageName + Environment.NewLine + ErrorMessage + Environment.NewLine + InnerException;
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

        void Session_Start(object sender, EventArgs e)
        {
        }

        void Session_End(object sender, EventArgs e)
        {
        }
    }
}