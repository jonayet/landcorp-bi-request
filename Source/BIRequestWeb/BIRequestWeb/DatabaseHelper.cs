using System.Configuration;

namespace BiRequestWeb
{
    public class DatabaseHelper
    {
        public static string ConnectionString = ConfigurationManager.ConnectionStrings["Admin"].ConnectionString;
        public static string BiRequestTable = "dbo.AppBIRequest";
        public static string BiRequestTypeTable = "dbo.BIRequestType";
        public static string UserTable = "dbo.ActiveDirectoryUsers";
    }
}