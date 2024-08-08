using System.Security.Claims;
using RRMS.Microservices.Infrastructure.Services.Identity;
using RRMS.Microservices.SharedKernel.Constants;

namespace RRMS.Microservices.Infrastructure.Extensions;

public static class ClaimsPrincipalExtensions
{
    public static CurrentUser GetCurrentUser(this ClaimsPrincipal claimsPrincipal)
    {
        return new CurrentUser
        (
            claimsPrincipal.GetId(),
            claimsPrincipal.GetName(),
            claimsPrincipal.GetUsername(),
            claimsPrincipal.GetEmail(),
            claimsPrincipal.GetRoles()
        );
    }

    private static string GetId(this ClaimsPrincipal claimsPrincipal) => claimsPrincipal.FindFirstValue(AppClaimTypes.Id);
    private static string GetEmail(this ClaimsPrincipal claimsPrincipal) => claimsPrincipal.FindFirstValue(AppClaimTypes.Email);
    private static string GetUsername(this ClaimsPrincipal claimsPrincipal) => claimsPrincipal.FindFirstValue(AppClaimTypes.Username);
    private static string GetName(this ClaimsPrincipal claimsPrincipal) => claimsPrincipal.FindFirstValue(AppClaimTypes.Name);
    private static List<string> GetRoles(this ClaimsPrincipal claimsPrincipal)
    {
        if (!claimsPrincipal.HasClaim(x => x.Type == AppClaimTypes.Role))
        {
            return Enumerable.Empty<string>().ToList();
        }

        return claimsPrincipal
            .FindAll(x => x.Type == AppClaimTypes.Role)
            .Select(x => x.Value)
            .ToList();
    }
}
