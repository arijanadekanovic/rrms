using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Errors;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class ResidentStatusUpdateCommandHandler : ICommandHandler<ResidentStatusUpdateCommand>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public ResidentStatusUpdateCommandHandler
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

    public async Task<Result> Handle(ResidentStatusUpdateCommand request, CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();

        var resident = await _databaseContext.Residents
            .Where(x => !x.IsDeleted)
            .Where(x => x.Id == request.ResidentId)
            .Include(x => x.Residence)
            .FirstOrDefaultAsync();

        if (resident is null)
        {
            return Result.Failure(ResidentDomainErrors.NotFound);
        }

        if (resident.Residence.OwnerId != _currentUser.Id)
        {
            return Result.Failure(ResidenceDomainErrors.NotOwner);
        }

        resident.Status = request.Status;

        await _databaseContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
