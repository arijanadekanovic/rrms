namespace RRMS.API.Endpoints.Notification;

internal static class NotificationEndpointsBuilder
{
    internal static RouteGroupBuilder MapNotificationEndpoints(this RouteGroupBuilder routeGroupBuilder)
    {
        var notificationRouteGroupBuilder = routeGroupBuilder
            .MapGroup("notification");

        notificationRouteGroupBuilder
            .MapNotificationsEndpoint();

        return notificationRouteGroupBuilder;
    }
}
