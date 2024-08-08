using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.Infrastructure.Extensions;

public static class EntityTypeBuilderExtensions
{
    public static EntityTypeBuilder<TEntity> ConfigureEntity<TEntity>(this EntityTypeBuilder<TEntity> builder)
        where TEntity : class, IEntity
    {
        builder
            .HasKey(x => x.Id);

        builder
            .Property(e => e.Id)
            .ValueGeneratedNever();

        return builder;
    }

    public static EntityTypeBuilder<TEntity> ConfigureEntityAuditableProperties<TEntity>(this EntityTypeBuilder<TEntity> builder)
        where TEntity : class, IAuditEntity
    {
        builder
           .Property(x => x.IsDeleted)
           .IsRequired()
           .HasDefaultValue(false);

        return builder;
    }
}
