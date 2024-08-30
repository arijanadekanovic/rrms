using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Enums;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class ResidentsQueryHandler : IQueryHandler<ResidentsQuery, List<ResidentQueryResult>>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public ResidentsQueryHandler
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

    public async Task<Result<List<ResidentQueryResult>>> Handle(ResidentsQuery request, CancellationToken cancellationToken)
    {
        var residents = await _databaseContext.Residents
                .Where(x => !x.IsDeleted)
                .Where(x => x.ResidenceId == request.ResidenceId)
                .Where(x => x.Status != ResidentStatus.PendingRequest)
                .OrderByDescending(x => x.ContractStartDateUtc)
                .Include(x => x.User)
                .ToListAsync();

        var pendingResidents = await _databaseContext.Residents
                .Where(x => !x.IsDeleted)
                .Where(x => x.ResidenceId == request.ResidenceId)
                .Where(x => x.Status == ResidentStatus.PendingRequest)
                .OrderByDescending(x => x.ContractStartDateUtc)
                .Include(x => x.User)
                .ToListAsync();

        pendingResidents.AddRange(residents);

        return pendingResidents.Select(x => new ResidentQueryResult
        {
            Id = x.Id,
            ContractStartDateUtc = x.ContractStartDateUtc,
            ContractEndDateUtc = x.ContractEndDateUtc,
            Status = x.Status,
            UserFullName = $"{x.User.FirstName} {x.User.LastName}",
            UserId = x.UserId,
            ResidenceId = x.ResidenceId,
        }).ToList();
    }
}
