using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record PaymentsQuery() : IQuery<List<PaymentQueryResult>>
{
    public int? ResidenceId { get; set; }
}
