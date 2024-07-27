using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace Anagata.Backend.Controllers;
[ApiController, Route("/verify")]
public class VerifyController : Controller
{
    [HttpPost]
    public ActionResult<VerifyReturnJson> VerifyClientOnPrivateMode() {
        var response = new VerifyReturnJson();
        response.Message = "Authenticated";
        return Ok(response);
    }

    public class VerifyReturnJson
    {
        [JsonPropertyName("message")]
        public string Message { get; set; } = "";

        [JsonPropertyName("isPublic")]
        public bool IsPublic { get; set; } = true;
    }
}
