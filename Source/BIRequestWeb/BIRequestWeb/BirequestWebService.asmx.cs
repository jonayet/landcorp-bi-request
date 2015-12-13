using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;
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
            var possibleResponses = new List<string> { "hi", "there", "how", "halh", "hook", "tough", "fetch" };
            Context.Response.ContentType = "application/json; charset=utf-8";
            Context.Response.Write(JsonConvert.SerializeObject(possibleResponses));
        }
    }
}
