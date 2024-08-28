using MediatR;
using RRMS.Application.Features;

namespace RRMS.API.Endpoints.Account;

internal static class SignUpEndpoint
{
    internal static IEndpointRouteBuilder MapSignUpEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPost("/sign-up", SignUp)
            .AllowAnonymous();

        return routeGroupBuilder;
    }

    private static async Task<IResult> SignUp(SignUpRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new SignUpCommand
        {
            Email = request.Email,
            Username = request.Username,
            Password = request.Password,
            FirstName = request.FirstName,
            LastName = request.LastName,
            Role = request.Role,
            ProfilePhotoUrl = request.ProfilePhotoUrl,
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();
    }
}

public sealed record SignUpRequest
{
    public string Email { get; set; }
    public string Username { get; set; }
    public string Password { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Role { get; set; }
    public string ProfilePhotoUrl { get; set; }
}
