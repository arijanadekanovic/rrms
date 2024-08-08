using MediatR;
using RRMS.Application.Features.Residence.Queries.ResidencesQuery;
using RRMS.Domain.Enums;

namespace RRMS.API.Endpoints.Residence;

internal static class ResidencesEndpoint
{
    internal static IEndpointRouteBuilder MapResidencesEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/residences", Residences)
            //.RequireAuthorization()
            .Produces<List<ResidenceResponse>>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> Residences(ISender sender, CancellationToken cancellationToken)
    {
        var query = new ResidencesQuery();

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => x.Select(x => new ResidenceResponse
            {
                Id = x.Id,
                Name = x.Name,
                Address = x.Address,
                Rooms = x.Rooms,
                Size = x.Size,
                RentPrice = x.RentPrice,
                Type = x.Type,
                ThumbnailUrl = x.ThumbnailUrl,
                City = x.City,
            }).ToList()
        );
    }
}

public record ResidenceResponse
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Address { get; set; }
    public int Rooms { get; set; }
    public double Size { get; set; }
    public double RentPrice { get; set; }
    public ResidenceType Type { get; set; }
    public string ThumbnailUrl { get; set; }
    public string City { get; set; }
}
