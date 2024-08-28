using RRMS.Domain.Enums;

namespace RRMS.Application.Features;

public sealed record ResidentQueryResult
{
    public int Id { get; set; }
    public DateTime ContractStartDateUtc { get; set; }
    public DateTime? ContractEndDateUtc { get; set; }
    public ResidentStatus Status { get; set; }
    public string UserFullName { get; set; }
    public string UserId { get; set; }
    public int ResidenceId { get; set; }
}
