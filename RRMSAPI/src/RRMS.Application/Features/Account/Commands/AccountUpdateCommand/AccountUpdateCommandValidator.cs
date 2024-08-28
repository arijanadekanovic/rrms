using FluentValidation;

namespace RRMS.Application.Features;

public sealed class AccountUpdateCommandValidator : AbstractValidator<AccountUpdateCommand>
{
    public AccountUpdateCommandValidator()
    {
        RuleFor(x => x.FirstName).NotNull().NotEmpty();
        RuleFor(x => x.LastName).NotNull().NotEmpty();
    }
}
