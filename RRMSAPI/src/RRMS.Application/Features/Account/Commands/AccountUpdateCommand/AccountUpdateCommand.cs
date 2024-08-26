using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record AccountUpdateCommand : ICommand
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string PhoneNumber { get; set; }
    public string ProfilePhotoUrl { get; set; }
}
