using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Application.Abstractions.Services.Identity;
using RRMS.Domain.Entities;
using RRMS.Infrastructure.Persistance;
using RRMS.Infrastructure.Services.Identity.AccessTokenGenerator;

namespace RRMS.Infrastructure.Configuration.Extensions;

public static class IdentityConfiguration
{
    public static IServiceCollection ConfigureIdentity(this IServiceCollection services)
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

        services.AddScoped<IAuthTokenGenerator, AuthTokenGenerator>();

        return services;
    }
}
