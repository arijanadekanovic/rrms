using Microsoft.Extensions.DependencyInjection;
using RRMS.Storage.Application.Abstractions.Services.Identity;
using RRMS.Storage.Infrastructure.Services;

namespace RRMS.Storage.Infrastructure.Configuration.Extensions;

internal static class ServicesConfiguration
{
    internal static IServiceCollection ConfigureServices(this IServiceCollection services)
    {
        services.AddScoped<IStorageService, StorageService>();

        return services;
    }
}
