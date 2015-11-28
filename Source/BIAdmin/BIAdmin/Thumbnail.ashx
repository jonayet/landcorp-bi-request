<%@ WebHandler Language="C#" Class="Thumbnail" %>

using System;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.DirectoryServices;

public class Thumbnail : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {

        context.Response.Clear();

        if (!String.IsNullOrEmpty(context.Request.QueryString["UserName"]))
        {
            string UserName = context.Request.QueryString["UserName"].ToString();

            Image image = GetImage(UserName, context);

            context.Response.ContentType = "image/jpeg";
            image.Save(context.Response.OutputStream, ImageFormat.Jpeg);
        }
        else
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<p>Need a valid id</p>");
        }

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    private Image GetImage(string UserName, HttpContext context)
    {
        MemoryStream memoryStream = new MemoryStream();

        DirectoryEntry de = new DirectoryEntry();
        de.Path = "LDAP://OU=Users,OU=_Landcorp Farming,DC=landcorp,DC=Local";

        DirectorySearcher search = new DirectorySearcher();
        search.SearchRoot = de;
        search.Filter = "(&(objectClass=user)(objectCategory=person)(sAMAccountName=" + UserName + "))";
        search.PropertiesToLoad.Add("samaccountname");
        search.PropertiesToLoad.Add("thumbnailPhoto");

        SearchResult user;
        user = search.FindOne();
        
        try
        {

            byte[] Thumbnail = (byte[])user.Properties["thumbnailPhoto"][0];
            memoryStream = new MemoryStream(Thumbnail, false);
            return Image.FromStream(memoryStream);
        }
        catch
        {
            return Image.FromFile(context.Server.MapPath("~/Images/UnknownUser.jpg"));
        }
    }

}