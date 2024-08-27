using FluentValidation;

namespace RRMS.Application.Features;

public sealed class RefreshTokenCommandValidator : AbstractValidator<RefreshTokenCommand>
{
    public RefreshTokenCommandValidator()
    {
        RuleFor(x => x.Token).NotNull().NotEmpty();
    }
}
