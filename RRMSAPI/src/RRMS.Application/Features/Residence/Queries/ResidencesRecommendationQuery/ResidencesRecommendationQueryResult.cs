using RRMS.Domain.Enums;

namespace RRMS.Application.Features;

public sealed record ResidenceRecommendationQueryResult
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Address { get; set; }
    public int Rooms { get; set; }
    public double Size { get; set; }
    public double RentPrice { get; set; }
    public ResidenceType Type { get; set; }
    public string ThumbnailUrl { get; set; }
    public string City { get; set; }
}
