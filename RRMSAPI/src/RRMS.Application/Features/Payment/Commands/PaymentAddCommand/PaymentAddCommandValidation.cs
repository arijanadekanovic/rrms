using FluentValidation;


namespace RRMS.Application.Features;

public sealed class PaymentAddCommandValidation : AbstractValidator<PaymentAddCommand>
{
    public PaymentAddCommandValidation()
    {
        RuleFor(x => x.Amount).NotNull().NotEmpty();
    }
}

