using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.WebControls;
using BiRequestWeb.Entities;

namespace BiRequestWeb.DAL
{
    public class Repository
    {
        public int InsertRequestForm(RequestForm requestForm)
        {
            int createdItemId;
            var sqlQuery = string.Format("INSERT INTO {0} (RequestorName, RequestorId, DateRequested, DateRequired, ExecutiveSponsor, ExecutiveSponsorId, RequestName, RequestTypeId, RequestNature, InformationRequired, ParametersRequired, GroupingRequirements, PeopleToShare, Comments, DateReviewed, EstimatedHours, BusinessCaseId, ApprovalComments, CreatedOn) " +
                                       "VALUES (@RequestorName, @RequestorId, @DateRequested, @DateRequired, @ExecutiveSponsor, @ExecutiveSponsorId, @RequestName, @RequestTypeId, @RequestNature, @InformationRequired, @ParametersRequired, @GroupingRequirements, @PeopleToShare, @Comments, @DateReviewed, @EstimatedHours, @BusinessCaseId, @ApprovalComments, @CreatedOn); SELECT SCOPE_IDENTITY();", DatabaseHelper.BiRequestTable);

            using (var sqlConnection = new SqlConnection(DatabaseHelper.BIRequestConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@RequestorId", (object)requestForm.RequestorId ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@RequestorName", (object)requestForm.RequestorName ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@DateRequested", DataTransformer.ConvertDateToIso8601(requestForm.DateRequested) ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@DateRequired", DataTransformer.ConvertDateToIso8601(requestForm.DateRequired) ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@ExecutiveSponsorId", (object)requestForm.ExecutiveSponsorId ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@ExecutiveSponsor", (object)requestForm.ExecutiveSponsor ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@RequestName", (object)requestForm.RequestName ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@RequestTypeId", (object)requestForm.RequestTypeId ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@RequestNature", (object)requestForm.RequestNature ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@InformationRequired", (object)requestForm.InformationRequired ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@ParametersRequired", (object)requestForm.ParametersRequired ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@GroupingRequirements", (object)requestForm.GroupingRequirements ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@PeopleToShare", (object)requestForm.PeopleToShare ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@Comments", (object)requestForm.Comments ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@DateReviewed", DataTransformer.ConvertDateToIso8601(requestForm.DateReviewed) ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@EstimatedHours", (object)requestForm.EstimatedHours ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@BusinessCaseId", (object)requestForm.BusinessCaseId ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@ApprovalComments", (object)requestForm.ApprovalComments ?? DBNull.Value);
                sqlCommand.Parameters.AddWithValue("@CreatedOn", DateTime.Now);

                sqlConnection.Open();
                createdItemId = Convert.ToInt32(sqlCommand.ExecuteScalar());
                sqlConnection.Close();
            }
            return createdItemId;
        }

