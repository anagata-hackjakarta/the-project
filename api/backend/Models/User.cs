using System.Text.Json.Serialization;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace Anagata.Backend.Models;
[PrimaryKey(nameof(Id)), Table("users")]
public class User
{
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    [Column("id"), Required, JsonPropertyName("id")]
    public int Id { get; set; } = 0;

    [Column("uuid"), Required, JsonPropertyName("uuid")]
    public string UUID { get; set; } = "";

    [Column("firstName"), Required, JsonPropertyName("firstName")]
    public string FirstName { get; set; } = "";

    [Column("lastName"), Required, JsonPropertyName("lastName")]
    public string LastName { get; set; } = "";

    [Column("vehicleType"), Required, JsonPropertyName("vehicleType")]
    public string VehicleType { get; set; } = "";

    [Column("vehicleYearProduction"), Required, JsonPropertyName("vehicleYearProduction")]
    public int VehicleYearProduction { get; set; } = 0;

    [Column("vehicleCapacity"), Required, JsonPropertyName("vehicleCapacity")]
    public int VehicleCapacity { get; set; } = 0;

    [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
    [Column("createdAt"), Required, JsonPropertyName("createdAt")]
    public DateTime CreatedAt { get; set; }

    [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
    [Column("updatedAt"), Required, JsonPropertyName("updatedAt")]
    public DateTime UpdatedAt { get; set; }
}
