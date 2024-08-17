namespace RRMS.Application.Features.Payment.Queries.PaymentsQuery
{
    public sealed record PaymentQueryResult
    {
        public double Amount { get; init; }
        public string ResidenceName { get; init; }
        public string ResidentName { get; init; }
        public DateTime PaymentDateUtc { get; init; }
    }
}
