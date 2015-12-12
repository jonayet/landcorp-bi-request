using System.Configuration;

namespace BiRequestWeb
{
    public class DatabaseHelper
    {
        public static string ConnectionString = ConfigurationManager.ConnectionStrings["Admin"].ConnectionString;
        public static string BiRequestTable = "dbo.AppBiRequest";
        public static string BiRequestTypeTable = "dbo.BiRequestType";
    }
}