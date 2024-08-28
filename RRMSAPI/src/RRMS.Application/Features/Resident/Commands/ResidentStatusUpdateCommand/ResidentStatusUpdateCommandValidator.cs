using FluentValidation;

namespace RRMS.Application.Features;

public sealed class ResidentStatusUpdateCommandValidator : AbstractValidator<ResidentStatusUpdateCommand>
{
    public ResidentStatusUpdateCommandValidator()
    {
        RuleFor(x => x.ResidentId).NotNull();
        RuleFor(x => x.Status).NotNull();
    }
}
