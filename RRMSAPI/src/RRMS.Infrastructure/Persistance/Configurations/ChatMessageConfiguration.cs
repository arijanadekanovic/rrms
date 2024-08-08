using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using RRMS.Domain.Entities;

namespace RRMS.Infrastructure.Persistance.Configurations;

internal sealed class ChatMessageConfiguration : IEntityTypeConfiguration<ChatMessage>
{
    private const string Table = "ChatMessages";

    public void Configure(EntityTypeBuilder<ChatMessage> builder)
    {
        builder.ToTable(Table);
        builder.HasKey(x => x.Id);
        builder.HasOne(x => x.Sender).WithMany(x => x.SentChatMessages).HasForeignKey(x => x.SenderId);
        builder.HasOne(x => x.Receiver).WithMany(x => x.ReceivedChatMessages).HasForeignKey(x => x.ReceiverId);
    }
}
