using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.Account.Commands.SignUpCommand;

public sealed record SignUpCommand : ICommand
{
    public string Email { get; set; }
    public string Username { get; set; }
    public string Password { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Role { get; set; }
    public string ProfilePhotoUrl { get; set; }
}
