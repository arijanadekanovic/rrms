using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class ResidenceInspection : AuditEntity
{
    public string Description { get; set; }
    public DateTime InspectionDate { get; set; }

    public int ResidenceId { get; set; }

    public Residence Residence { get; set; }
}
