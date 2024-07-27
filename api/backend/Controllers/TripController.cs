using Anagata.Backend.DataStructures;
using Anagata.Backend.Models;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;

namespace Anagata.Backend.Controllers;
[ApiController, Route("/v1/trip")]
public class TripController : Controller
{
    private readonly DatabaseContext _ctx;

    public TripController(DatabaseContext ctx)
    {
        _ctx = ctx;
    }

    [HttpPost("start")]
    public async Task<ActionResult<TripReturnJson>> RegisterUser(
        [FromBody, Required] Trip trip)
    {
        var response = new TripReturnJson();
        await _ctx.AddAsync<Trip>(trip);
        await _ctx.SaveChangesAsync();

        response.Message = "Trip started";
        response.Trip = trip;
        return Ok(response);
    }

    public class TripReturnJson : ReturnJson
    {
        [JsonPropertyName("trip")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public Trip? Trip { get; set; }
    }
}
