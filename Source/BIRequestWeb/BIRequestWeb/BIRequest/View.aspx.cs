using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace BiRequestWeb.BIRequest
{
    public partial class BiRequestView : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(IsPostBack) return;

            int id;
            if (int.TryParse(Page.RouteData.Values["id"] as string, out id))
                GetById(id);

            natureOfRequest.Text = Page.RouteData.Values.ContainsKey("role") ? Page.RouteData.Values["role"] as string : "";
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

        private static string ParseInteger(int? integer)
        {
            return integer?.ToString() ?? string.Empty;
        }

        protected void GetById(int id)
        {
            string sqlQuery = string.Format("SELECT * FROM {0} INNER JOIN {1} ON {0}.RequestType = {1}.RequestTypeId WHERE {0}.RequestId=@Id;", DatabaseHelper.BiRequestTable, DatabaseHelper.BiRequestTypeTable);

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
                    requestType.Text = dataReader["RequestTypeTitle"] as string;
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
    }
}