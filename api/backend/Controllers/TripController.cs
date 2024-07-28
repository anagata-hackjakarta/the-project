using Anagata.Backend.DataStructures;
using Anagata.Backend.Models;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

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

        var user = await _ctx.User.Where(x => x.UUID == trip.UUID).FirstOrDefaultAsync();
        if (user == null)
        {
            response.Message = "User not found.";
            return NotFound(response);
        }

        await _ctx.SaveChangesAsync();
        response.Message = "Trip started";
        response.TripId = trip.Id;
        return Ok(response);
    }

    public class TripReturnJson : ReturnJson
    {
        [JsonPropertyName("tripId")]
        public int TripId { get; set; }
    }
}
