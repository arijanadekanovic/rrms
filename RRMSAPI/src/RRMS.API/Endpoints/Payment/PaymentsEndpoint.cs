using MediatR;
using RRMS.Application.Features.Payment.Queries.PaymentsQuery;

namespace RRMS.API.Endpoints.Payment
{
    internal static class PaymentsEndpoint
    {
        internal static RouteGroupBuilder MapPaymentsEndpoints(this RouteGroupBuilder routeGroupBuilder)
        {
            routeGroupBuilder
                .MapGet("/payments", Payments)
                .RequireAuthorization()
                .Produces<List<PaymentResponse>>();

            return routeGroupBuilder;
        }

        private static async Task<IResult> Payments([AsParameters] PaymentsRequest request, ISender sender, CancellationToken cancellationToken)
        {
            var query = new PaymentsQuery
            {
                FromDateUtc = request.FromDateUtc,
                ToDateUtc = request.ToDateUtc
            };

            var result = await sender.Send(query, cancellationToken);

            return result.ToHttpResult
            (
                x => x.Select(y => new PaymentResponse
                {
                    Amount = y.Amount,
                    ResidenceName = y.ResidenceName,
                    ResidentName = y.ResidentName,
                    PaymentDateUtc = y.PaymentDateUtc
                }).ToList()
            );
        }

    }
}

public class PaymentsRequest
{
    public DateTime? FromDateUtc { get; set; }
    public DateTime? ToDateUtc { get; set; }
}

public record PaymentResponse
{
    public double Amount { get; set; }
    public string ResidenceName { get; set; }
    public string ResidentName { get; set; }
    public DateTime PaymentDateUtc { get; set; }
}

