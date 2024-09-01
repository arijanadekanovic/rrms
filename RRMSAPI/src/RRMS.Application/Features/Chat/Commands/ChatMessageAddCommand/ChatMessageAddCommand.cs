using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record ChatMessageAddCommand : ICommand
{
    public string ChatPartnerId { get; set; }
    public string MessageText { get; set; }
    public int ResidenceId { get; set; }
}
