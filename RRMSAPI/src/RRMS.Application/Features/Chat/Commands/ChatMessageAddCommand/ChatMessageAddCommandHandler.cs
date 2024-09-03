using FirebaseAdmin.Messaging;
using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Entities;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class ChatMessageAddCommandHandler : ICommandHandler<ChatMessageAddCommand>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public ChatMessageAddCommandHandler
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

    public async Task<Result> Handle(ChatMessageAddCommand request, CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();

        var residence = await _databaseContext.Residences
            .Where(x => x.Id == request.ResidenceId)
            .FirstOrDefaultAsync();

        var currentUser = await _databaseContext.Users.FirstOrDefaultAsync(x => x.Id == _currentUser.Id);
        var chatPartner = await _databaseContext.Users.FirstOrDefaultAsync(x => x.Id == request.ChatPartnerId);

        var chatMessage = new ChatMessage
        {
            Text = request.MessageText,
            Seen = false,
            ResidenceId = request.ResidenceId,
            SenderId = _currentUser.Id,
            ReceiverId = request.ChatPartnerId,
        };

        await _databaseContext.ChatMessages.AddAsync(chatMessage);
        await _databaseContext.SaveChangesAsync(cancellationToken);

        if (!string.IsNullOrEmpty(chatPartner.FcmToken))
        {
            var message = new Message()
            {
                Notification = new FirebaseAdmin.Messaging.Notification
                {
                    Title = "New message",
                    Body = $"{currentUser.FirstName} {currentUser.LastName} sent you a message"
                },
                Data = new Dictionary<string, string>()
                {
                    ["message"] = chatMessage.Text,
                    ["messageDateTimeUtc"] = chatMessage.CreatedOnUtc.ToString(),
                    ["isMyMessage"] = "false",
                    ["profilePhotoUrl"] = chatPartner.ProfilePhotoUrl,
                },
                Token = chatPartner.FcmToken,
            };

            var messaging = FirebaseMessaging.DefaultInstance;
            var result = await messaging.SendAsync(message);
        }

        return Result.Success();
    }
}
