using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BiRequestWeb.BIRequest
{
    public partial class BiRequestView : Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(IsPostBack) return;

            int requestId;
            if (!int.TryParse(Page.RouteData.Values["id"] as string, out requestId)) return;

            GetById(requestId);
            tblAttachments.CssClass = "table table-condensed";
            var x = GetAttachments(requestId);
            foreach (var attachment in GetAttachments(requestId))
            {
                var row = new TableRow();
                var cell = new TableCell {Text = attachment.FileName};
                row.Cells.Add(cell);
                tblAttachments.Rows.Add(row);
            }
        }

        static IEnumerable<Control> FindControls(Control c, Func<Control, bool> predicate)
        {
            if (predicate(c))
                yield return c;

            foreach (var child in c.Controls.Cast<object>().Where(child => predicate((Control)child)))
                yield return (Control)child;

            foreach (var match in c.Controls.Cast<object>().SelectMany(child => FindControls((Control)child, predicate)))
                yield return match;
        }

        private static string ParseDate(DateTime? dateTime)
        {
            return dateTime?.ToShortDateString() ?? string.Empty;
        }

        private static int ParseInteger(int? integer)
        {
            return integer ?? 0;
        }

        protected void GetById(int id)
        {
            string sqlQuery = string.Format("SELECT * FROM {0} INNER JOIN {1} ON {0}.RequestTypeId = {1}.Id WHERE {0}.Id=@Id;", DatabaseHelper.BiRequestTable, DatabaseHelper.BiRequestTypeTable);

            using (var sqlConnection = new SqlConnection(DatabaseHelper.BIRequestConnectionString))
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
                    requestType.Text = dataReader["RequestTypeLabel"] as string;
                    natureOfRequest.Text = dataReader["RequestNature"] as string;
                    informationRequired.Text = dataReader["InformationRequired"] as string;
                    parametersRequired.Text = dataReader["ParametersRequired"] as string;
                    groupingRequirements.Text = dataReader["GroupingRequirments"] as string;
                    peopleToShare.Text = dataReader["PeopleToShare"] as string;
                    additionalComments.Text = dataReader["AdditionalComments"] as string;
                }
                sqlConnection.Close();
            }
        }

        private static IEnumerable<Attachment> GetAttachments(int requestId)
        {
            var attachments = new List<Attachment>();
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
                    attachments.Add(new Attachment
                    {
                        AttatchmentId = ParseInteger(dataReader["Id"] as int?),
                        FileName = dataReader["FileName"] as string
                    });
                }
                sqlConnection.Close();
            }
            return attachments;
        }
    }

    class Attachment
    {
        public int AttatchmentId { get; set; }
        public string FileName { get; set; }
    }
}