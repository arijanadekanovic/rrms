namespace RRMS.Microservices.SharedKernel.Constants;

public static class AppClaimTypes
{
    private const string ClaimTypeRRMSNamespace = "https://schemas.rrms.com/ws/2024/09/identity/claims";

    public const string Id = $"{ClaimTypeRRMSNamespace}/id";
    public const string Name = $"{ClaimTypeRRMSNamespace}/name";
    public const string Email = $"{ClaimTypeRRMSNamespace}/email";
    public const string Username = $"{ClaimTypeRRMSNamespace}/username";
    public const string Role = $"{ClaimTypeRRMSNamespace}/role";
}
