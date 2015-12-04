using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using BIRequestWeb.DAL.Entities;
using Microsoft.Ajax.Utilities;
using WebGrease.Css.Extensions;

namespace BIRequestWeb.DAL
{
    public class Repository
    {
        public int Insert(BiRequest biRequest)
        {
            int createdItemId;
            const string sqlQuery = "INSERT INTO dbo.AppBiRequest (RequestorName, DateRequested, DateRequired, ExecutiveSponsor, RequestName, RequestType, RequestNature, InformationRequired, ParametersRequired, GroupingRequirments, PeopleToShare, AdditionalComments, DateReviewed, EstimatedHours, BusinessCaseId, Comments, ApprovalStatus) " +
                                       "VALUES (@RequestorName, @DateRequested, @DateRequired, @ExecutiveSponsor, @RequestName, @RequestType, @RequestNature, @InformationRequired, @ParametersRequired, @GroupingRequirments, @PeopleToShare, @AdditionalComments, @DateReviewed, @EstimatedHours, @BusinessCaseId, @Comments, @ApprovalStatus);";

            using (var sqlConnection = new SqlConnection(DatabaseHelper.ConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@RequestorName", (object) biRequest.RequestorName ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@DateRequested", biRequest.DateRequested?.ToString("yyyy-MM-dd"));
                sqlCommand.Parameters.AddWithValue("@DateRequired", biRequest.DateRequired?.ToString("yyyy-MM-dd"));
                sqlCommand.Parameters.AddWithValue("@ExecutiveSponsor", (object) biRequest.ExecutiveSponsor ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@RequestName", (object) biRequest.RequestName ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@RequestType", biRequest.RequestType);
                sqlCommand.Parameters.AddWithValue("@RequestNature", (object) biRequest.RequestNature ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@InformationRequired", (object) biRequest.InformationRequired ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@ParametersRequired", (object) biRequest.ParametersRequired ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@GroupingRequirments", (object) biRequest.GroupingRequirments ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@PeopleToShare", (object) biRequest.PeopleToShare  ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@AdditionalComments", (object) biRequest.AdditionalComments ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@DateReviewed", (object) biRequest.DateReviewed?.ToString("yyyy-MM-dd") ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@EstimatedHours", (object) biRequest.EstimatedHours ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@BusinessCaseId", (object) biRequest.BusinessCaseId ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@Comments", (object) biRequest.Comments ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@ApprovalStatus", (object) biRequest.ApprovalStatus ?? DBNull.Value);

                sqlConnection.Open();
                createdItemId = Convert.ToInt32(sqlCommand.ExecuteScalar());
                sqlConnection.Close();
            }
            return createdItemId;
        }
        
