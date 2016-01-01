using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;

namespace BiRequestWeb.Entities
{
    public class RequestForm
    {
        public long Id { get; set; }
        public int? RequestorId { get; set; }
        public string RequestorName { get; set; }
        public DateTime? DateRequested { get; set; }
        public DateTime? DateRequired { get; set; }
        public int? ExecutiveSponsorId { get; set; }
        public string ExecutiveSponsor { get; set; }
        public string RequestName { get; set; }
        public int? RequestTypeId { get; set; }
        public string RequestTypeLabel { get; set; }
        public string RequestNature { get; set; }
        public string InformationRequired { get; set; }
        public string ParametersRequired { get; set; }
        public string GroupingRequirements { get; set; }
        public string PeopleToShare { get; set; }
        public string Comments { get; set; }
        public DateTime? DateReviewed { get; set; }
        public int? EstimatedHours { get; set; }
        public string BusinessCaseId { get; set; }
        public string ApprovalComments { get; set; }
        public DateTime? CreatedOn { get; set; }

        public Dictionary<string, object> ToDictionary()
        {
            return GetType().GetProperties(BindingFlags.DeclaredOnly | BindingFlags.Public | BindingFlags.Instance).ToDictionary
                (
                    propInfo => propInfo.Name,
                    propInfo => propInfo.GetValue(this, null)
                );
        }
    }
}