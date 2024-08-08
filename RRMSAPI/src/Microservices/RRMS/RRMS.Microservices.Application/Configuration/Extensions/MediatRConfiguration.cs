global using Microsoft.EntityFrameworkCore;
global using Microsoft.Extensions.DependencyInjection;
using System.Reflection;
using FluentValidation;
using RRMS.Microservices.Application.Common.Behaviours;

namespace RRMS.Microservices.Configuration.Extensions;

public static class MediatRConfiguration
{
    public static IServiceCollection ConfigureMediatR(this IServiceCollection services, Assembly assembly)
    {
        services.AddValidatorsFromAssembly(assembly);

        services.AddMediatR(configuration =>
        {
            configuration.RegisterServicesFromAssembly(assembly);
            configuration.AddOpenBehavior(typeof(ValidationBehavior<,>));
        });

        return services;
    }
}
