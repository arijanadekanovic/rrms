using MassTransit;
using RRMS.Storage.API.Consumers;
using RRMS.Storage.API.Consumers.Auth;

namespace RRMS.Storage.API.Configuration.Extensions;

public static class MassTransitConfiguration
{
    public static IServiceCollection ConfigureMassTransit(this IServiceCollection services)
    {
        services.AddMassTransit(x =>
        {
            x.AddConsumer<AccountDeletedConsumer>().Endpoint(e => e.Name = AccountDeletedConsumer.Endpoint);
            x.AddConsumer<ProfilePhotoChangedConsumer>().Endpoint(e => e.Name = ProfilePhotoChangedConsumer.Endpoint);
            x.AddConsumer<ResidenceThumbnailChangedConsumer>().Endpoint(e => e.Name = ResidenceThumbnailChangedConsumer.Endpoint);

            x.UsingRabbitMq((context, cfg) =>
            {
                cfg.Host("rrms.rabbitmq", "/", h =>
                {
                    h.Username("guest");
                    h.Password("guest");
                });

                cfg.ReceiveEndpoint(AccountDeletedConsumer.Endpoint, e =>
                {
                    e.ConfigureConsumer<AccountDeletedConsumer>(context);
                });
                cfg.ReceiveEndpoint(ProfilePhotoChangedConsumer.Endpoint, e =>
                {
                    e.ConfigureConsumer<ProfilePhotoChangedConsumer>(context);
                });
                cfg.ReceiveEndpoint(ResidenceThumbnailChangedConsumer.Endpoint, e =>
                {
                    e.ConfigureConsumer<ResidenceThumbnailChangedConsumer>(context);
                });
            });
        });

        return services;
    }
}
