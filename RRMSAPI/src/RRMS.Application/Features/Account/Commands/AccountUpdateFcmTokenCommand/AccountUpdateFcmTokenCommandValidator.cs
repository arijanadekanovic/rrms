using FluentValidation;

namespace RRMS.Application.Features;

public sealed class AccountUpdateFcmTokenCommandValidator : AbstractValidator<AccountUpdateFcmTokenCommand>
{
    public AccountUpdateFcmTokenCommandValidator()
    {
        RuleFor(x => x.FcmToken).NotNull().NotEmpty();
    }
}
