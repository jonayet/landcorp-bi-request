using System;
using System.Collections.Generic;
using System.Web;
using System.Web.DynamicData;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace BiRequestWeb
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings {AutoRedirectMode = RedirectMode.Permanent};
            routes.EnableFriendlyUrls(settings);

            routes.MapPageRoute("request-new", "new-request", "~/BIRequest/Create.aspx", true);
            routes.MapPageRoute("request-empty", "request", "~/BIRequest/View.aspx", true);
            routes.MapPageRoute("request-id", "request/{id}", "~/BIRequest/View.aspx", true);
            routes.MapPageRoute("request-role", "request/{id}/{role}", "~/BIRequest/View.aspx", true);
        }
    }
}
