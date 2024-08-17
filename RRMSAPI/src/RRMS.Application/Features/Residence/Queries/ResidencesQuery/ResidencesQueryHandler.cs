using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features.Residence.Queries.ResidencesQuery;

public sealed class ResidencesQueryHandler : IQueryHandler<ResidencesQuery, List<ResidenceQueryResult>>
{
    private readonly IDatabaseContext _databaseContext;

    public ResidencesQueryHandler
    (
        IDatabaseContext databaseContext
    )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);

        _databaseContext = databaseContext;
    }

    public async Task<Result<List<ResidenceQueryResult>>> Handle(ResidencesQuery request, CancellationToken cancellationToken)
    {
        var searchTerm = request.SearchTerm?.ToLower();

        var residences = await _databaseContext.Residences
                .Where(x => !x.IsDeleted)
                .Where(x => string.IsNullOrEmpty(searchTerm) || x.Name.ToLower().Contains(searchTerm))
                .Where(x => request.CityId == null || x.CityId == request.CityId)
                .Where(x => request.PriceFrom == null || x.RentPrice >= request.PriceFrom)
                .Where(x => request.PriceTo == null || x.RentPrice <= request.PriceTo)
                .Where(x => request.SizeFrom == null || x.Size >= request.SizeFrom)
                .Where(x => request.SizeTo == null || x.Size <= request.SizeTo)
                .Where(x => request.NumberOfRooms == null || x.Rooms == request.NumberOfRooms)
                .Where(x => request.Type == null || x.Type == request.Type)
                .Include(x => x.City)
                .ToListAsync();

        return residences.Select(x => new ResidenceQueryResult
        {
            Id = x.Id,
            Name = x.Name,
            Address = x.Address,
            Rooms = x.Rooms,
            Size = x.Size,
            RentPrice = x.RentPrice,
            Type = x.Type,
            ThumbnailUrl = x.ThumbnailUrl,
            City = x.City.Name,
        }).ToList();
    }
}
