using System.Configuration;

namespace BiRequestWeb
{
    public class DatabaseHelper
    {
        public static string BIRequestConnectionString = ConfigurationManager.ConnectionStrings["BIRequest"].ConnectionString;
        public static string AdminConnectionString = ConfigurationManager.ConnectionStrings["Admin"].ConnectionString;
        public static string BiRequestTable = "dbo.Request";
        public static string AttachmentTable = "dbo.Attachments";
        public static string BiRequestTypeTable = "dbo.RequestType";
        public static string AdminUserTable = "dbo.ActiveDirectoryUsers";
    }
}