using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class ResidentFeedback : AuditEntity
{
    public int Rating { get; set; }
    public string Description { get; set; }

    public int ResidentId { get; set; }

    public Resident Resident { get; set; }
}
