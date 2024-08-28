using FluentValidation;

namespace RRMS.Application.Features;

public class SignInCommandValidator : AbstractValidator<SignInCommand>
{
    public SignInCommandValidator()
    {
        RuleFor(x => x.EmailOrUserName).NotNull().NotEmpty();

        RuleFor(x => x.Password).NotNull().NotEmpty();
    }
}
