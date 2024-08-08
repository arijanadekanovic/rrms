using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.Residence.Queries.ResidencesQuery;

public sealed record ResidencesQuery() : IQuery<List<ResidenceQueryResult>>;
