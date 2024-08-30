namespace RRMS.API.Endpoints.Payment.Builder
{
    internal static class PaymentEndpointsBuilder
    {
        internal static RouteGroupBuilder MapPaymentEndpoints(this RouteGroupBuilder routeGroupBuilder)
        {
            var paymentRouteGroupBuilder = routeGroupBuilder
                .MapGroup("payment");

            paymentRouteGroupBuilder
                .MapPaymentsEndpoint()
                .MapPaymentsAddEndpoint();

            return paymentRouteGroupBuilder;
        }
    }
}
