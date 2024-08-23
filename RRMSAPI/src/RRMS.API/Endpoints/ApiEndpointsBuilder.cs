using RRMS.API.Endpoints.Account.Builder;
using RRMS.API.Endpoints.Auth.Builder;
using RRMS.API.Endpoints.City.Builder;
using RRMS.API.Endpoints.Notification;
using RRMS.API.Endpoints.Payment.Builder;
using RRMS.API.Endpoints.Residence.Builder;
using RRMS.API.Endpoints.Resident.Builder;

namespace RRMS.API.Endpoints;

internal static class ApiEndpointsBuilder
{
    internal static void MapApiEndpoints(this IEndpointRouteBuilder endpointRouteBuilder)
    {
        var builder = endpointRouteBuilder.MapGroup("api");

        builder.MapAccountEndpoints().WithTags("Account");
        builder.MapAuthEndpoints().WithTags("Auth");
        builder.MapCityEndpoints().WithTags("City");
        builder.MapNotificationEndpoints().WithTags("Notification");
        builder.MapPaymentEndpoints().WithTags("Payment");
        builder.MapResidenceEndpoints().WithTags("Residence");
        builder.MapResidentEndpoints().WithTags("Resident");

        builder.WithOpenApi();
    }
}
