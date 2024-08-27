using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record ResidentsQuery() : IQuery<List<ResidentQueryResult>>
{
    public int ResidenceId { get; set; }
}
