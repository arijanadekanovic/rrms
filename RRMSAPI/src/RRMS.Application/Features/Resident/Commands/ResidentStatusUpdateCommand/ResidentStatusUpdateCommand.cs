using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record ResidentStatusUpdateCommand : ICommand
{
    public int ResidentId { get; set; }
    public ResidentStatus Status { get; set; }
}
