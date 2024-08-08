using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using RRMS.Microservices.Infrastructure.Options;
using RRMS.Microservices.SharedKernel.Constants;

namespace RRMS.Microservices.API.Configuration.Extensions;

public static class AuthConfiguration
{
    public static IServiceCollection ConfigureAuth(this IServiceCollection services, AccessTokenOptions accessTokenOptions)
    {
        services.AddAuthentication(options =>
        {
            // Set default authentication schemes
            options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            options.DefaultSignInScheme = JwtBearerDefaults.AuthenticationScheme;
            options.DefaultSignOutScheme = JwtBearerDefaults.AuthenticationScheme;
            options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
        })
        .AddJwtBearer(options =>
        {
            // Configure JWT Bearer options
            options.RequireHttpsMetadata = true;
            options.TokenValidationParameters = new TokenValidationParameters
            {
                // Specify claim type for roles
                RoleClaimType = AppClaimTypes.Role,
                ValidateLifetime = true,
                ClockSkew = TimeSpan.FromSeconds(10), // Allow small clock skew
                RequireExpirationTime = true,
                ValidateIssuer = true,
                ValidIssuer = accessTokenOptions.Issuer,
                ValidateAudience = true,
                ValidAudience = accessTokenOptions.Audience,
                ValidateIssuerSigningKey = true,
                // Set the key used to sign the token
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(accessTokenOptions.SecurityKey))
            };
        });

        // Define authorization policies
        services.AddAuthorization(options =>
        {
            foreach (var appPolicy in AppPolicies.Values)
            {
                options.AddPolicy(appPolicy.Name, policy =>
                {
                    foreach (var role in appPolicy.Roles)
                    {
                        policy.RequireRole(role);
                    }
                });
            }
        });

        return services;
    }

    public static IApplicationBuilder UseAuth(this IApplicationBuilder app)
    {
        // Add authentication and authorization middleware to the pipeline
        app.UseAuthentication()
           .UseAuthorization();

        return app;
    }
}
