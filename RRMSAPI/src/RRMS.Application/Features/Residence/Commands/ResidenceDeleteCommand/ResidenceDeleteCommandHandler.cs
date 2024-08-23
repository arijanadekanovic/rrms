using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Errors;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features.Residence.Commands.ResidenceDeleteCommand;

public sealed class ResidenceDeleteCommandHandler : ICommandHandler<ResidenceDeleteCommand>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public ResidenceDeleteCommandHandler
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

    public async Task<Result> Handle(ResidenceDeleteCommand request, CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();

        var residence = await _databaseContext.Residences.FirstOrDefaultAsync(x => x.Id == request.Id, cancellationToken);

        if (residence is null)
        {
            return Result.Failure(ResidenceDomainErrors.NotFound);
        }

        if (residence.OwnerId != _currentUser.Id)
        {
            return Result.Failure(ResidenceDomainErrors.NotOwner);
        }

        _databaseContext.Residences.Remove(residence);
        await _databaseContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
