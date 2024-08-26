using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Errors;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class AccountDetailsQueryHandler : IQueryHandler<AccountDetailsQuery, AccountDetailsQueryResult>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public AccountDetailsQueryHandler
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

    public async Task<Result<AccountDetailsQueryResult>> Handle(AccountDetailsQuery request, CancellationToken cancellationToken)
    {
        var user = await _databaseContext.Users
            .Where(x => !x.IsDeleted)
            .Where(x => x.Id == _currentUser.Id)
            .Include(x => x.UserRoles)
            .ThenInclude(x => x.Role)
            .FirstOrDefaultAsync();

        if (user is null)
        {
            return Result.Failure<AccountDetailsQueryResult>(UserDomainErrors.NotFound);
        }

        return new AccountDetailsQueryResult
        {
            Id = user.Id,
            FirstName = user.FirstName,
            LastName = user.LastName,
            Email = user.Email,
            Username = user.UserName,
            PhoneNumber = user.PhoneNumber,
            ProfilePhotoUrl = user.ProfilePhotoUrl,
            Roles = user.UserRoles.Select(x => x.Role.NormalizedName)
        };
    }
}
