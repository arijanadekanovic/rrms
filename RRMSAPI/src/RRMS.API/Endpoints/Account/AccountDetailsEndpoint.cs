using MediatR;
using RRMS.Application.Features;

namespace RRMS.API.Endpoints.Account;

internal static class AccountDetailsEndpoint
{
    internal static IEndpointRouteBuilder MapAccountDetailsEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/account-details", AccountDetails)
            .RequireAuthorization()
            .Produces<AccountDetailsResponse>();
        // Example how to use Roles for authorization
        //.RequireAuthorization(AppPolicies.Admin.Name);

        return routeGroupBuilder;
    }

    private static async Task<IResult> AccountDetails(ISender sender, CancellationToken cancellationToken)
    {
        var query = new AccountDetailsQuery(); // Create the query object

        var result = await sender.Send(query, cancellationToken); // Send the query using MediatR

        // Handle the result using pattern matching
        return result.ToHttpResult
        (
            x => new AccountDetailsResponse
            {
                Id = x.Id,
                FirstName = x.FirstName,
                LastName = x.LastName,
                Email = x.Email,
                Username = x.Username,
                PhoneNumber = x.PhoneNumber,
                ProfilePhotoUrl = x.ProfilePhotoUrl,
                Roles = x.Roles
            }
        );
    }
}

public sealed record AccountDetailsResponse
{
    public string Id { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Email { get; set; }
    public string Username { get; set; }
    public string PhoneNumber { get; set; }
    public string ProfilePhotoUrl { get; set; }
    public IEnumerable<string> Roles { get; set; }
}
