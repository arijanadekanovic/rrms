using RRMS.API.Configuration.Extensions;
using RRMS.Application.Configuration;
using RRMS.Infrastructure.Configuration;
using RRMS.Microservices.API.Configuration.Extensions;
using RRMS.Microservices.API.Options;
using RRMS.Microservices.Infrastructure.Options;

namespace RRMS.API.Configuration;

public static class ServicesConfiguration
{
    public static WebApplicationBuilder ConfigureServices(this WebApplicationBuilder builder)
    {
        var accessTokenOptions = builder.Configuration.GetSection("AuthOptions:AccessTokenOptions").Get<AccessTokenOptions>();
        var corsOptions = builder.Configuration.GetSection("CORSOptions").Get<CORSOptions>();

        builder.Services
            .ConfigureAppOptions()
            .ConfigureApplication()
            .ConfigureInfrastructure(builder.Configuration)
            .ConfigureAuth(accessTokenOptions)
            .AddHttpContextAccessor()
            .AddHttpClient()
            .AddMemoryCache()
            .AddEndpointsApiExplorer()
            .ConfigureSwaggerApi("v1", "RRMS API")
            .ConfigureCORS(corsOptions)
            .ConfigureMassTransit()
            .AddControllers();

        return builder;
    }
}
