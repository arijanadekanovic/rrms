using MediatR;
using RRMS.Application.Features;

namespace RRMS.API.Endpoints.City;

internal static class CitiesEndpoint
{
    internal static IEndpointRouteBuilder MapCitiesEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/cities", Cities)
            //.RequireAuthorization()
            .Produces<List<CityResponse>>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> Cities(ISender sender, CancellationToken cancellationToken)
    {
        var query = new CitiesQuery { };

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => x.Select(x => new CityResponse
            {
                Id = x.Id,
                Name = x.Name,
            }).ToList()
        );
    }
}

public record CityResponse
{
    public int Id { get; set; }
    public string Name { get; set; }
}
