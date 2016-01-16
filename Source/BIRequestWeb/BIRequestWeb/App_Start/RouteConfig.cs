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

            routes.MapPageRoute("", "", "~/BIRequest/Create.aspx", true);
            routes.MapPageRoute("download-empty", "download", "~/_Download.aspx", true);
            routes.MapPageRoute("download", "download/{id}", "~/_Download.aspx", true);
            routes.MapPageRoute("id", "{id}", "~/BIRequest/View.aspx", true);
            routes.MapPageRoute("sponsor", "{id}/sponsor", "~/BIRequest/Sponsor.aspx", true);
            routes.MapPageRoute("admin", "{id}/admin", "~/BIRequest/Admin.aspx", true);
        }
    }
}
