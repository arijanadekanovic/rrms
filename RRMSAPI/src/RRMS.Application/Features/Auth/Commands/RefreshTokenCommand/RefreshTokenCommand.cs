using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.Auth.Commands.RefreshTokenCommand;

public sealed record RefreshTokenCommand : ICommand<RefreshTokenCommandResult>
{
    public string Token { get; set; }
}
