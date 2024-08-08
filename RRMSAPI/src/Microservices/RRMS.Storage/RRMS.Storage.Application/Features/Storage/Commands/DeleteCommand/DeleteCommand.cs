using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Storage.Application.Features.Storage.Commands.DeleteCommand;

public sealed record DeleteCommand : ICommand<DeleteCommandResult>
{
    public string Url { get; set; }
}
