using MediatR;
using RRMS.Application.Features;
using RRMS.Domain.Enums;

namespace RRMS.API.Endpoints.Residence;

internal static class ResidencesRecommendationEndpoint
{
    internal static IEndpointRouteBuilder MapResidencesRecommendationEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/residences-recommendation/{id}", ResidencesRecommendation)
            .RequireAuthorization()
            .Produces<List<ResidenceRecommendationResponse>>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> ResidencesRecommendation(int id, ISender sender, CancellationToken cancellationToken)
    {
        var query = new ResidencesRecommendationQuery
        {
            Id = id,
        };

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

public record ResidenceRecommendationResponse
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
