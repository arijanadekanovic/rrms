namespace RRMS.API.Endpoints.Residence.Builder;

internal static class ResidenceEndpointsBuilder
{
    internal static RouteGroupBuilder MapResidenceEndpoints(this RouteGroupBuilder routeGroupBuilder)
    {
        var residenceRouteGroupBuilder = routeGroupBuilder
            .MapGroup("residence");

        residenceRouteGroupBuilder
            .MapResidenceAddEndpoint()
            .MapResidenceDeleteEndpoint()
            .MapResidenceDetailsEndpoint()
            .MapResidencesEndpoint()
            .MapResidencesHistoryEndpoint()
            .MapResidencesRecommendationEndpoint()
            .MapResidenceUpdateEndpoint();

        return residenceRouteGroupBuilder;
    }
}
