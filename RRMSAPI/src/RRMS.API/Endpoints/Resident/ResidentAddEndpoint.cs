using MediatR;
using RRMS.Application.Features;
using RRMS.Microservices.SharedKernel.Constants;

namespace RRMS.API.Endpoints.Resident;

internal static class ResidentAddEndpoint
{
    internal static IEndpointRouteBuilder MapResidentAddEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPost("/add", ResidentAdd)
            .RequireAuthorization(AppRoles.Resident);

        return routeGroupBuilder;
    }

    private static async Task<IResult> ResidentAdd(ResidentAddRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new ResidentAddCommand
        {
            ContractStartDateUtc = request.ContractStartDateUtc,
            ContractEndDateUtc = request.ContractEndDateUtc,
            ResidenceId = request.ResidenceId,
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();
    }
}

public sealed record ResidentAddRequest
{
    public DateTime ContractStartDateUtc { get; set; }
    public DateTime? ContractEndDateUtc { get; set; }
    public int ResidenceId { get; set; }
}
