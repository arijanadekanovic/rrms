using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Domain.Entities;
using RRMS.Infrastructure.Persistance;

namespace DataSeeder.Configuration.Extensions;

internal static class IdentityConfiguration
{
    internal static IServiceCollection ConfigureIdentity(this IServiceCollection services)
    {
        services.AddIdentity<User, Role>()
           .AddEntityFrameworkStores<DatabaseContext>()
           .AddDefaultTokenProviders();

        services.Configure<IdentityOptions>(options =>
        {
            options.Password.RequireDigit = false;
            options.Password.RequireLowercase = false;
            options.Password.RequireNonAlphanumeric = false;
            options.Password.RequireUppercase = false;
            options.Password.RequiredLength = 4;

            options.SignIn.RequireConfirmedAccount = false;
            options.SignIn.RequireConfirmedEmail = false;

            options.Lockout.AllowedForNewUsers = true;
            options.Lockout.MaxFailedAccessAttempts = 10;
            options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(10);
        });

        return services;
    }
}
