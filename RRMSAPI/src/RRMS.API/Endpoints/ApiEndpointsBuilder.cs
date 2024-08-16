using RRMS.API.Endpoints.Account.Builder;
using RRMS.API.Endpoints.Auth.Builder;
using RRMS.API.Endpoints.Payment;
using RRMS.API.Endpoints.Residence.Builder;

namespace RRMS.API.Endpoints;

internal static class ApiEndpointsBuilder
{
    internal static void MapApiEndpoints(this IEndpointRouteBuilder endpointRouteBuilder)
    {
        var builder = endpointRouteBuilder.MapGroup("api");

        builder.MapAccountEndpoints().WithTags("Account");
        builder.MapAuthEndpoints().WithTags("Auth");
        builder.MapResidenceEndpoints().WithTags("Residence");
        builder.MapPaymentEndpoints().WithTags("Payments");
        builder.WithOpenApi();
    }
}
