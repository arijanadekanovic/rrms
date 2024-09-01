using RRMS.Domain.Enums;

namespace RRMS.Application.Features;

public sealed record PaymentQueryResult
{
    public double Amount { get; set; }
    public string ResidenceName { get; set; }
    public string ResidentName { get; set; }
    public DateTime PaymentDateUtc { get; set; }
    public string SlipUrl { get; set; }
    public PaymentMethod PaymentMethod { get; set; }
}
