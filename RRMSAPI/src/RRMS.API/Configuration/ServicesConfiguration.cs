using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using RRMS.API.Configuration.Extensions;
using RRMS.Application.Configuration;
using RRMS.Infrastructure.Configuration;
using RRMS.Microservices.API.Configuration.Extensions;
using RRMS.Microservices.API.Options;
using RRMS.Microservices.Infrastructure.Options;
using System.Reflection;

namespace RRMS.API.Configuration;

public static class ServicesConfiguration
{
    public static WebApplicationBuilder ConfigureServices(this WebApplicationBuilder builder)
    {
        var accessTokenOptions = builder.Configuration.GetSection("AuthOptions:AccessTokenOptions").Get<AccessTokenOptions>();
        var corsOptions = builder.Configuration.GetSection("CORSOptions").Get<CORSOptions>();

        FirebaseApp.Create(new AppOptions()
        {
            Credential = GoogleCredential.FromFile(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "rrms-d79d6-firebase-adminsdk-y0bsn-ad44475a1b.json")),
        });

        builder.Services
            .ConfigureAppOptions()
            .ConfigureApplication()
            .ConfigureInfrastructure(builder.Configuration)
            .ConfigureAuth(accessTokenOptions)
            .AddHttpContextAccessor()
            .AddHttpClient()
            .AddMemoryCache()
            .AddEndpointsApiExplorer()
            .ConfigureSwaggerApi("v1", "RRMS API", Assembly.GetExecutingAssembly().GetName().Name)
            .ConfigureCORS(corsOptions)
            .ConfigureMassTransit()
            .AddControllers();

        return builder;
    }
}
