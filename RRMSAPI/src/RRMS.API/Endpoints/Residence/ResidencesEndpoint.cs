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

    private static async Task<IResult> Residences([AsParameters] ResidencesRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var query = new ResidencesQuery
        {
            SearchTerm = request.SearchTerm,
            CityId = request.CityId,
            PriceFrom = request.PriceFrom,
            PriceTo = request.PriceTo,
            SizeFrom = request.SizeFrom,
            SizeTo = request.SizeTo,
            NumberOfRooms = request.NumberOfRooms,
            Type = request.Type,
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

public class ResidencesRequest
{
    public string SearchTerm { get; set; }
    public int? CityId { get; set; }
    public double? PriceFrom { get; set; }
    public double? PriceTo { get; set; }
    public double? SizeFrom { get; set; }
    public double? SizeTo { get; set; }
    public int? NumberOfRooms { get; set; }
    public ResidenceType? Type { get; set; }
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
