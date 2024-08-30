using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using RRMS.Infrastructure.Persistance;
using RRMS.Microservices.Infrastructure.Persistence.Interceptors;

namespace DataSeeder.Configuration.Extensions;

internal static class DatabaseConfiguration
{
    private const string connectionString = "Server=rrms.database;Database=RRMS;User Id=sa;Password=Password1*;TrustServerCertificate=True";

    internal static IServiceCollection ConfigureDatabase(this IServiceCollection services)
    {
        // Register audit interceptors as scoped services
        services.AddScoped<OnCreateAuditInterceptor>();
        services.AddScoped<OnUpdateAuditInterceptor>();
        services.AddScoped<OnDeleteAuditInterceptor>();

        services.AddDbContext<DatabaseContext>((sp, options) =>
        {
            options.UseSqlServer(connectionString);

            // Retrieve auditing interceptors from service provider
            var onCreateAuditInterceptor = sp.GetRequiredService<OnCreateAuditInterceptor>();
            var onUpdateAuditInterceptor = sp.GetRequiredService<OnUpdateAuditInterceptor>();
            var onDeleteAuditInterceptor = sp.GetRequiredService<OnDeleteAuditInterceptor>();

            // Add auditing interceptors to DbContext options
            options.AddInterceptors(onCreateAuditInterceptor);
            options.AddInterceptors(onUpdateAuditInterceptor);
            options.AddInterceptors(onDeleteAuditInterceptor);

            options.EnableSensitiveDataLogging().LogTo(Console.WriteLine, LogLevel.Debug, DbContextLoggerOptions.DefaultWithUtcTime);
        }, ServiceLifetime.Singleton);

        return services;
    }
}
