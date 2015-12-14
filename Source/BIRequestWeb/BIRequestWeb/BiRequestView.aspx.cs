using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace BiRequestWeb
{
    public partial class BiRequestView : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            foreach (Control ctrl in Page.Controls)
                DisableControls(ctrl);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            int id;
            if (int.TryParse(Request.QueryString["id"], out id))
                GetById(id);
        }

        private static void DisableControls(Control ctrl)
        {
            (ctrl as WebControl)?.Attributes.Add("disabled", "");
            foreach (Control child in ctrl.Controls)
                DisableControls(child);
        }

        private static string ParseDate(DateTime? dateTime)
        {
            return dateTime?.ToShortDateString() ?? string.Empty;
        }

        private static string ParseInteger(int? integer)
        {
            return integer?.ToString() ?? string.Empty;
        }

        protected void GetById(int id)
        {
            const string sqlQuery = "SELECT * FROM dbo.AppBiRequest WHERE Id=@Id;";

            using (var sqlConnection = new SqlConnection(DatabaseHelper.ConnectionString))
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                sqlCommand.Parameters.AddWithValue("@Id", id);
                sqlConnection.Open();

                var dataReader = sqlCommand.ExecuteReader();
                if (!dataReader.HasRows) return;
                if (dataReader.Read())
                {
                    nameOfRequestor.Text = dataReader["RequestorName"] as string;
                    dateRequested.Text = ParseDate(dataReader["DateRequested"] as DateTime?);
                    dateRequired.Text = ParseDate(dataReader["DateRequired"] as DateTime?);
                    executiveSponsor.Text = dataReader["ExecutiveSponsor"] as string;
                    requestName.Text = dataReader["RequestName"] as string;
                    requestType.Text = ParseInteger(dataReader["RequestType"] as int?);
                    natureOfRequest.Text = dataReader["RequestNature"] as string;
                    informationRequired.Text = dataReader["InformationRequired"] as string;
                    parametersRequired.Text = dataReader["ParametersRequired"] as string;
                    groupingRequirements.Text = dataReader["GroupingRequirments"] as string;
                    peopleToShare.Text = dataReader["PeopleToShare"] as string;
                    additionalComments.Text = dataReader["AdditionalComments"] as string;
                    dateReviewed.Text = ParseDate(dataReader["DateReviewed"] as DateTime?);
                    estimatedHours.Text = ParseInteger(dataReader["EstimatedHours"] as int?);
                    businessCaseID.Text = ParseInteger(dataReader["BusinessCaseId"] as int?);
                    internalComments.Text = dataReader["Comments"] as string;
                }
                sqlConnection.Close();
            }
        }
    }
}