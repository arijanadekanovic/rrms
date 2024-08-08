namespace WorkFlow.Account.SharedKernel.Settings;

public class RefreshTokenOptions
{
    public string SecurityKey { get; init; }
    public long DurationInSeconds { get; init; }
    public string Issuer { get; init; }
    public string Audience { get; init; }
}
