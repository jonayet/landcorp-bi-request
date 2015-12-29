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

            routes.MapPageRoute("new", "new", "~/BIRequest/Create.aspx", true);
            routes.MapPageRoute("", "", "~/BIRequest/View.aspx", true);
            routes.MapPageRoute("id", "{id}", "~/BIRequest/View.aspx", true);
            routes.MapPageRoute("id-role", "{id}/{role}", "~/BIRequest/View.aspx", true);
        }
    }
}
