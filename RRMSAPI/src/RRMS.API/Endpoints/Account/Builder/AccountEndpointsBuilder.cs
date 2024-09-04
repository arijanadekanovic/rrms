namespace RRMS.API.Endpoints.Account.Builder;

internal static class AccountEndpointsBuilder
{
    internal static RouteGroupBuilder MapAccountEndpoints(this RouteGroupBuilder routeGroupBuilder)
    {
        var authRouteGroupBuilder = routeGroupBuilder
            .MapGroup("account");

        authRouteGroupBuilder
            .MapAccountDeleteEndpoint()
            .MapAccountDetailsEndpoint()
            .MapAccountUpdateEndpoint()
            .MapAccountUpdateFcmTokenEndpoint()
            .MapSignUpEndpoint();

        return authRouteGroupBuilder;
    }
}
