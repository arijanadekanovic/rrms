using RRMS.Microservices.SharedKernel.Messaging;
namespace RRMS.Application.Features.Payment.Commands.PaymentsAddCommand;
public sealed record  PaymentAddCommand : ICommand
 {
     public double Amount { get; set; }
     public int ResidentId { get; set; }
}
