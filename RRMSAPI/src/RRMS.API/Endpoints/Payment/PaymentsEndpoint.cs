using MediatR;
using RRMS.Application.Features;
using RRMS.Domain.Enums;

namespace RRMS.API.Endpoints.Payment;

internal static class PaymentsEndpoint
{
    internal static RouteGroupBuilder MapPaymentsEndpoint(this RouteGroupBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/payments", Payments)
            .RequireAuthorization()
            .Produces<List<PaymentResponse>>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> Payments(ISender sender, CancellationToken cancellationToken)
    {
        var query = new PaymentsQuery {};

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => x.Select(y => new PaymentResponse
            {
                Amount = y.Amount,
                ResidenceName = y.ResidenceName,
                ResidentName = y.ResidentName,
                PaymentDateUtc = y.PaymentDateUtc,
                PaymentMethod = y.PaymentMethod,
                SlipUrl = y.SlipUrl,
            }).ToList()
        );
    }

}

public record PaymentResponse
{
    public double Amount { get; set; }
    public string ResidenceName { get; set; }
    public string ResidentName { get; set; }
    public DateTime PaymentDateUtc { get; set; }
    public string SlipUrl { get; set; }
    public PaymentMethod PaymentMethod { get; set; }
}