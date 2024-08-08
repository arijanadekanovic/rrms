using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using RRMS.Infrastructure.Persistance;

namespace DataSeeder.Configuration.Extensions;

internal static class DatabaseConfiguration
{
    private const string connectionString = "Server=rrms.database;Database=RRMS;User Id=sa;Password=Password1*;TrustServerCertificate=True";

    internal static IServiceCollection ConfigureDatabase(this IServiceCollection services)
    {
        services.AddDbContext<DatabaseContext>((sp, options) =>
        {
            options.UseSqlServer(connectionString);
            options.EnableSensitiveDataLogging().LogTo(Console.WriteLine, LogLevel.Debug, DbContextLoggerOptions.DefaultWithUtcTime);
        }, ServiceLifetime.Singleton);

        return services;
    }
}
