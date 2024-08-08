namespace RRMS.Application.Features.Auth.Commands.RefreshTokenCommand;

public sealed record RefreshTokenCommandResult
{
    public string AccessToken { get; set; }
    public string RefreshToken { get; set; }
}
