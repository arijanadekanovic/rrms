using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.Residence.Queries.NotificationsQuery;

public sealed record NotificationsQuery() : IQuery<List<NotificationQueryResult>> { }
