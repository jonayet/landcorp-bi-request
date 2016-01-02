using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Web.Script.Services;
using System.Web.Services;
using BiRequestWeb.DAL;
using BiRequestWeb.Entities;
using Newtonsoft.Json;

namespace BiRequestWeb
{
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    public class BirequestWebService : WebService
    {
        [WebMethod]
        public void SearchUser(string query)
        {
            var possibleResponses = new Repository().GetUser(query);
            Context.Response.ContentType = "application/json; charset=utf-8";
            Context.Response.Write(JsonConvert.SerializeObject(possibleResponses));
        }
    }
}
