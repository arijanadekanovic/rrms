namespace RRMS.API.Endpoints.Resident.Builder;

internal static class ResidentEndpointsBuilder
{
    internal static RouteGroupBuilder MapResidentEndpoints(this RouteGroupBuilder routeGroupBuilder)
    {
        var residenceRouteGroupBuilder = routeGroupBuilder
            .MapGroup("resident");

        residenceRouteGroupBuilder
            .MapResidentsEndpoint();

        return residenceRouteGroupBuilder;
    }
}
