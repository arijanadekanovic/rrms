namespace RRMS.Storage.API.Endpoints.Storage.Builder;

internal static class StorageEndpointsBuilder
{
    internal static RouteGroupBuilder MapStorageEndpoints(this RouteGroupBuilder routeGroupBuilder)
    {
        var authRouteGroupBuilder = routeGroupBuilder
            .MapGroup("storage");

        authRouteGroupBuilder
            .MapUploadEndpoint();

        return authRouteGroupBuilder;
    }
}
