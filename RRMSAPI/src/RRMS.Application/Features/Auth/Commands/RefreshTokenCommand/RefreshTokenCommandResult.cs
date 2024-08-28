namespace RRMS.Application.Features;

public sealed record RefreshTokenCommandResult
{
    public string AccessToken { get; set; }
    public string RefreshToken { get; set; }
}
