using FluentValidation;


namespace RRMS.Application.Features.Payment.Commands.PaymentsAddCommand
{
    public sealed class PaymentsAddCommandValidator : AbstractValidator<PaymentAddCommand>
    {
        public PaymentsAddCommandValidator()
        {
            RuleFor(x => x.Amount).NotNull().NotEmpty();
        }
    }
}
