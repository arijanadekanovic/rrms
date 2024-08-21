using MediatR;
using RRMS.Application.Features.Residence.Queries.MyResidencesQuery;
using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Constants;

namespace RRMS.API.Endpoints.Residence;

internal static class MyResidencesEndpoint
{
    internal static IEndpointRouteBuilder MapMyResidencesEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/my-residences", MyResidences)
            .RequireAuthorization(AppRoles.Landlord)
            .Produces<List<MyResidenceResponse>>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> MyResidences(ISender sender, CancellationToken cancellationToken)
    {
        var query = new MyResidencesQuery { };

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => x.Select(x => new MyResidenceResponse
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

public record MyResidenceResponse
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
