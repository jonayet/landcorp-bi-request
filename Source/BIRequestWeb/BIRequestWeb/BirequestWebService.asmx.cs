using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;

namespace BiRequestWeb
{
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    public class BirequestWebService : WebService
    {
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<string> SearchUser(string query)
        {
            var possibleResponses = new List<string> { "hi", "there" }; //GetPossibleResponses(enteredText);
            return possibleResponses;
        }
    }
}
