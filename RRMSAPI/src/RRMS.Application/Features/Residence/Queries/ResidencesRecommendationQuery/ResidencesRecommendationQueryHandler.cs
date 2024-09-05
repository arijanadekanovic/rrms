using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class ResidencesRecommendationQueryHandler : IQueryHandler<ResidencesRecommendationQuery, List<ResidenceRecommendationQueryResult>>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public ResidencesRecommendationQueryHandler
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

    public async Task<Result<List<ResidenceRecommendationQueryResult>>> Handle(ResidencesRecommendationQuery request, CancellationToken cancellationToken)
    {

        var residences = await _databaseContext.Residences
                .ToListAsync();

        return residences.Select(x => new ResidenceRecommendationQueryResult
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
