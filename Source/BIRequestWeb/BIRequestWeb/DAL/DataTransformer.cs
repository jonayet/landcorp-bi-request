using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BiRequestWeb.DAL
{
    public static class DataTransformer
    {
        public static DateTime? ParseDateString(string dateTime)
        {
            if (string.IsNullOrWhiteSpace(dateTime)) return null;
            DateTime dt;
            DateTime.TryParse(dateTime, out dt);
            return dt;
        }

        public static string ConvertDateToString(DateTime? dateTime)
        {
            return dateTime?.ToString("d");
        }

        public static int? ParseIntString(string intString)
        {
            int i;
            if (int.TryParse(intString, out i)) return i;
            return null;
        }

        public static long ParseNullableLong(long? bigInteger)
        {
            return bigInteger ?? default(long);
        }

        public static string ParseText(string text)
        {
            return string.IsNullOrWhiteSpace(text) ? null : text;
        }
    }
}