using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;
using Newtonsoft.Json;

namespace BiRequestWeb
{
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    public class BirequestWebService : WebService
    {
        [WebMethod]
        public void SearchUser(string query)
        {
            var possibleResponses = Get(query);
            Context.Response.ContentType = "application/json; charset=utf-8";
            Context.Response.Write(JsonConvert.SerializeObject(possibleResponses));
        }

        public IEnumerable<User> Get(string query, int limit = 10)
        {
            var result = new List<User>();
            var sqlQuery = string.Format("SELECT TOP {0} [UserId],[FullName] FROM {1} WHERE FullName LIKE @Query;", limit, DatabaseHelper.UserTable);

            using (var sqlConnection = new SqlConnection(DatabaseHelper.ConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@Query", "%" + query + "%");
                sqlConnection.Open();
                var dataReader = sqlCommand.ExecuteReader();
                if (!dataReader.HasRows) return result;
                while (dataReader.Read())
                {
                    var user = new User
                    {
                        Id = Convert.ToInt32(dataReader["UserId"]),
                        FullName = dataReader["FullName"] as string
                    };
                    result.Add(user);
                }
                sqlConnection.Close();
            }
            return result;
        }
    }

    public class User
    {
        public int Id { get; set; }
        public string FullName { get; set; }
    }
}
