namespace RRMS.API.Endpoints.Chat.Builder;

internal static class ChatEndpointsBuilder
{
    internal static RouteGroupBuilder MapChatEndpoints(this RouteGroupBuilder groupBuilder)
    {
        var routeGroupBuilder = groupBuilder
            .MapGroup("chat");

        routeGroupBuilder
            .MapChatGroupsEndpoint();

        return routeGroupBuilder;
    }
}
