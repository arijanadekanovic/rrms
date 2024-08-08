using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using RRMS.Microservices.SharedKernel.Persistance;

namespace RRMS.Microservices.Infrastructure.Persistance.Configurations;

internal sealed class OutboxMessageConfiguration : IEntityTypeConfiguration<OutboxMessage>
{
    private const string Table = "OutboxMessages";

    public void Configure(EntityTypeBuilder<OutboxMessage> builder)
    {
        builder.ToTable(Table);

        builder.HasKey(x => x.Id);
    }
}
