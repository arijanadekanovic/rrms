using MediatR;
using RRMS.Application.Features;

namespace RRMS.API.Endpoints.Account;

internal static class AccountUpdateFcmTokenEndpoint
{
    internal static IEndpointRouteBuilder MapAccountUpdateFcmTokenEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPatch("/update-fcm-token", AccountUpdateFcmToken)
            .RequireAuthorization();

        return routeGroupBuilder;
    }

    private static async Task<IResult> AccountUpdateFcmToken(AccountUpdateFcmTokenRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new AccountUpdateFcmTokenCommand
        {
            FcmToken = request.FcmToken,
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();
    }
}

public sealed record AccountUpdateFcmTokenRequest
{
    public string FcmToken { get; set; }
}
