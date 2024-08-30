using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class Payment : AuditEntity
{
    public double Amount { get; set; }

    // PayPal or Slip 
    public PaymentMethod PaymentMethod { get; set; }

    // Slip (image or pdf file uploaded to our storage api)
    public string SlipUrl { get; set; }

    public int ResidentId { get; set; }

    public Resident Resident { get; set; }
}
