using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Infrastructure.Persistance;
using RRMS.Microservices.Infrastructure.Options;
using RRMS.Microservices.Infrastructure.Persistence.Interceptors;

namespace RRMS.Infrastructure.Configuration.Extensions;

internal static class DatabaseConfiguration
{
    // Extension method to configure database services
    internal static IServiceCollection ConfigureDatabase(this IServiceCollection services, IConfiguration configuration)
    {
        // Retrieve database options from configuration
        var databaseOptions = configuration.GetSection("DatabaseOptions").Get<DatabaseOptions>();

        // Register audit interceptors as scoped services
        services.AddScoped<OnCreateAuditInterceptor>();
        services.AddScoped<OnUpdateAuditInterceptor>();
        services.AddScoped<OnDeleteAuditInterceptor>();

        // Configure DbContext with auditing interceptors
        services.AddDbContext<DatabaseContext>((sp, options) =>
        {
            // Set the connection string from the configuration
            options.UseSqlServer(
                databaseOptions.ConnectionString,
                builder => builder.MigrationsAssembly(typeof(DatabaseContext).Assembly.FullName)
                );

            // Retrieve auditing interceptors from service provider
            var onCreateAuditInterceptor = sp.GetRequiredService<OnCreateAuditInterceptor>();
            var onUpdateAuditInterceptor = sp.GetRequiredService<OnUpdateAuditInterceptor>();
            var onDeleteAuditInterceptor = sp.GetRequiredService<OnDeleteAuditInterceptor>();

            // Add auditing interceptors to DbContext options
            options.AddInterceptors(onCreateAuditInterceptor);
            options.AddInterceptors(onUpdateAuditInterceptor);
            options.AddInterceptors(onDeleteAuditInterceptor);

            // Enable sensitive data logging for debugging purposes
            options.EnableSensitiveDataLogging()
                   .LogTo(Console.WriteLine, LogLevel.Debug, DbContextLoggerOptions.DefaultWithUtcTime);
        });

        // Register DbContext as scoped service
        services.AddScoped<IDatabaseContext, DatabaseContext>();

        return services;
    }
}
