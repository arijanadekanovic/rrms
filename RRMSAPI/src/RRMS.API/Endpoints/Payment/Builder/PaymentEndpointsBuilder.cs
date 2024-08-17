namespace RRMS.API.Endpoints.Payment.Builder
{
    internal static class PaymentEndpointsBuilder
    {
        internal static RouteGroupBuilder MapPaymentEndpoints(this RouteGroupBuilder routeGroupBuilder)
        {
            var residenceRouteGroupBuilder = routeGroupBuilder
                .MapGroup("payment");

            residenceRouteGroupBuilder
                .MapPaymentsEndpoints();

            return residenceRouteGroupBuilder;
        }
    }
}
