using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features.Residence.Queries.MyResidencesQuery;

public sealed class MyResidencesQueryHandler : IQueryHandler<MyResidencesQuery, List<MyResidenceQueryResult>>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public MyResidencesQueryHandler
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

    public async Task<Result<List<MyResidenceQueryResult>>> Handle(MyResidencesQuery request, CancellationToken cancellationToken)
    {
        var residences = await _databaseContext.Residences
                .Where(x => !x.IsDeleted)
                .Where(x => x.OwnerId == _currentUser.Id)
                .Include(x => x.City)
                .ToListAsync();

        return residences.Select(x => new MyResidenceQueryResult
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
