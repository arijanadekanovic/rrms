using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class ResidencesHistoryQueryHandler : IQueryHandler<ResidencesHistoryQuery, List<ResidencesHistoryQueryResult>>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public ResidencesHistoryQueryHandler
    (
        IDatabaseContext databaseContext,
        ICurrentUser currentUser
    )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);
        ArgumentNullException.ThrowIfNull(currentUser);

        _databaseContext = databaseContext;
        _currentUser = currentUser;
    }

    public async Task<Result<List<ResidencesHistoryQueryResult>>> Handle(ResidencesHistoryQuery request, CancellationToken cancellationToken)
    {
        var residences = await _databaseContext.Residences
                .Where(x => !x.IsDeleted && x.Residents.Any(r => r.UserId == _currentUser.Id))
                .Include(x => x.City)
                .ToListAsync(cancellationToken);

        return residences.Select(x => new ResidencesHistoryQueryResult
        {
            Name = x.Name,
            Address = x.Address,
            Rooms = x.Rooms,
            Size = x.Size,
            RentPrice = x.RentPrice,
            ThumbnailUrl = x.ThumbnailUrl,
            CityId = x.CityId,
            City = x.City.Name
        }).ToList();
    }
}
