using MediatR;
using RRMS.Application.Features;
using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Constants;

namespace RRMS.API.Endpoints.Residence;

internal static class ResidenceAddEndpoint
{
    internal static IEndpointRouteBuilder MapResidenceAddEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPost("/add", ResidenceAdd)
            .RequireAuthorization(AppRoles.Landlord);

        return routeGroupBuilder;
    }

    private static async Task<IResult> ResidenceAdd(ResidenceAddRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new ResidenceAddCommand
        {
            Name = request.Name,
            Description = request.Description,
            Address = request.Address,
            Rooms = request.Rooms,
            Size = request.Size,
            RentPrice = request.RentPrice,
            Type = request.Type,
            ThumbnailUrl = request.ThumbnailUrl,
            CityId = request.CityId,
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();
    }
}

public sealed record ResidenceAddRequest
{
    public string Name { get; set; }
    public string Description { get; set; }
    public string Address { get; set; }
    public int Rooms { get; set; }
    public double Size { get; set; }
    public double RentPrice { get; set; }
    public ResidenceType Type { get; set; }
    public string ThumbnailUrl { get; set; }
    public int CityId { get; set; }
}
