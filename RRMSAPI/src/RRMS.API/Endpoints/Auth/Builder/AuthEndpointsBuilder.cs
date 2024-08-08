namespace RRMS.API.Endpoints.Auth.Builder;

internal static class AuthEndpointsBuilder
{
    internal static RouteGroupBuilder MapAuthEndpoints(this RouteGroupBuilder routeGroupBuilder)
    {
        var authRouteGroupBuilder = routeGroupBuilder
            .MapGroup("auth");

        authRouteGroupBuilder
            .MapRefreshTokenEndpoint()
            .MapSignInEndpoint();

        return authRouteGroupBuilder;
    }
}
