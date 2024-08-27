using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record NotificationsQuery() : IQuery<List<NotificationQueryResult>> { }
