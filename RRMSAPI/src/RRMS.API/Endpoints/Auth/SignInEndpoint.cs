using MediatR;
using RRMS.Application.Features.Auth.Commands.SignInCommand;

namespace RRMS.API.Endpoints.Auth;

internal static class SignInEndpoint
{
    internal static IEndpointRouteBuilder MapSignInEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPost("/sign-in", SignIn)
            .AllowAnonymous()
            .Produces<SignInResponse>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> SignIn(SignInRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new SignInCommand
        {
            EmailOrUserName = request.EmailOrUserName,
            Password = request.Password
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult
        (
            x => new SignInResponse
            {
                AccessToken = x.AccessToken,
                RefreshToken = x.RefreshToken
            }
        );
    }
}

public sealed record SignInRequest
{
    public string EmailOrUserName { get; set; }
    public string Password { get; set; }
}

public sealed record SignInResponse
{
    public string AccessToken { get; set; }
    public string RefreshToken { get; set; }
}
