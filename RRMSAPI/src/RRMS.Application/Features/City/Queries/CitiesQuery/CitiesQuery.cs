using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record CitiesQuery() : IQuery<List<CityQueryResult>> { }
