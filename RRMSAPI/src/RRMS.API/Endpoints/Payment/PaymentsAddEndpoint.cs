using MediatR;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using RRMS.Application.Features.Payment.Commands.PaymentsAddCommand;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.API.Endpoints.Payment;

internal static class PaymentsAddEndpoint
{
    internal static RouteGroupBuilder MapPaymentsAddEndpoint(this RouteGroupBuilder routeGroupBuilder)
    {
        routeGroupBuilder
         .MapPost("/payments/process", ProcessPayment)
         .RequireAuthorization()
         .Produces<ProcessPaymentCommand>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> ProcessPayment( ProcessPaymentRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new PaymentAddCommand
        {
            Amount = request.Amount,
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();

    }
}

public class ProcessPaymentRequest
{
    public double Amount { get; set; }
}

public record ProcessPaymentCommand 
{
    public double Amount { get; set; }
    public int ResidentId { get; set; }
}
