using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class Resident : AggregateRoot
{
    public DateTime ContractStartDateUtc { get; set; }
    public DateTime? ContractEndDateUtc { get; set; }
    public ResidentStatus Status { get; set; }

    public string UserId { get; set; }
    public int ResidenceId { get; set; }

    public User User { get; set; }
    public Residence Residence { get; set; }

    public ResidentFeedback ResidentFeedback { get; set; }

    public List<MaintenanceRequest> MaintenanceRequests { get; set; }
    public List<Payment> Payments { get; set; }
    public List<ResidentDocument> ResidentDocuments { get; set; }
}
