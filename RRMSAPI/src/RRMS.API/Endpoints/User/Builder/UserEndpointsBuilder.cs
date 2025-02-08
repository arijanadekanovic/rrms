namespace RRMS.API.Endpoints.User.Builder;

internal static class UserEndpointsBuilder
{
    internal static RouteGroupBuilder MapUserEndpoints(this RouteGroupBuilder groupBuilder)
    {
        var routeGroupBuilder = groupBuilder
            .MapGroup("user");

        routeGroupBuilder
            .MapUsersEndpoint();

        return routeGroupBuilder;
    }
}
