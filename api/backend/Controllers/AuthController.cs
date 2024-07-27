using Anagata.Backend.DataStructures;
using Anagata.Backend.Models;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Anagata.Backend.Controllers;
[ApiController, Route("/v1")]
public class AuthController : Controller
{
    private readonly DatabaseContext _ctx;

    public AuthController(DatabaseContext ctx)
    {
        _ctx = ctx;
    }

    [HttpPost("register")]
    public async Task<ActionResult<AuthReturnJson>> RegisterUser(
        [FromBody, Required] User user)
    {
        var response = new AuthReturnJson();
        await _ctx.AddAsync<User>(user);
        await _ctx.SaveChangesAsync();

        response.Message = "Registration is successful.";
        response.Data = user;
        return Ok(response);
    }

    [HttpPost("login")]
    public async Task<ActionResult<AuthReturnJson>> LoginUser(
        [FromBody, Required] LoginRequest request)
    {
        var response = new AuthReturnJson();
        var data = await _ctx.User.Where(x => x.UUID == request.UUID).FirstOrDefaultAsync();
        if (data == null)
        {
            response.Message = "The Authorization header is malformed.";
            return NotFound(response);
        }

        response.Message = "Ok.";
        response.Data = data;
        return Ok(response);
    }

    public class LoginRequest
    {
        [JsonPropertyName("uuid")]
        public string UUID { get; set; } = "";
    }

    public class AuthReturnJson : ReturnJson
    {
        [JsonPropertyName("user")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public User? Data { get; set; }
    }
}
