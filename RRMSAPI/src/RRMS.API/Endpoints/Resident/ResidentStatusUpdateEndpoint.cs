using MediatR;
using RRMS.Application.Features;
using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Constants;

namespace RRMS.API.Endpoints.Resident;

internal static class ResidentStatusUpdateEndpoint
{
    internal static IEndpointRouteBuilder MapResidentStatusUpdateEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPut("/status-update", ResidentStatusUpdate)
            .RequireAuthorization(AppRoles.Landlord);

        return routeGroupBuilder;
    }

    private static async Task<IResult> ResidentStatusUpdate(ResidentStatusUpdateRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new ResidentStatusUpdateCommand
        {
            ResidentId = request.ResidentId,
            Status = request.Status,
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();
    }
}

public sealed record ResidentStatusUpdateRequest
{
    public int ResidentId { get; set; }
    public ResidentStatus Status { get; set; }
}
