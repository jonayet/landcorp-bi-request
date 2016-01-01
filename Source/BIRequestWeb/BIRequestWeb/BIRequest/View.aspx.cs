using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using BiRequestWeb.DAL;
using BiRequestWeb.Entities;

namespace BiRequestWeb.BIRequest
{
    public partial class BiRequestView : Page
    {
        private Repository _repo;
        protected void Page_Init(object sender, EventArgs e)
        {
            _repo = new Repository();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(IsPostBack) return;

            int requestId;
            if (!int.TryParse(Page.RouteData.Values["id"] as string, out requestId)) return;

            UpdateRequestFormView(_repo.GetRequestForm(requestId));
            tblAttachments.CssClass = "table table-condensed";
            foreach (var attachment in _repo.GetAttachments(requestId))
            {
                var row = new TableRow();
                var cell = new TableCell {Text = attachment.FileName};
                row.Cells.Add(cell);
                tblAttachments.Rows.Add(row);
            }
        }

        private void UpdateRequestFormView(RequestForm requestForm)
        {
            requestorName.Text = requestForm.RequestorName;
            dateRequested.Text = DataTransformer.ConvertDateToString(requestForm.DateRequested);
            dateRequired.Text = DataTransformer.ConvertDateToString(requestForm.DateRequired);
            executiveSponsor.Text = requestForm.ExecutiveSponsor;
            requestName.Text = requestForm.RequestName;
            requestType.Text = requestForm.RequestTypeLabel;
            natureOfRequest.Text = requestForm.RequestNature;
            informationRequired.Text = requestForm.InformationRequired;
            parametersRequired.Text = requestForm.ParametersRequired;
            groupingRequirements.Text = requestForm.GroupingRequirements;
            peopleToShare.Text = requestForm.PeopleToShare;
            comments.Text = requestForm.Comments;
            dateReviewed.Text = DataTransformer.ConvertDateToString(requestForm.DateReviewed);
            estimatedHours.Text = requestForm.EstimatedHours.ToString();
            businessCaseID.Text = requestForm.BusinessCaseId;
            approvalComments.Text = requestForm.ApprovalComments;
        }
    }
}