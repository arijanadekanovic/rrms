using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record ResidentAddCommand : ICommand
{
    public DateTime ContractStartDateUtc { get; set; }
    public DateTime? ContractEndDateUtc { get; set; }
    public int ResidenceId { get; set; }
}
