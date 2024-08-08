using Microsoft.EntityFrameworkCore;
using RRMS.Microservices.SharedKernel.Persistance;

namespace RRMS.Microservices.Application.Abstractions.Persistance;

public interface IBaseDatabaseContext : IDisposable
{
    DbSet<OutboxMessage> OutboxMessages { get; set; }

    DbSet<TEntity> Set<TEntity>() where TEntity : class;

    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
}
