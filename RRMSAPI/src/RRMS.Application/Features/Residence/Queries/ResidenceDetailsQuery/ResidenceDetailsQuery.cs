using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record ResidenceDetailsQuery() : IQuery<ResidenceDetailsQueryResult>
{
    public int Id { get; set; }
}
