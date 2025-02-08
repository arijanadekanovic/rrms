using MediatR;
using RRMS.Application.Features;

namespace RRMS.API.Endpoints.User;

internal static class UsersEndpoint
{
    internal static IEndpointRouteBuilder MapUsersEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/users", Users)
            //.RequireAuthorization()
            .Produces<List<UserResponse>>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> Users(ISender sender, CancellationToken cancellationToken)
    {
        var query = new UsersQuery { };

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => x.Select(x => new UserResponse
            {
                Id = x.Id,
                FullName = x.FullName,
            }).ToList()
        );
    }
}

public record UserResponse
{
    public string Id { get; set; }
    public string FullName { get; set; }
}
