using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.Residence.Queries.MyResidencesQuery;

public sealed record MyResidencesQuery() : IQuery<List<MyResidenceQueryResult>> { }
