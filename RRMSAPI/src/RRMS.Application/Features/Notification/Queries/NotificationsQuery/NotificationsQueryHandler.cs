using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features.Residence.Queries.NotificationsQuery;

public sealed class NotificationsQueryHandler : IQueryHandler<NotificationsQuery, List<NotificationQueryResult>>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public NotificationsQueryHandler
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

    public async Task<Result<List<NotificationQueryResult>>> Handle(NotificationsQuery request, CancellationToken cancellationToken)
    {
        var notifications = await _databaseContext.Notifications
                .Where(x => !x.IsDeleted)
                .Where(x => x.UserId == _currentUser.Id)
                .ToListAsync();

        return notifications.Select(x => new NotificationQueryResult
        {
            Id = x.Id,
            Title = x.Title,
            Description = x.Description,
            Type = x.Type,
        }).ToList();
    }
}
