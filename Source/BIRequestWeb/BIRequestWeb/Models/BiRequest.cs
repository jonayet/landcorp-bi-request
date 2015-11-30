using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace BIRequestWeb.Models
{
    public class BiRequest
    {
        [ScaffoldColumn(false)]
        public int Id { get; set; }

        [Required(ErrorMessage = "Name of Requestor is required")]
        [StringLength(50, MinimumLength = 2)]
        [Display(Name = "Name of Requestor")]
        public string RequestorName { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Date Requested")]
        public DateTime DateRequested { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Date Required")]
        public DateTime DateRequired { get; set; }

        [StringLength(50)]
        [Display(Name = "Executive Sponsor")]
        public string ExecutiveSponsor { get; set; }

        [Required(ErrorMessage = "Request Name is required")]
        [StringLength(50, MinimumLength = 2)]
        [Display(Name = "Request Name")]
        public string RequestName { get; set; }
    
        [Required(ErrorMessage = "Request Type is required")]
        [Display(Name = "Request Type")]
        public int RequestType { get; set; }
        public IEnumerable<SelectListItem> RequestTypes { set; get; }

        [DataType(DataType.MultilineText)]
        [StringLength(500)]
        [Display(Name = "What is the nature of the request?")]
        public string RequestNature { get; set; }

        [DataType(DataType.MultilineText)]
        [StringLength(500)]
        [Display(Name = "Request Name")]
        public string InformationRequired { get; set; }

        [DataType(DataType.MultilineText)]
        [StringLength(500)]
        [Display(Name = "What parameters are required?")]
        public string ParametersRequired { get; set; }

        [DataType(DataType.MultilineText)]
        [StringLength(500)]
        [Display(Name = "Who do you want to access the information?")]
        public string GroupingRequirments { get; set; }

        [DataType(DataType.MultilineText)]
        [StringLength(500)]
        [Display(Name = "Who do you want to access the information?")]
        public string PeopleToShare { get; set; }

        [DataType(DataType.MultilineText)]
        [StringLength(500)]
        [Display(Name = "Additional Comments")]
        public string AdditionalComments { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Date Reviewed")]
        public DateTime DateReviewed { get; set; }

        [Display(Name = "Estimated Hours")]
        public int EstimatedHours { get; set; }

        [Display(Name = "Business Case Id")]
        public int BusinessCaseId { get; set; }

        [DataType(DataType.MultilineText)]
        [StringLength(500)]
        [Display(Name = "Comments")]
        public string Comments { get; set; }

        [ScaffoldColumn(false)]
        public int ApprovalStatus { get; set; }
    }
}