        public IEnumerable<BiRequest> Get()
        {
            var result = new List<BiRequest>();
            const string sqlQuery = "SELECT * FROM dbo.AppBiRequest;";

            using (var sqlConnection = new SqlConnection(DatabaseHelper.ConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlConnection.Open();
                var dataReader = sqlCommand.ExecuteReader();
                if (!dataReader.HasRows) return result;
                while (dataReader.Read())
                {
                    var biRequest = new BiRequest
                    {
                        Id = Convert.ToInt32(dataReader["Id"]),
                        RequestorName = dataReader["RequestorName"] as string,
                        DateRequested = dataReader["DateRequested"] as DateTime? ?? default(DateTime),
                        DateRequired = dataReader["DateRequired"] as DateTime? ?? default(DateTime),
                        ExecutiveSponsor = dataReader["ExecutiveSponsor"] as string,
                        RequestName = dataReader["RequestName"] as string,
                        RequestType = dataReader["RequestType"] as int? ?? default(int),
                        RequestNature = dataReader["RequestNature"] as string,
                        InformationRequired = dataReader["InformationRequired"] as string,
                        ParametersRequired = dataReader["ParametersRequired"] as string,
                        GroupingRequirments = dataReader["GroupingRequirments"] as string,
                        PeopleToShare = dataReader["PeopleToShare"] as string,
                        AdditionalComments = dataReader["AdditionalComments"] as string,
                        DateReviewed = dataReader["DateReviewed"] as DateTime?,
                        EstimatedHours = dataReader["EstimatedHours"] as int?,
                        BusinessCaseId = dataReader["BusinessCaseId"] as int?,
                        Comments = dataReader["Comments"] as string,
                        ApprovalStatus = dataReader["ApprovalStatus"] as int?
                    };
                    result.Add(biRequest);
                }
                sqlConnection.Close();
            }
            return result;
        }

        public BiRequest GetById(int id)
        {
            var result = new BiRequest();
            const string sqlQuery = "SELECT * FROM dbo.AppBiRequest WHERE Id=@Id;";

            using (var sqlConnection = new SqlConnection(DatabaseHelper.ConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@Id", id);
                sqlConnection.Open();

                var dataReader = sqlCommand.ExecuteReader();
                if (!dataReader.HasRows) return result;
                if (dataReader.Read())
                {
                    result = new BiRequest
                    {
                        Id = Convert.ToInt32(dataReader["Id"]),
                        RequestorName = dataReader["RequestorName"] as string,
                        DateRequested = dataReader["DateRequested"] as DateTime? ?? default(DateTime),
                        DateRequired = dataReader["DateRequired"] as DateTime? ?? default(DateTime),
                        ExecutiveSponsor = dataReader["ExecutiveSponsor"] as string,
                        RequestName = dataReader["RequestName"] as string,
                        RequestType = dataReader["RequestType"] as int?,
                        RequestNature = dataReader["RequestNature"] as string,
                        InformationRequired = dataReader["InformationRequired"] as string,
                        ParametersRequired = dataReader["ParametersRequired"] as string,
                        GroupingRequirments = dataReader["GroupingRequirments"] as string,
                        PeopleToShare = dataReader["PeopleToShare"] as string,
                        AdditionalComments = dataReader["AdditionalComments"] as string,
                        DateReviewed = dataReader["DateReviewed"] as DateTime?,
                        EstimatedHours = dataReader["EstimatedHours"] as int?,
                        BusinessCaseId = dataReader["BusinessCaseId"] as int?,
                        Comments = dataReader["Comments"] as string,
                        ApprovalStatus = dataReader["ApprovalStatus"] as int?
                    };
                }
                sqlConnection.Close();
            }
            return result;
        }
        
        public int Update(int id, BiRequest biRequest)
        {
            int updatedItemId;
            Dictionary<string, object> request = biRequest.ToDictionary();
            
            using (var sqlConnection = new SqlConnection(DatabaseHelper.ConnectionString))
            using (var sqlCommand = new SqlCommand())
            {
                string sqlQuery = "UPDATE dbo.AppBiRequest SET ";
                foreach (KeyValuePair<string, object> property in request.Where(p => p.Value != null).Where(p => p.Key != "Id"))
                {
                    object value;
                    if (property.Value is DateTime)
                        value = Convert.ToDateTime(property.Value).ToString("yyyy-MM-dd");
                    else
                        value = property.Value;

                    var parameter = "@" + property.Key;
                    sqlQuery += property.Key + "=" + parameter + ",";
                    sqlCommand.Parameters.AddWithValue(parameter, value);
                }
                sqlQuery = sqlQuery.Remove(sqlQuery.Length - 1) + " WHERE Id=@Id;";
                sqlCommand.Parameters.AddWithValue("@Id", id);

                sqlCommand.CommandText = sqlQuery;
                sqlCommand.Connection = sqlConnection;
                sqlConnection.Open();
                updatedItemId = Convert.ToInt32(sqlCommand.ExecuteScalar());
                sqlConnection.Close();
            }
            return updatedItemId;
        }

        public bool Delete(int id)
        {
            int rowsAffected;
            const string sqlQuery = "DELETE FROM dbo.AppBiRequest where Id=@Id";

            using (var sqlConnection = new SqlConnection(DatabaseHelper.ConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@Id", id);
                sqlConnection.Open();
                rowsAffected = sqlCommand.ExecuteNonQuery();
                sqlConnection.Close();
            }
            return rowsAffected > 0;
        }
    }
}