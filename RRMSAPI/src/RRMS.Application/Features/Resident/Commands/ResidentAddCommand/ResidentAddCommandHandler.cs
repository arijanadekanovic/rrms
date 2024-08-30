using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Entities;
using RRMS.Domain.Enums;
using RRMS.Domain.Errors;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class ResidentAddCommandHandler : ICommandHandler<ResidentAddCommand>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public ResidentAddCommandHandler
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

    public async Task<Result> Handle(ResidentAddCommand request, CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();

        var alreadyExists = await _databaseContext.Residents
            .Where(x => x.ResidenceId == request.ResidenceId)
            .Where(x => x.UserId == _currentUser.Id)
            .Where(x => x.Status == ResidentStatus.PendingRequest)
            .AnyAsync();

        if (alreadyExists)
        {
            return Result.Failure(ResidentDomainErrors.AlreadyExists);
        }

        var resident = new Resident
        {
            ContractStartDateUtc = request.ContractStartDateUtc,
            ContractEndDateUtc = request.ContractEndDateUtc,
            Status = ResidentStatus.PendingRequest,
            UserId = _currentUser.Id,
            ResidenceId = request.ResidenceId,
        };

        await _databaseContext.Residents.AddAsync(resident);
        await _databaseContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
