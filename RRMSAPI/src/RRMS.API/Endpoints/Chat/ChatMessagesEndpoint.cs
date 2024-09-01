using MediatR;
using RRMS.Application.Features;

namespace RRMS.API.Endpoints.Chat;

internal static class ChatMessagesEndpoint
{
    internal static IEndpointRouteBuilder MapChatMessagesEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/chat-messages", ChatMessages)
            .RequireAuthorization()
            .Produces<ChatMessagesResponse>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> ChatMessages([AsParameters] ChatMessagesSearchRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var query = new ChatMessagesQuery
        {
            ChatPartnerId = request.ChatPartnerId,
            ResidenceId = request.ResidenceId,
        };

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => new ChatMessagesResponse
            {
                ResidenceId = x.ResidenceId,
                ChatPartnerId = x.ChatPartnerId,
                ChatPartnerProfilePictureUrl = x.ChatPartnerProfilePictureUrl,
                ChatPartnerName = x.ChatPartnerName,
                ChatMessages = x.ChatMessages.Select(y => new ChatMessageResponse
                {
                    Message = y.Message,
                    MessageDateTimeUtc = y.MessageDateTimeUtc,
                    IsMyMessage = y.IsMyMessage,
                    ProfilePhotoUrl = y.ProfilePhotoUrl,
                }).ToList(),
            }
        );
    }
}

public record ChatMessagesSearchRequest
{
    public int ResidenceId { get; set; }
    public string ChatPartnerId { get; set; }
}

public record ChatMessagesResponse
{
    public int ResidenceId { get; set; }
    public string ChatPartnerId { get; set; }
    public string ChatPartnerProfilePictureUrl { get; set; }
    public string ChatPartnerName { get; set; }
    public List<ChatMessageResponse> ChatMessages { get; set; }
}

public record ChatMessageResponse
{
    public string Message { get; set; }
    public DateTime MessageDateTimeUtc { get; set; }
    public bool IsMyMessage { get; set; }
    public string ProfilePhotoUrl { get; set; }
}
