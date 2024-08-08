using MediatR;
using RRMS.Application.Features.Account.Commands.AccountUpdateCommand;

namespace RRMS.API.Endpoints.Account;

internal static class AccountUpdateEndpoint
{
    internal static IEndpointRouteBuilder MapAccountUpdateEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPatch("/update", AccountUpdate)
            .RequireAuthorization();

        return routeGroupBuilder;
    }

    private static async Task<IResult> AccountUpdate(AccountUpdateRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new AccountUpdateCommand
        {
            FirstName = request.FirstName,
            LastName = request.LastName,
            ProfilePhotoUrl = request.ProfilePhotoUrl,
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();
    }
}

public sealed record AccountUpdateRequest
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string ProfilePhotoUrl { get; set; }
}
