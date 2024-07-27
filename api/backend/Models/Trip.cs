using System.Text.Json.Serialization;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;
using NetTopologySuite.Geometries;

namespace Anagata.Backend.Models;
[PrimaryKey(nameof(Id)), Table("trips")]
public class Trip
{
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    [Column("id"), Required, JsonPropertyName("id")]
    public int Id { get; set; } = 0;

    [Column("uuid"), Required, JsonPropertyName("uuid")]
    public string UUID { get; set; } = "";

    public static void Relations(ModelBuilder model)
    {
        model.Entity<User>(entity =>
        {
            entity.HasIndex(e => e.UUID).IsUnique();
        });
    }
}
