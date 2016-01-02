using System;
using System.IO;
using System.Net;
using System.Runtime.Serialization.Formatters.Binary;
using BiRequestWeb.DAL;

namespace BiRequestWeb
{
    public partial class Downloads : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            int id;
            if (!int.TryParse(Page.RouteData.Values["id"] as string, out id)) return;

            var attachment = new Repository().GetAttachment(id);
            if (attachment.ContentLength == null) { return; }

            var memoryStream = new MemoryStream();
            var binaryFormatter = new BinaryFormatter();
            binaryFormatter.Serialize(memoryStream, attachment.FileContent);

            Context.Response.ContentType = attachment.ContentType;
            Context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + attachment.FileName);
            Context.Response.BinaryWrite(memoryStream.ToArray());
            Context.Response.Flush();
        }
    }
}