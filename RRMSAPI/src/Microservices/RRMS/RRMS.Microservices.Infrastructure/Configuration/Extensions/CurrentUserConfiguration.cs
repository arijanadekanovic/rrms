using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.Infrastructure.Extensions;
using RRMS.Microservices.Infrastructure.Services.Identity;

namespace RRMS.Microservices.Infrastructure.Configuration.Extensions;

public static class CurrentUserConfiguration
{
    public static IServiceCollection ConfigureCurrentUser(this IServiceCollection services)
    {
        services.AddScoped<ICurrentUser>(serviceProvider =>
        {
            var httpContextAccessor = serviceProvider.GetRequiredService<IHttpContextAccessor>();

            return httpContextAccessor.HttpContext?.User?.GetCurrentUser() ?? new CurrentUser(
                    Guid.NewGuid().ToString(),
                    Guid.NewGuid().ToString(),
                    Guid.NewGuid().ToString(),
                    Guid.NewGuid().ToString(),
                    [Guid.NewGuid().ToString()]
                );
        });

        return services;
    }
}
