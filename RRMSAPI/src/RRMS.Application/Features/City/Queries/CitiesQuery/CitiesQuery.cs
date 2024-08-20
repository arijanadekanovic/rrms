using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.City.Queries.CitiesQuery;

public sealed record CitiesQuery() : IQuery<List<CityQueryResult>> { }
