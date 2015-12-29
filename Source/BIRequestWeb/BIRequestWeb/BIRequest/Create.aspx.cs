using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace BiRequestWeb.BIRequest
{
    public partial class BiRequest : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            requestType.Items.AddRange(GetBiRequestTypes());
            requestType.Items[0].Selected = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Insert();
            }
        }

        private static object ParseDate(string dateTime)
        {
            if (string.IsNullOrWhiteSpace(dateTime)) return DBNull.Value;
            DateTime dt;
            return DateTime.TryParse(dateTime, out dt) ? dt.ToString("yyyy-MM-dd") : (object)DBNull.Value;
        }

        private static object ParseText(string text)
        {
            return !string.IsNullOrWhiteSpace(text) ? text : (object)DBNull.Value;
        }

        private static object ParseInteger(string integer)
        {
            int i;
            return int.TryParse(integer, out i) ? i : (object) DBNull.Value;
        }

        public ListItem[] GetBiRequestTypes()
        {
            var result = new List<ListItem>();
            string sqlQuery = string.Format("SELECT * FROM {0};", DatabaseHelper.BiRequestTypeTable);

            using (var sqlConnection = new SqlConnection(DatabaseHelper.BIRequestConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlConnection.Open();
                var dataReader = sqlCommand.ExecuteReader();
                if (!dataReader.HasRows) return result.ToArray();
                while (dataReader.Read())
                {
                    var biRequest = new ListItem
                    {
                        Value = Convert.ToInt32(dataReader["RequestTypeId"]).ToString(),
                        Text = dataReader["RequestTypeTitle"] as string
                    };
                    result.Add(biRequest);
                }
                sqlConnection.Close();
            }
            return result.ToArray();
        }

        private int Insert()
        {
            int createdItemId;
            var sqlQuery = string.Format("INSERT INTO {0} (RequestorName, RequestorId, DateRequested, DateRequired, ExecutiveSponsor, ExecutiveSponsorId, RequestName, RequestType, RequestNature, InformationRequired, ParametersRequired, GroupingRequirments, PeopleToShare, AdditionalComments, DateReviewed, EstimatedHours, BusinessCaseId, Comments, ApprovalStatus) " +
                                       "VALUES (@RequestorName, @RequestorId, @DateRequested, @DateRequired, @ExecutiveSponsor, @ExecutiveSponsorId, @RequestName, @RequestType, @RequestNature, @InformationRequired, @ParametersRequired, @GroupingRequirments, @PeopleToShare, @AdditionalComments, @DateReviewed, @EstimatedHours, @BusinessCaseId, @Comments, @ApprovalStatus);", DatabaseHelper.BiRequestTable);

            using (var sqlConnection = new SqlConnection(DatabaseHelper.BIRequestConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@RequestorId", ParseText(requestorId.Value));
                sqlCommand.Parameters.AddWithValue("@RequestorName", ParseText(requestor.Text));
                sqlCommand.Parameters.AddWithValue("@DateRequested", ParseDate(dateRequested.Text));
                sqlCommand.Parameters.AddWithValue("@DateRequired", ParseDate(dateRequired.Text));
                sqlCommand.Parameters.AddWithValue("@ExecutiveSponsorId", ParseText(executiveSponsorId.Value));
                sqlCommand.Parameters.AddWithValue("@ExecutiveSponsor", ParseText(executiveSponsor.Text));
                sqlCommand.Parameters.AddWithValue("@RequestName", ParseText(requestName.Text));
                sqlCommand.Parameters.AddWithValue("@RequestType", ParseInteger(requestType.SelectedValue));
                sqlCommand.Parameters.AddWithValue("@RequestNature", ParseText(natureOfRequest.Text));
                sqlCommand.Parameters.AddWithValue("@InformationRequired", ParseText(informationRequired.Text));
                sqlCommand.Parameters.AddWithValue("@ParametersRequired", ParseText(parametersRequired.Text));
                sqlCommand.Parameters.AddWithValue("@GroupingRequirments", ParseText(groupingRequirements.Text));
                sqlCommand.Parameters.AddWithValue("@PeopleToShare", ParseText(peopleToShare.Text));
                sqlCommand.Parameters.AddWithValue("@AdditionalComments", ParseText(additionalComments.Text));
                sqlCommand.Parameters.AddWithValue("@DateReviewed", ParseDate(dateReviewed.Text));
                sqlCommand.Parameters.AddWithValue("@EstimatedHours", ParseText(estimatedHours.Text));
                sqlCommand.Parameters.AddWithValue("@BusinessCaseId", ParseText(businessCaseID.Text));
                sqlCommand.Parameters.AddWithValue("@Comments", ParseText(internalComments.Text));
                sqlCommand.Parameters.AddWithValue("@ApprovalStatus", DBNull.Value);

                sqlConnection.Open();
                createdItemId = Convert.ToInt32(sqlCommand.ExecuteScalar());
                sqlConnection.Close();
            }
            return createdItemId;
        }
    }
}