using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class ResidenceDocument : AuditEntity
{
    public string Url { get; set; }

    public int ResidenceId { get; set; }

    public Residence Residence { get; set; }
}
