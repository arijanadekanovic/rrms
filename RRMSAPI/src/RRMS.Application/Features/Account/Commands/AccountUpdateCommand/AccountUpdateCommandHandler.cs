using MassTransit;
using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;
using RRMS.Microservices.Transport.Messages.Account.ProfilePhotoChanged;

namespace RRMS.Application.Features.Account.Commands.AccountUpdateCommand;

public sealed class AccountUpdateCommandHandler : ICommandHandler<AccountUpdateCommand>
{
    private readonly ICurrentUser _currentUser;
    private readonly IDatabaseContext _databaseContext;
    private readonly IPublishEndpoint _publishEndpoint;

    public AccountUpdateCommandHandler
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

    public async Task<Result> Handle(AccountUpdateCommand request, CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();

        var user = await _databaseContext.Users.FirstOrDefaultAsync(x => x.Id == _currentUser.Id, cancellationToken);

        var profilePhotoChanged = user.ProfilePhotoUrl != request.ProfilePhotoUrl && !string.IsNullOrEmpty(user.ProfilePhotoUrl);
        var oldProfilePhotoUrl = user.ProfilePhotoUrl;

        user.FirstName = request.FirstName;
        user.LastName = request.LastName;
        user.PhoneNumber = request.PhoneNumber;
        user.ProfilePhotoUrl = request.ProfilePhotoUrl;

        await _databaseContext.SaveChangesAsync(cancellationToken);

        if (profilePhotoChanged)
        {
            await _publishEndpoint.Publish(new ProfilePhotoChangedMessage
            {
                OldProfilePhotoUrl = oldProfilePhotoUrl,
            });
        }

        return Result.Success();
    }
}
