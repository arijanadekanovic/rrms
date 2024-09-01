using FluentValidation;

namespace RRMS.Application.Features;

public sealed class ChatMessageAddCommandValidator : AbstractValidator<ChatMessageAddCommand>
{
    public ChatMessageAddCommandValidator()
    {
        RuleFor(x => x.ChatPartnerId).NotNull();
        RuleFor(x => x.MessageText).NotNull().NotEmpty();
        RuleFor(x => x.ResidenceId).NotNull();

    }
}
