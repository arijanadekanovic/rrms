using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class Residence : AggregateRoot
{
    public string Name { get; set; }
    public string Description { get; set; }
    public string Address { get; set; }
    public int Rooms { get; set; }
    public double Size { get; set; }
    public double RentPrice { get; set; }
    public ResidenceType Type { get; set; }
    public string ThumbnailUrl { get; set; }

    public int CityId { get; set; }
    public string OwnerId { get; set; }

    public City City { get; set; }
    public User Owner { get; set; }

    public List<ChatMessage> ChatMessages { get; set; }
    public List<ResidenceDocument> ResidenceDocuments { get; set; }
    public List<ResidenceImage> ResidenceImages { get; set; }
    public List<ResidenceInspection> ResidenceInspections { get; set; }
    public List<Resident> Residents { get; set; }
}
