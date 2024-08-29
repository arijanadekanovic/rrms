using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record ChatGroupsQuery() : IQuery<List<ChatGroupQueryResult>> { }
