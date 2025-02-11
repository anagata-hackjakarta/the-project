using Anagata.Backend.Models;

namespace Anagata.Backend;
public class Program
{
    static void Main(string[] args) => new Program().Start(args);
    public void Start(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Add services to the container
        var app = ConfigureServiceBuilder(ref builder);

        // Set middleware
        ConfigureMiddleware(ref app);

        // Run app
        app.Run();
    }

    /**
     * Configure service for app builder.
     * This method can be used for insert singleton or service that can be injected on controller.
     */
    public WebApplication ConfigureServiceBuilder(ref WebApplicationBuilder builder)
    {
        // Add Controller Path
        builder.Services.AddControllers();

        // Add EFCore
        builder.Services.AddDbContext<DatabaseContext>();

        // Logger
        builder.Services.AddLogging(logger =>
            logger.AddSimpleConsole(options => {
                options.SingleLine = true;
                options.TimestampFormat = "yyyy-MM-dd HH:mm:ss ";
            })
        );

        // Insert singleton if needed
        return builder.Build();
    }

    /**
     * Configure middleware for webapp.
     */
    public static void ConfigureMiddleware(ref WebApplication app)
    {
        app.UseRouting();
        app.MapControllers();
        app.UseExceptionHandler("/error");

        // Health Check
        app.MapGet("/", async context =>
        {
            await context.Response.WriteAsJsonAsync(new { Message = "Hello world!" });
        });
    }
}

