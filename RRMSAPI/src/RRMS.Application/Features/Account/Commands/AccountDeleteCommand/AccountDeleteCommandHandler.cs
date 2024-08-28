using MassTransit;
using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;
using RRMS.Microservices.Transport.Messages.Account.AccountDelete;

namespace RRMS.Application.Features;

public sealed class AccountDeleteCommandHandler : ICommandHandler<AccountDeleteCommand>
{
    private readonly ICurrentUser _currentUser;
    private readonly IDatabaseContext _databaseContext;
    private readonly IPublishEndpoint _publishEndpoint;

    public AccountDeleteCommandHandler
    (
        ICurrentUser currentUser,
        IDatabaseContext databaseContext,
        IPublishEndpoint publishEndpoint
    )
    {
        ArgumentNullException.ThrowIfNull(currentUser);
        ArgumentNullException.ThrowIfNull(databaseContext);
        ArgumentNullException.ThrowIfNull(publishEndpoint);

        _currentUser = currentUser;
        _databaseContext = databaseContext;
        _publishEndpoint = publishEndpoint;
    }

    public async Task<Result> Handle(AccountDeleteCommand request, CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();

        var user = await _databaseContext.Users.FirstOrDefaultAsync(x => x.Id == _currentUser.Id, cancellationToken);

        _databaseContext.Users.Remove(user);
        await _databaseContext.SaveChangesAsync(cancellationToken);

        await _publishEndpoint.Publish(new AccountDeletedMessage
        {
            Id = user.Id.ToString(),
            ProfilePhotoUrl = user.ProfilePhotoUrl,
        });

        return Result.Success();
    }
}
