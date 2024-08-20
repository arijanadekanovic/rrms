namespace RRMS.API.Endpoints.City.Builder;

internal static class CityEndpointsBuilder
{
    internal static RouteGroupBuilder MapCityEndpoints(this RouteGroupBuilder groupBuilder)
    {
        var routeGroupBuilder = groupBuilder
            .MapGroup("city");

        routeGroupBuilder
            .MapCitiesEndpoint();

        return routeGroupBuilder;
    }
}
