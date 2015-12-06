using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using BIRequestWeb.DAL.Entities;

namespace BIRequestWeb.DAL
{
    public class BiRequestTransformer
    {
        public BiRequest ToEntity(Models.BiRequest biRequest)
        {
            return new BiRequest
            {
                RequestorName = biRequest.RequestorName,
                DateRequested = biRequest.DateRequested,
                DateRequired = biRequest.DateRequired,
                ExecutiveSponsor = biRequest.ExecutiveSponsor,
                RequestName = biRequest.RequestName,
                RequestType = biRequest.RequestType,
                RequestNature = biRequest.RequestNature,
                InformationRequired = biRequest.InformationRequired,
                ParametersRequired = biRequest.ParametersRequired,
                GroupingRequirments = biRequest.GroupingRequirments,
                PeopleToShare = biRequest.PeopleToShare,
                AdditionalComments = biRequest.AdditionalComments,
                DateReviewed = biRequest.DateReviewed,
                EstimatedHours = biRequest.EstimatedHours,
                BusinessCaseId = biRequest.BusinessCaseId,
                Comments = biRequest.Comments,
                ApprovalStatus = biRequest.ApprovalStatus,
            };
        }

        public Models.BiRequest ToModel(BiRequest biRequest)
        {
            return new Models.BiRequest
            {
                Id = biRequest.Id,
                RequestorName = biRequest.RequestorName,
                DateRequested = biRequest.DateRequested,
                DateRequired = biRequest.DateRequired,
                ExecutiveSponsor = biRequest.ExecutiveSponsor,
                RequestName = biRequest.RequestName,
                RequestType = biRequest.RequestType,
                RequestNature = biRequest.RequestNature,
                InformationRequired = biRequest.InformationRequired,
                ParametersRequired = biRequest.ParametersRequired,
                GroupingRequirments = biRequest.GroupingRequirments,
                PeopleToShare = biRequest.PeopleToShare,
                AdditionalComments = biRequest.AdditionalComments,
                DateReviewed = biRequest.DateReviewed,
                EstimatedHours = biRequest.EstimatedHours,
                BusinessCaseId = biRequest.BusinessCaseId,
                Comments = biRequest.Comments,
                ApprovalStatus = biRequest.ApprovalStatus,
            };
        }

        public IEnumerable<Models.BiRequest> ToModels(IEnumerable<BiRequest> biRequests)
        {
            return biRequests.Select(ToModel).ToList();
        }
    }
}