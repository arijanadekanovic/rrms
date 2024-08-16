using MediatR;
using RRMS.Application.Features.Payment.Queries.PaymentsQuery;
using RRMS.Domain.Entities;

namespace RRMS.API.Endpoints.Payment
{
    internal static class PaymentsEndpoint
    {
        internal static RouteGroupBuilder MapPaymentEndpoints(this RouteGroupBuilder routeGroupBuilder)
        {
            var paymentRouteGroupBuilder = routeGroupBuilder
                .MapGroup("payment");
            paymentRouteGroupBuilder
                .MapGet("/payments", Payments)
                //.RequireAuthorization()
                .Produces<List<PaymentsResponse>>();

            return paymentRouteGroupBuilder;
        }

        private static async Task<IResult> Payments([AsParameters] PaymentsRequest request, ISender sender, CancellationToken cancellationToken)
        {
            var query = new PaymentsQuery
            {
                ResidentId = request.ResidentId,
                //ResidenceId = request.ResidenceId,
                FromDate = request.FromDate,
                ToDate = request.ToDate
            };

            var result = await sender.Send(query, cancellationToken);

            return result.ToHttpResult
            (
                x => x.Select(p => new PaymentsResponse
                {
                    Amount = p.Amount,
                    ResidenceName = p.ResidenceName,
                    ResidentName = p.ResidentName,
                    PaymentDate = p.PaymentDate
                }).ToList()
            );
        }

    }
}

public record PaymentsResponse
{
    public double Amount { get; set; }
    public string ResidenceName { get; set; }
    public string ResidentName { get; set; }
    public DateTime PaymentDate { get; set; }
}
public class PaymentsRequest
{
    public int? ResidentId { get; set; }
    //public int? ResidenceId { get; set; }
    public DateTime? FromDate { get; set; }
    public DateTime? ToDate { get; set; }
}
