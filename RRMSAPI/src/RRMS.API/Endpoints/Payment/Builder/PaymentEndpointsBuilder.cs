using RRMS.API.Endpoints.Residence;

namespace RRMS.API.Endpoints.Payment.Builder
{
    internal static class PaymentEndpointsBuilder
    {
        internal static RouteGroupBuilder MapResidenceEndpoints(this RouteGroupBuilder routeGroupBuilder)
        {
            var residenceRouteGroupBuilder = routeGroupBuilder
                .MapGroup("payment");

            residenceRouteGroupBuilder
                .MapResidenceDetailsEndpoint()
                .MapResidencesEndpoint();

            return residenceRouteGroupBuilder;
        }
    }
}
