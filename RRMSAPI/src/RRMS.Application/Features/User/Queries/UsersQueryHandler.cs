using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class UsersQueryHandler : IQueryHandler<UsersQuery, List<UserQueryResult>>
{
    private readonly IDatabaseContext _databaseContext;

    public UsersQueryHandler
    (
        IDatabaseContext databaseContext
    )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);

        _databaseContext = databaseContext;
    }

    public async Task<Result<List<UserQueryResult>>> Handle(UsersQuery request, CancellationToken cancellationToken)
    {
        var users = await _databaseContext.Users.ToListAsync();

        return users.Select(x => new UserQueryResult
        {
            Id = x.Id,
            FullName = $"{x.FirstName} {x.LastName}",
        }).ToList();
    }
}
