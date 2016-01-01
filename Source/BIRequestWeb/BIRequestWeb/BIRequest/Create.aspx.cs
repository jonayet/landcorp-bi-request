using System;
using BiRequestWeb.DAL;
using BiRequestWeb.Entities;

namespace BiRequestWeb.BIRequest
{
    public partial class BiRequest : System.Web.UI.Page
    {
        private Repository _repo;
        protected void Page_Init(object sender, EventArgs e)
        {
            _repo = new Repository();
            requestType.Items.AddRange(_repo.GetBiRequestTypes());
            requestType.Items[0].Selected = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) return;
            var requestId = _repo.InsertRequestForm(GetRequestFormData());
            SaveAttachments(requestId);
        }

        private void SaveAttachments(int requestId)
        {
            var files = Request.Files;
            for (var i = 0; i < files.Count; i++)
            {
                var file = files[i];
                if (file.ContentLength <= 0) continue;
                var fileContent = new byte[file.ContentLength];
                file.InputStream.Read(fileContent, 0, file.ContentLength);
                _repo.InsertAttachment(new AttachmentFile
                {
                    RequestId = requestId,
                    FileName = file.FileName,
                    ContentType = file.ContentType,
                    ContentLength = file.ContentLength,
                    FileContent = fileContent,
                });
            }
        }

        private RequestForm GetRequestFormData()
        {
            return new RequestForm
            {
                RequestorId = DataTransformer.ParseIntString(requestorId.Value),
                RequestorName = DataTransformer.ParseText(requestor.Text),
                DateRequested = DataTransformer.ParseDateString(dateRequested.Text),
                DateRequired = DataTransformer.ParseDateString(dateRequired.Text),
                ExecutiveSponsorId = DataTransformer.ParseIntString(executiveSponsorId.Value),
                ExecutiveSponsor = DataTransformer.ParseText(executiveSponsor.Text),
                RequestName = DataTransformer.ParseText(requestName.Text),
                RequestTypeId = DataTransformer.ParseIntString(requestType.SelectedValue),
                RequestNature = DataTransformer.ParseText(natureOfRequest.Text),
                InformationRequired = DataTransformer.ParseText(informationRequired.Text),
                ParametersRequired = DataTransformer.ParseText(parametersRequired.Text),
                GroupingRequirements = DataTransformer.ParseText(groupingRequirements.Text),
                PeopleToShare = DataTransformer.ParseText(peopleToShare.Text),
                Comments = DataTransformer.ParseText(comments.Text),
                DateReviewed = DataTransformer.ParseDateString(dateReviewed.Text),
                EstimatedHours = DataTransformer.ParseIntString(estimatedHours.Text),
                BusinessCaseId = DataTransformer.ParseText(businessCaseID.Text),
                ApprovalComments = DataTransformer.ParseText(approvalComments.Text)
            };
        }
    }
}