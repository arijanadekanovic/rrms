using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class ChatMessagesQueryHandler : IQueryHandler<ChatMessagesQuery, ChatMessagesQueryResult>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public ChatMessagesQueryHandler
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

    public async Task<Result<ChatMessagesQueryResult>> Handle(ChatMessagesQuery request, CancellationToken cancellationToken)
    {
        var chatPartner = await _databaseContext.Users
            .Where(x => x.Id == request.ChatPartnerId)
            .FirstOrDefaultAsync();

        var chatMessages = await _databaseContext.ChatMessages
            .Where(x => x.ResidenceId == request.ResidenceId)
            .Where(x => (x.SenderId == _currentUser.Id && x.ReceiverId == request.ChatPartnerId) || (x.SenderId == request.ChatPartnerId && x.ReceiverId == _currentUser.Id))
            .Include(x => x.Sender)
            .ToListAsync();

        return new ChatMessagesQueryResult
        {
            ResidenceId = request.ResidenceId,
            ChatPartnerId = chatPartner.Id,
            ChatPartnerProfilePictureUrl = chatPartner.ProfilePhotoUrl,
            ChatPartnerName = $"{chatPartner.FirstName} {chatPartner.LastName}",
            ChatMessages = chatMessages.Select(x => new ChatMessageQueryResult
            {
                Message = x.Text,
                MessageDateTimeUtc = x.CreatedOnUtc,
                IsMyMessage = x.SenderId == _currentUser.Id,
                ProfilePhotoUrl = x.Sender.ProfilePhotoUrl,
            }).ToList(),
        };
    }
}
