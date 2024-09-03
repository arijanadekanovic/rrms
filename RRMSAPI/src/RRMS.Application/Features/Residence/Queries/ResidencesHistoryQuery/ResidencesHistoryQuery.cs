using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record ResidencesHistoryQuery() : IQuery<List<ResidencesHistoryQueryResult>> { }