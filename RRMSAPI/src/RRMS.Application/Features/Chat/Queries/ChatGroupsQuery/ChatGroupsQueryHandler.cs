using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class ChatGroupsQueryHandler : IQueryHandler<ChatGroupsQuery, List<ChatGroupQueryResult>>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public ChatGroupsQueryHandler
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

    public async Task<Result<List<ChatGroupQueryResult>>> Handle(ChatGroupsQuery request, CancellationToken cancellationToken)
    {
        var chatGroups = (await _databaseContext.ChatMessages
            .Where(x => x.SenderId == _currentUser.Id || x.ReceiverId == _currentUser.Id)
            .Include(x => x.Residence)
            .Include(x => x.Sender)
            .Include(x => x.Receiver)
            .ToListAsync())
            .GroupBy(x => new
            {
                x.ResidenceId,
                ChatPartnerId = _currentUser.Id == x.SenderId ? x.ReceiverId : x.SenderId,
                ChatPartnerProfilePictureUrl = _currentUser.Id == x.SenderId ? x.Receiver.ProfilePhotoUrl : x.Sender.ProfilePhotoUrl,
                ChatPartnerName = _currentUser.Id == x.SenderId ? $"{x.Receiver.FirstName} {x.Receiver.LastName}" : $"{x.Sender.FirstName} {x.Sender.LastName}",
            })
            .Select(x => new ChatGroupQueryResult
            {
                ResidenceId = x.Key.ResidenceId,
                ChatPartnerId = x.Key.ChatPartnerId,
                ChatPartnerProfilePictureUrl = x.Key.ChatPartnerProfilePictureUrl,
                ChatPartnerName = x.Key.ChatPartnerName,
                LastMessage = x.LastOrDefault()?.Text,
                LastMessageDateTimeUtc = x.LastOrDefault().CreatedOnUtc,
                Seen = x.LastOrDefault().Seen,
            })
            .OrderBy(x => x.LastMessageDateTimeUtc)
            .OrderByDescending(x => x.Seen)
            .ToList();

        return chatGroups;
    }
}
