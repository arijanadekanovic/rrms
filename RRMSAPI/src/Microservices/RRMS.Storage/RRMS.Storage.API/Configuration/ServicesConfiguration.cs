using RRMS.Microservices.API.Configuration.Extensions;
using RRMS.Microservices.API.Options;
using RRMS.Microservices.Infrastructure.Options;
using RRMS.Storage.API.Configuration.Extensions;
using RRMS.Storage.Application.Configuration;
using RRMS.Storage.Infrastructure.Configuration;

namespace RRMS.Storage.API.Configuration;

public static class ServicesConfiguration
{
    public static WebApplicationBuilder ConfigureServices(this WebApplicationBuilder builder)
    {
        var accessTokenOptions = builder.Configuration.GetSection("AuthOptions:AccessTokenOptions").Get<AccessTokenOptions>();
        var corsOptions = builder.Configuration.GetSection("CORSOptions").Get<CORSOptions>();

        builder.Services
            .ConfigureAppOptions()
            .ConfigureApplication()
            .ConfigureInfrastructure()
            .ConfigureAuth(accessTokenOptions)
            .AddHttpContextAccessor()
            .AddHttpClient()
            .AddMemoryCache()
            .AddEndpointsApiExplorer()
            .ConfigureSwaggerApi("v1", "RRMS Account API")
            .ConfigureCORS(corsOptions)
            .ConfigureMassTransit()
            .AddControllers();

        return builder;
    }
}
