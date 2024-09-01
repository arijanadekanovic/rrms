using MediatR;
using RRMS.Application.Features;
using RRMS.Domain.Entities;
using RRMS.Domain.Enums;

namespace RRMS.API.Endpoints.Payment;

internal static class PaymentsAddEndpoint
{
    internal static RouteGroupBuilder MapPaymentsAddEndpoint(this RouteGroupBuilder routeGroupBuilder)
    {
        routeGroupBuilder
         .MapPost("/add", Add)
         .RequireAuthorization();

        return routeGroupBuilder;
    }

    private static async Task<IResult> Add(PaymentAddRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new PaymentAddCommand
        {
            Amount = request.Amount,
            ResidentId = request.ResidentId,
            SlipUrl = request.SlipUrl,
            PaymentMethod = request.PaymentMethod
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();
    }
}

public class PaymentAddRequest
{
    public double Amount { get; set; }
    public int ResidentId { get; set; }
    public string SlipUrl { get; set; }
    public PaymentMethod PaymentMethod { get; set; }
}