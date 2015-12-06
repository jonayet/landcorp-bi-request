using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;

namespace BIRequestWeb
{
    public static class Authentication
    {
        public static void SetSessionVariables()
        {
            int appId = int.Parse(WebConfigurationManager.AppSettings["AppId"]);
            string userName = GetUserName(appId);

            HttpContext.Current.Session["AppId"] = appId;
            HttpContext.Current.Session["UserName"] = userName;

            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Admin"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "wsp_AppUserDetails_Get",
                CommandTimeout = 300,
                Connection = sqlConn
            };

            SqlParameter pAppId = new SqlParameter("@AppId", SqlDbType.Int);
            SqlParameter pUserName = new SqlParameter("@UserName", SqlDbType.NVarChar, 50);

            pAppId.Value = appId;
            pUserName.Value = userName;

            sqlCmd.Parameters.Add(pAppId);
            sqlCmd.Parameters.Add(pUserName);

            sqlConn.Open();

            SqlDataReader rd = sqlCmd.ExecuteReader();
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    for (int c = 0; c < rd.FieldCount; c++)
                    {
                        string fieldName = rd.GetName(c);
                        string fieldValue = rd[fieldName].ToString();
                        HttpContext.Current.Session[fieldName] = fieldValue;
                    }
                }
            }

            rd.Close();
            rd.Dispose();
            sqlConn.Close();
            sqlConn.Dispose();

            if (HttpContext.Current.Session["AppOnline"] != null && bool.Parse(HttpContext.Current.Session["AppOnline"].ToString()) == false)
            {
                HttpContext.Current.Response.Redirect("Offline");
            }
        }

        private static string GetUserName(int appId)
        {
            string userName = Regex.Replace(HttpContext.Current.User.Identity.Name, ".*\\\\(.*)", "$1", RegexOptions.None).ToUpper();
            userName = "BAILEYD";
            string queryUserName = userName;

            if (HttpContext.Current.Request["UserName"] != null)
            {
                queryUserName = HttpContext.Current.Request["UserName"].ToUpper();
            }

            if (userName != queryUserName)
            {
                SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Admin"].ConnectionString);
                SqlCommand sqlCmd = new SqlCommand
                {
                    CommandType = CommandType.StoredProcedure,
                    CommandText = "wsp_AppUserCheckQueryAccess_Get",
                    CommandTimeout = 300,
                    Connection = sqlConn
                };

                SqlParameter pAppId = new SqlParameter("@AppId", SqlDbType.Int);
                SqlParameter pUserName = new SqlParameter("@UserName", SqlDbType.NVarChar, 50);
                SqlParameter pQueryUserName = new SqlParameter("@QueryUserName", SqlDbType.NVarChar, 50);

                pAppId.Value = appId;
                pUserName.Value = userName;
                pQueryUserName.Value = queryUserName;

                sqlCmd.Parameters.Add(pAppId);
                sqlCmd.Parameters.Add(pUserName);
                sqlCmd.Parameters.Add(pQueryUserName);

                sqlConn.Open();

                SqlDataReader rd = sqlCmd.ExecuteReader();
                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        for (int c = 0; c < rd.FieldCount; c++)
                        {
                            userName = rd["Username"].ToString();
                        }
                    }
                }

                rd.Close();
                rd.Dispose();
                sqlConn.Close();
                sqlConn.Dispose();
            }

            return userName;
        }
    }
}