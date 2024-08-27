using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record RefreshTokenCommand : ICommand<RefreshTokenCommandResult>
{
    public string Token { get; set; }
}
