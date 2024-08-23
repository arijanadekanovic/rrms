using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.Residence.Queries.ResidencesQuery;

public sealed record ResidencesQuery() : IQuery<List<ResidenceQueryResult>>
{
    public string SearchTerm { get; set; }
    public int? CityId { get; set; }
    public double? PriceFrom { get; set; }
    public double? PriceTo { get; set; }
    public double? SizeFrom { get; set; }
    public double? SizeTo { get; set; }
    public int? NumberOfRooms { get; set; }
    public ResidenceType? Type { get; set; }
    public bool? OwnedByMe { get; set; }
}
