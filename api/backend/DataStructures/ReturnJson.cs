using System.Text.Json.Serialization;

namespace Anagata.Backend.DataStructures;
public class ReturnJson
{
    [JsonPropertyName("message")]
    public string Message { get; set; } = "";
}
