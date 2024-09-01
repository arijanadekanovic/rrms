using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features;

public sealed record ChatMessagesQuery() : IQuery<ChatMessagesQueryResult>
{
    public string ChatPartnerId { get; set; }
    public int ResidenceId { get; set; }
}
