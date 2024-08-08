using RRMS.Domain.Enums;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class Notification : AuditEntity
{
    public string Title { get; set; }
    public string Description { get; set; }
    public NotificationType Type { get; set; }

    public string UserId { get; set; }

    public User User { get; set; }
}
