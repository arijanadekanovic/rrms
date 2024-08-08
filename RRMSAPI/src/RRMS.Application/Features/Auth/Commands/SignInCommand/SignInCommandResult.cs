namespace RRMS.Application.Features.Auth.Commands.SignInCommand;

public sealed record SignInCommandResult
{
    public string AccessToken { get; set; }
    public string RefreshToken { get; set; }
}
