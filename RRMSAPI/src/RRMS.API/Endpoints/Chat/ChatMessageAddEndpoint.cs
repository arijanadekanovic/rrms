using MediatR;
using RRMS.Application.Features;

namespace RRMS.API.Endpoints.Chat;

internal static class ChatMessageAddEndpoint
{
    internal static IEndpointRouteBuilder MapChatMessageAddEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPost("/add", ChatMessageAdd)
            .RequireAuthorization();

        return routeGroupBuilder;
    }

    private static async Task<IResult> ChatMessageAdd(ChatMessageAddRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new ChatMessageAddCommand
        {
            ChatPartnerId = request.ChatPartnerId,
            MessageText = request.MessageText,
            ResidenceId = request.ResidenceId,
        };

        var result = await sender.Send(command, cancellationToken);

        return result.ToHttpResult();
    }
}

public sealed record ChatMessageAddRequest
{
    public string ChatPartnerId { get; set; }
    public string MessageText { get; set; }
    public int ResidenceId { get; set; }
}
