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

            routes.MapPageRoute("download", "download", "~/_Download.aspx", true);
            routes.MapPageRoute("download-id", "download/{id}", "~/_Download.aspx", true);
            routes.MapPageRoute("create", "", "~/BIRequest/Create.aspx", true);
            routes.MapPageRoute("view", "{id}", "~/BIRequest/View.aspx", true);
            routes.MapPageRoute("fin-admin", "{id}/fin-admin", "~/BIRequest/FinAdmin.aspx", true);
            routes.MapPageRoute("sponsor", "{id}/sponsor", "~/BIRequest/Sponsor.aspx", true);
        }
    }
}
