using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BIRequestWeb.Attributes
{
    public class AdminAuthorizeAttribute : AuthorizeAttribute
    {
        public AdminAuthorizeAttribute(params string[] roleKeys)
        {
            var roles = new List<string>();
            var allRoles = (NameValueCollection)ConfigurationManager.GetSection("CustomRoles");
            foreach (var roleKey in roleKeys)
            {
                roles.AddRange(allRoles[roleKey].Split(new[] { ',' }));
            }

            Roles = string.Join(",", roles);
        }

        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            base.OnAuthorization(filterContext);
            if (filterContext.Result is HttpUnauthorizedResult)
            {
                filterContext.Result = new RedirectResult("~/Offline/Index");
            }
        }
    }
}