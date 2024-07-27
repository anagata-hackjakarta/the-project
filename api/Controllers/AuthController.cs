using Anagata.Backend.DataStructures;
//using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;

namespace Anagata.Backend.Controllers;
[ApiController, Route("/v1")]
public class AuthController : Controller
{
    [HttpPost("register")]
    public ActionResult<AuthReturnJson> RegisterUser() {
        var response = new AuthReturnJson();
        response.Message = "Authenticated";
        return Ok(response);
    }

    public class AuthReturnJson : ReturnJson { }
}
