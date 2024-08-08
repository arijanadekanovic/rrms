using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class ResidentDocument : AuditEntity
{
    public string Url { get; set; }

    public int ResidentId { get; set; }

    public Resident Resident { get; set; }
}
