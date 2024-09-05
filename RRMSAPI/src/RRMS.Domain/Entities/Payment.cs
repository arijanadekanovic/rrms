using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class Payment : AuditEntity
{
    public double Amount { get; set; }
    public PaymentMethod PaymentMethod { get; set; }
    public string SlipUrl { get; set; }
    public string PayPalPaymentId { get; set; }

    public int ResidentId { get; set; }

    public Resident Resident { get; set; }
}
