namespace RRMS.Application.Features;

public sealed record ResidencesHistoryQueryResult
{
    public string Name { get; set; }
    public string Address { get; set; }
    public int Rooms { get; set; }
    public double Size { get; set; }
    public double RentPrice { get; set; }
    public string ThumbnailUrl { get; set; }
    public int CityId { get; set; }
    public string City { get; set; }
}
