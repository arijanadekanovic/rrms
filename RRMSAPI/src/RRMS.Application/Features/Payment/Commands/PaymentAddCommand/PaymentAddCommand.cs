using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record  PaymentAddCommand : ICommand
 {
     public double Amount { get; set; }
     public int ResidentId { get; set; }
     public string SlipUrl { get; set; }
     public PaymentMethod PaymentMethod { get; set; }
}
