using MediatR;
using RRMS.Application.Features;
using RRMS.Microservices.SharedKernel.Constants;

namespace RRMS.API.Endpoints.Residence;

internal static class ResidenceDeleteEndpoint
{
    internal static IEndpointRouteBuilder MapResidenceDeleteEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapDelete("/{id}", ResidenceDelete)
            .RequireAuthorization(AppRoles.Landlord);

        return routeGroupBuilder;
    }

    private static async Task<IResult> ResidenceDelete(int id, ISender sender, CancellationToken cancellationToken)
    {
        var command = new ResidenceDeleteCommand
        {
            Id = id,
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();
    }
}
