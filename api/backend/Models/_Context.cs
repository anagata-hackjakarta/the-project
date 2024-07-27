using Anagata.Backend.Functions;
using Microsoft.EntityFrameworkCore;

namespace Anagata.Backend.Models;
public class DatabaseContext : DbContext
{
    public DbSet<User> User => Set<User>();
    public DbSet<Trip> Trip => Set<Trip>();

    protected override void OnConfiguring(DbContextOptionsBuilder optionBuilder)
    {
        var connString = DatabaseGenerator.GenerateConnectionString();
        var serverVersion = ServerVersion.AutoDetect(connString);
        optionBuilder.UseMySql(connectionString: connString, serverVersion, x => x.UseNetTopologySuite());
    }

    protected override void OnModelCreating(ModelBuilder model)
    {
        base.OnModelCreating(model);

        Models.User.Relations(model);
        Models.Trip.Relations(model);
    }
}
