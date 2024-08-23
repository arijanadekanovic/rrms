using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.Residence.Commands.ResidenceDeleteCommand;

public sealed record ResidenceDeleteCommand : ICommand
{
    public int Id { get; set; }
}
