using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class ChatMessage : AuditEntity
{
    public string Text { get; set; }
    public bool Seen { get; set; }

    public int ResidenceId { get; set; }
    public string SenderId { get; set; }
    public string ReceiverId { get; set; }

    public Residence Residence { get; set; }
    public User Sender { get; set; }
    public User Receiver { get; set; }
}
