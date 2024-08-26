using MediatR;
using RRMS.Application.Features;
using RRMS.Domain.Enums;

namespace RRMS.API.Endpoints.Residence;

internal static class ResidenceDetailsEndpoint
{
    internal static IEndpointRouteBuilder MapResidenceDetailsEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/details/{id}", ResidenceDetails)
            // .RequireAuthorization()
            .Produces<ResidenceDetailsResponse>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> ResidenceDetails(int id, ISender sender, CancellationToken cancellationToken)
    {
        var query = new ResidenceDetailsQuery
        {
            Id = id,
        };

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => new ResidenceDetailsResponse
            {
                Id = x.Id,
                Name = x.Name,
                Description = x.Description,
                Address = x.Address,
                Rooms = x.Rooms,
                Size = x.Size,
                RentPrice = x.RentPrice,
                Type = x.Type,
                ThumbnailUrl = x.ThumbnailUrl,
                City = x.City,
            }
        );
    }
}

public record ResidenceDetailsResponse
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public string Address { get; set; }
    public int Rooms { get; set; }
    public double Size { get; set; }
    public double RentPrice { get; set; }
    public ResidenceType Type { get; set; }
    public string ThumbnailUrl { get; set; }
    public string City { get; set; }
}
