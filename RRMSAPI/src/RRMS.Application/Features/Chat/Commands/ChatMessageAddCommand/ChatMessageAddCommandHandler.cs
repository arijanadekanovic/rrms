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

        var chatMessage = new ChatMessage
        {
            Text = request.MessageText,
            Seen = false,
            ResidenceId = request.ResidenceId,
            SenderId = _currentUser.Id,
            ReceiverId = residence.OwnerId,
        };

        await _databaseContext.ChatMessages.AddAsync(chatMessage);
        await _databaseContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
