using RRMS.Storage.API.Endpoints.Storage.Builder;

namespace RRMS.Storage.API.Endpoints;

internal static class ApiEndpointsBuilder
{
    internal static void MapApiEndpoints(this IEndpointRouteBuilder endpointRouteBuilder)
    {
        var builder = endpointRouteBuilder.MapGroup("api");

        builder.MapStorageEndpoints().WithTags("Upload");

        builder.WithOpenApi();
    }
}
