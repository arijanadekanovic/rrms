using FluentValidation;

namespace RRMS.Application.Features;

public sealed class ResidentAddCommandValidator : AbstractValidator<ResidentAddCommand>
{
    public ResidentAddCommandValidator()
    {
        RuleFor(x => x.ContractStartDateUtc).NotNull();
        RuleFor(x => x.ContractEndDateUtc).NotNull();
        RuleFor(x => x.ResidenceId).NotNull();
    }
}
