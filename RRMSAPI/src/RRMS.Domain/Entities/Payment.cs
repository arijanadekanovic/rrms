using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class Payment : AuditEntity
{
    public double Amount { get; set; }

    public int ResidentId { get; set; }

    public Resident Resident { get; set; }
}
