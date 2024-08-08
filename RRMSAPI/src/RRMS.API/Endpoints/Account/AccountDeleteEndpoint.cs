using MediatR;
using RRMS.Application.Features.Account.Commands.AccountDeleteCommand;

namespace RRMS.API.Endpoints.Account;

internal static class AccountDeleteEndpoint
{
    internal static IEndpointRouteBuilder MapAccountDeleteEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapDelete("/delete", AccountDelete)
            .RequireAuthorization();

        return routeGroupBuilder;
    }

    private static async Task<IResult> AccountDelete(ISender sender, CancellationToken cancellationToken)
    {
        var command = new AccountDeleteCommand { };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();
    }
}
