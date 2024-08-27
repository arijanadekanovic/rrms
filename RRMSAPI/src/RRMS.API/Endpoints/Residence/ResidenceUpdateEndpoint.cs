using MediatR;
using RRMS.Application.Features;
using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Constants;

namespace RRMS.API.Endpoints.Residence;

internal static class ResidenceUpdateEndpoint
{
    internal static IEndpointRouteBuilder MapResidenceUpdateEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPut("/update", ResidenceUpdate)
            .RequireAuthorization(AppRoles.Landlord);

        return routeGroupBuilder;
    }

    private static async Task<IResult> ResidenceUpdate(ResidenceUpdateRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new ResidenceUpdateCommand
        {
            Id = request.Id,
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

public sealed record ResidenceUpdateRequest
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
    public int CityId { get; set; }
}
