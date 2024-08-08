using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class MaintenanceRequest : AuditEntity
{
    public string Title { get; set; }
    public string Description { get; set; }
    public MaintenanceRequestStatus Status { get; set; }

    public int ResidentId { get; set; }

    public Resident Resident { get; set; }
}
