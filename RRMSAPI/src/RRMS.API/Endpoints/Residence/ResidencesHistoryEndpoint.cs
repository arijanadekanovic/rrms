using MediatR;
using RRMS.Application.Features;
using RRMS.Domain.Enums;

namespace RRMS.API.Endpoints.Residence;

internal static class ResidencesHistoryEndpoint
{
    internal static IEndpointRouteBuilder MapResidencesHistoryEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/residences-history", Notifications)
            .RequireAuthorization()
            .Produces<List<ResidencesHistoryResponse>>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> Notifications(ISender sender, CancellationToken cancellationToken)
    {
        var query = new ResidencesHistoryQuery { };

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => x.Select(x => new ResidencesHistoryResponse
            {
                Name = x.Name,
                Address = x.Address,
                Rooms = x.Rooms,
                Size = x.Size, 
                RentPrice = x.RentPrice, 
                ThumbnailUrl = x.ThumbnailUrl, 
                CityId = x.CityId,
                City = x.City
            }).ToList()
        );
    }
}

public record ResidencesHistoryResponse
{
    public string Name { get; set; }
    public string Address { get; set; }
    public int Rooms { get; set; }
    public double Size { get; set; }
    public double RentPrice { get; set; }
    public string ThumbnailUrl { get; set; }
    public int CityId { get; set; }
    public string City { get; set; }
}
