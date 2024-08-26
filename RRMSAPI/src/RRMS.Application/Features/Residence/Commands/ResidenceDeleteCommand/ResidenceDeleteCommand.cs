using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record ResidenceDeleteCommand : ICommand
{
    public int Id { get; set; }
}
