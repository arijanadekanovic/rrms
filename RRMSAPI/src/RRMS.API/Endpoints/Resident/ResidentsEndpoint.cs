using MediatR;
using RRMS.Application.Features;
using RRMS.Domain.Enums;

namespace RRMS.API.Endpoints.Resident;

internal static class ResidentsEndpoint
{
    internal static IEndpointRouteBuilder MapResidentsEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/residents", Residents)
            .RequireAuthorization()
            .Produces<List<ResidentResponse>>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> Residents([AsParameters] ResidentsSearchRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var query = new ResidentsQuery
        {
            ResidenceId = request.ResidenceId,
        };

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => x.Select(x => new ResidentResponse
            {
                Id = x.Id,
                ContractStartDateUtc = x.ContractStartDateUtc,
                ContractEndDateUtc = x.ContractEndDateUtc,
                Status = x.Status,
                UserFullName = x.UserFullName,
                UserId = x.UserId,
                ResidenceId = x.ResidenceId,
            }).ToList()
        );
    }
}

public class ResidentsSearchRequest
{
    public int ResidenceId { get; set; }
}

public record ResidentResponse
{
    public int Id { get; set; }
    public DateTime ContractStartDateUtc { get; set; }
    public DateTime? ContractEndDateUtc { get; set; }
    public ResidentStatus Status { get; set; }
    public string UserFullName { get; set; }
    public string UserId { get; set; }
    public int ResidenceId { get; set; }
}
