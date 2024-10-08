using RRMS.Domain.Enums;

namespace RRMS.Application.Features;

public sealed record ResidenceDetailsQueryResult
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public string Address { get; set; }
    public int Rooms { get; set; }
    public double Size { get; set; }
    public double RentPrice { get; set; }
    public ResidenceType Type { get; set; }
    public string ThumbnailUrl { get; set; }
    public string OwnerId { get; set; }
    public ResidenceDetailsCityQueryResult City { get; set; }
}

public sealed record ResidenceDetailsCityQueryResult
{
    public int Id { get; set; }
    public string Name { get; set; }
}
