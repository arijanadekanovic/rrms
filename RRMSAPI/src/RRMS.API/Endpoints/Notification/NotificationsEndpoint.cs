using MediatR;
using RRMS.Application.Features.Residence.Queries.NotificationsQuery;
using RRMS.Domain.Enums;

namespace RRMS.API.Endpoints.Notification;

internal static class NotificationsEndpoint
{
    internal static IEndpointRouteBuilder MapNotificationsEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapGet("/notifications", Notifications)
            .RequireAuthorization()
            .Produces<List<NotificationResponse>>();

        return routeGroupBuilder;
    }

    private static async Task<IResult> Notifications(ISender sender, CancellationToken cancellationToken)
    {
        var query = new NotificationsQuery { };

        var result = await sender.Send(query, cancellationToken);

        return result.ToHttpResult
        (
            x => x.Select(x => new NotificationResponse
            {
                Id = x.Id,
                Title = x.Title,
                Description = x.Description,
                Type = x.Type,
            }).ToList()
        );
    }
}

public record NotificationResponse
{
    public int Id { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public NotificationType Type { get; set; }

}
