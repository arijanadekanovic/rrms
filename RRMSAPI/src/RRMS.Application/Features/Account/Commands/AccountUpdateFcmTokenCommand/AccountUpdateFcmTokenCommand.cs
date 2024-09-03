using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record AccountUpdateFcmTokenCommand : ICommand
{
    public string FcmToken { get; set; }
}
