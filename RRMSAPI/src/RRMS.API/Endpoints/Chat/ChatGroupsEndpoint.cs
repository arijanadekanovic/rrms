using MediatR;
using RRMS.Application.Features;

namespace RRMS.API.Endpoints.Chat;

internal static class ChatGroupsEndpoint
{
    internal static IEndpointRouteBuilder MapChatGroupsEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/chat-groups", ChatGroups)
            .RequireAuthorization()
            .Produces<List<ChatGroupResponse>>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> ChatGroups(ISender sender, CancellationToken cancellationToken)
    {
        var query = new ChatGroupsQuery { };

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => x.Select(x => new ChatGroupResponse
            {
                ResidenceId = x.ResidenceId,
                ChatPartnerId = x.ChatPartnerId,
                ChatPartnerProfilePictureUrl = x.ChatPartnerProfilePictureUrl,
                ChatPartnerName = x.ChatPartnerName,
                LastMessage = x.LastMessage,
                LastMessageDateTimeUtc = x.LastMessageDateTimeUtc,
                Seen = x.Seen,
            }).ToList()
        );
    }
}

public record ChatGroupResponse
{
    public int ResidenceId { get; set; }
    public string ChatPartnerId { get; set; }
    public string ChatPartnerProfilePictureUrl { get; set; }
    public string ChatPartnerName { get; set; }
    public string LastMessage { get; set; }
    public DateTime LastMessageDateTimeUtc { get; set; }
    public bool Seen { get; set; }
}
