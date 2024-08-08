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
        var residences = await _databaseContext.Residences
            .Where(x => !x.IsDeleted)
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
