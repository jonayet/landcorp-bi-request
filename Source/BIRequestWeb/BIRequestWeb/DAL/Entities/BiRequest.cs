using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace BIRequestWeb.DAL.Entities
{
    public class BiRequest
    {
        public int Id { get; set; }
        public string RequestorName { get; set; }
        public DateTime? DateRequested { get; set; }
        public DateTime? DateRequired { get; set; }
        public string ExecutiveSponsor { get; set; }
        public string RequestName { get; set; }
        public int? RequestType { get; set; }
        public string RequestNature { get; set; }
        public string InformationRequired { get; set; }
        public string ParametersRequired { get; set; }
        public string GroupingRequirments { get; set; }
        public string PeopleToShare { get; set; }
        public string AdditionalComments { get; set; }
        public DateTime? DateReviewed { get; set; }
        public int? EstimatedHours { get; set; }
        public int? BusinessCaseId { get; set; }
        public string Comments { get; set; }
        public int? ApprovalStatus { get; set; }

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