        public int InsertAttachment(AttachmentFile attachment)
        {
            int createdItemId;
            var sqlQuery = string.Format("INSERT INTO {0} (RequestId, FileName, ContentType, ContentLength, FileContent, CreatedOn) " +
                                       "VALUES (@RequestId, @FileName, @ContentType, @ContentLength, @FileContent, @CreatedOn); SELECT SCOPE_IDENTITY();", DatabaseHelper.AttachmentTable);

            using (var sqlConnection = new SqlConnection(DatabaseHelper.BIRequestConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@RequestId", attachment.RequestId);
                sqlCommand.Parameters.AddWithValue("@FileName", attachment.FileName);
                sqlCommand.Parameters.AddWithValue("@ContentType", attachment.ContentType);
                sqlCommand.Parameters.AddWithValue("@ContentLength", attachment.ContentLength);
                sqlCommand.Parameters.AddWithValue("@FileContent", attachment.FileContent);
                sqlCommand.Parameters.AddWithValue("@CreatedOn", DateTime.Now);
                sqlConnection.Open();
                createdItemId = Convert.ToInt32(sqlCommand.ExecuteScalar());
                sqlConnection.Close();
            }
            return createdItemId;
        }

        public RequestForm GetRequestForm(int requestId)
        {
            var sqlQuery = string.Format("SELECT * FROM {0} INNER JOIN {1} ON {0}.RequestTypeId = {1}.Id WHERE {0}.Id=@Id;", DatabaseHelper.BiRequestTable, DatabaseHelper.BiRequestTypeTable);
            var requestForm = new RequestForm();

            using (var sqlConnection = new SqlConnection(DatabaseHelper.BIRequestConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@Id", requestId);
                sqlConnection.Open();

                var dataReader = sqlCommand.ExecuteReader();
                if (!dataReader.HasRows) return requestForm;
                if (dataReader.Read())
                {
                    requestForm.Id = DataTransformer.ParseNullableLong(dataReader["Id"] as long?);
                    requestForm.RequestorId = dataReader["RequestorId"] as int?;
                    requestForm.RequestorName = dataReader["RequestorName"] as string;
                    requestForm.DateRequested = dataReader["DateRequested"] as DateTime?;
                    requestForm.DateRequired = dataReader["DateRequired"] as DateTime?;
                    requestForm.ExecutiveSponsorId = dataReader["ExecutiveSponsorId"] as int?;
                    requestForm.ExecutiveSponsor = dataReader["ExecutiveSponsor"] as string;
                    requestForm.RequestName = dataReader["RequestName"] as string;
                    requestForm.RequestTypeId = dataReader["RequestTypeId"] as int?;
                    requestForm.RequestTypeLabel = dataReader["RequestTypeLabel"] as string;
                    requestForm.RequestNature = dataReader["RequestNature"] as string;
                    requestForm.InformationRequired = dataReader["InformationRequired"] as string;
                    requestForm.ParametersRequired = dataReader["ParametersRequired"] as string;
                    requestForm.GroupingRequirements = dataReader["GroupingRequirements"] as string;
                    requestForm.PeopleToShare = dataReader["PeopleToShare"] as string;
                    requestForm.Comments = dataReader["Comments"] as string;
                    requestForm.DateReviewed = dataReader["DateReviewed"] as DateTime?;
                    requestForm.EstimatedHours = dataReader["EstimatedHours"] as int?;
                    requestForm.BusinessCaseId = dataReader["BusinessCaseId"] as string;
                    requestForm.ApprovalComments = dataReader["ApprovalComments"] as string;
                }
                sqlConnection.Close();
            }
            return requestForm;
        }

        public IEnumerable<AttachmentFile> GetAttachments(int requestId)
        {
            var attachments = new List<AttachmentFile>();
            var sqlQuery = string.Format("SELECT [Id], [FileName] FROM {0} WHERE RequestId=@RequestId;", DatabaseHelper.AttachmentTable);
            using (var sqlConnection = new SqlConnection(DatabaseHelper.BIRequestConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@RequestId", requestId);
                sqlConnection.Open();
                var dataReader = sqlCommand.ExecuteReader();
                if (!dataReader.HasRows) return attachments;
                while (dataReader.Read())
                {
                    attachments.Add(new AttachmentFile
                    {
                        Id = DataTransformer.ParseNullableLong(dataReader["Id"] as long?),
                        FileName = dataReader["FileName"] as string
                    });
                }
                sqlConnection.Close();
            }
            return attachments;
        }

        public AttachmentFile GetAttachment(int attachmentId)
        {
            AttachmentFile attachmentFile = new AttachmentFile();
            var sqlQuery = string.Format("SELECT * FROM {0} WHERE Id=@Id;", DatabaseHelper.AttachmentTable);
            using (var sqlConnection = new SqlConnection(DatabaseHelper.BIRequestConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@Id", attachmentId);
                sqlConnection.Open();
                var dataReader = sqlCommand.ExecuteReader();
                if (!dataReader.HasRows) return attachmentFile;
                if(dataReader.Read())
                {
                    attachmentFile.Id = DataTransformer.ParseNullableLong(dataReader["Id"] as long?);
                    attachmentFile.RequestId = dataReader["RequestId"] as long?;
                    attachmentFile.FileName = dataReader["FileName"] as string;
                    attachmentFile.ContentType = dataReader["ContentType"] as string;
                    attachmentFile.ContentLength = dataReader["ContentLength"] as long?;
                    attachmentFile.FileContent = dataReader["FileContent"] as byte[];
                }
                sqlConnection.Close();
            }
            return attachmentFile;
        }

        public void UpdateRequestForm(int id, RequestForm requestForm)
        {
            var request = requestForm.ToDictionary();

            using (var sqlConnection = new SqlConnection(DatabaseHelper.BIRequestConnectionString))
            using (var sqlCommand = new SqlCommand())
            {
                var sqlQuery = string.Format("UPDATE {0} SET ", DatabaseHelper.BiRequestTable);
                foreach (var property in request.Where(p => p.Value != null).Where(p => p.Key != "Id"))
                {
                    object value;
                    if (property.Value is DateTime)
                        value = DataTransformer.ConvertDateToIso8601(property.Value as DateTime?);
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
                sqlCommand.ExecuteNonQuery();
                sqlConnection.Close();
            }
        }

        public ListItem[] GetBiRequestTypes()
        {
            var result = new List<ListItem>();
            var sqlQuery = string.Format("SELECT * FROM {0};", DatabaseHelper.BiRequestTypeTable);

            using (var sqlConnection = new SqlConnection(DatabaseHelper.BIRequestConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlConnection.Open();
                var dataReader = sqlCommand.ExecuteReader();
                if (!dataReader.HasRows) return result.ToArray();
                while (dataReader.Read())
                {
                    var requestType = new ListItem
                    {
                        Value = Convert.ToInt32(dataReader["Id"]).ToString(),
                        Text = dataReader["RequestTypeLabel"] as string
                    };
                    result.Add(requestType);
                }
                sqlConnection.Close();
            }
            return result.ToArray();
        }

        public IEnumerable<User> GetUser(string query, int limit = 10)
        {
            var result = new List<User>();
            var sqlQuery = string.Format("SELECT TOP {0} [UserId],[FullName] FROM {1} WHERE FullName LIKE @Query;", limit, DatabaseHelper.AdminUserTable);

            using (var sqlConnection = new SqlConnection(DatabaseHelper.AdminConnectionString))
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
}