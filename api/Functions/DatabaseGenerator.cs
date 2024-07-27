namespace Anagata.Backend.Functions;
public class DatabaseGenerator
{
    public static string GenerateConnectionString()
    {
        string server = Environment.GetEnvironmentVariable("MARIADB_HOST") ?? "localhost";
        string database = Environment.GetEnvironmentVariable("MARIADB_DATABASE") ?? "safina-ai";
        string username = Environment.GetEnvironmentVariable("MARIADB_USERNAME") ?? "root";
        string password = Environment.GetEnvironmentVariable("MARIADB_PASSWORD") ?? "roooooooot";
        return $"Server={server};Database={database};User Id={username};Password={password}";
    }
}
