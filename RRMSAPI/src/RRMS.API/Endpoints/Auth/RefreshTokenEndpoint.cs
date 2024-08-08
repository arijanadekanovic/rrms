using MediatR;
using RRMS.Application.Features.Auth.Commands.RefreshTokenCommand;

namespace RRMS.API.Endpoints.Auth;

internal static class RefreshTokenEndpoint
{
    internal static IEndpointRouteBuilder MapRefreshTokenEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPost("/refresh-token", RefreshToken)
            .AllowAnonymous()
            .Produces<RefreshTokenResponse>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> RefreshToken(RefreshTokenRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new RefreshTokenCommand
        {
            Token = request.Token
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult
        (
            x => new RefreshTokenResponse
            {
                AccessToken = x.AccessToken,
                RefreshToken = x.RefreshToken,
            }
        );
    }
}

public sealed record RefreshTokenRequest
{
    public string Token { get; set; }
}

public sealed record RefreshTokenResponse
{
    public string AccessToken { get; set; }
    public string RefreshToken { get; set; }
}
