using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.Account.Commands.AccountUpdateCommand;

public sealed record AccountUpdateCommand : ICommand
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string ProfilePhotoUrl { get; set; }
}
