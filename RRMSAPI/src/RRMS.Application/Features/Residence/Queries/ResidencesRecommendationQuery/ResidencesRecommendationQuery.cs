using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record ResidencesRecommendationQuery() : IQuery<List<ResidenceRecommendationQueryResult>>
{
    public int Id { get; set; }
}
