using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record SignInCommand : ICommand<SignInCommandResult>
{
    public string EmailOrUserName { get; set; }
    public string Password { get; set; }
}
