using System.Configuration;

namespace BIRequestWeb.DAL
{
    public class DatabaseHelper
    {
        public static string ConnectionString = ConfigurationManager.ConnectionStrings["Admin"].ConnectionString;
    }
}