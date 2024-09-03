using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class AccountUpdateFcmTokenCommandHandler : ICommandHandler<AccountUpdateFcmTokenCommand>
{
    private readonly ICurrentUser _currentUser;
    private readonly IDatabaseContext _databaseContext;

    public AccountUpdateFcmTokenCommandHandler
    (
        ICurrentUser currentUser,
        IDatabaseContext databaseContext
    )
    {
        ArgumentNullException.ThrowIfNull(currentUser);
        ArgumentNullException.ThrowIfNull(databaseContext);

        _currentUser = currentUser;
        _databaseContext = databaseContext;
    }

    public async Task<Result> Handle(AccountUpdateFcmTokenCommand request, CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();

        var user = await _databaseContext.Users.FirstOrDefaultAsync(x => x.Id == _currentUser.Id, cancellationToken);

        user.FcmToken = request.FcmToken;

        await _databaseContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
