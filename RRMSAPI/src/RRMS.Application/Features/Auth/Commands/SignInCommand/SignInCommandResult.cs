namespace RRMS.Application.Features;

public sealed record SignInCommandResult
{
    public string AccessToken { get; set; }
    public string RefreshToken { get; set; }
}
