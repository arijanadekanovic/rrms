using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using RRMS.Domain.Entities;

namespace RRMS.Infrastructure.Persistance.Configurations;

internal sealed class UserConfiguration : IEntityTypeConfiguration<User>
{
    private const string Table = "Users";

    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.ToTable(Table);
        builder.HasKey(x => x.Id);
        builder.HasMany(x => x.SentChatMessages).WithOne(x => x.Sender);
        builder.HasMany(x => x.ReceivedChatMessages).WithOne(x => x.Receiver);
    }
}
