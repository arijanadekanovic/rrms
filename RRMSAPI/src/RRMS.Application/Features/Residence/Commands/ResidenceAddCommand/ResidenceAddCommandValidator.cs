using FluentValidation;

namespace RRMS.Application.Features;

public sealed class ResidenceAddCommandValidator : AbstractValidator<ResidenceAddCommand>
{
    public ResidenceAddCommandValidator()
    {
        RuleFor(x => x.Name).NotNull().NotEmpty();
        RuleFor(x => x.Address).NotNull().NotEmpty();
        RuleFor(x => x.Rooms).NotNull();
        RuleFor(x => x.Size).NotNull();
        RuleFor(x => x.RentPrice).NotNull();
        RuleFor(x => x.Type).NotNull();
        RuleFor(x => x.ThumbnailUrl).NotNull().NotEmpty();
        RuleFor(x => x.CityId).NotNull();
    }
}
