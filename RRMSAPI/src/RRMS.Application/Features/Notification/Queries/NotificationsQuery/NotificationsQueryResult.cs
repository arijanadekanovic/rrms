using RRMS.Domain.Enums;

namespace RRMS.Application.Features;

public sealed record NotificationQueryResult
{
    public int Id { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public NotificationType Type { get; set; }
}
