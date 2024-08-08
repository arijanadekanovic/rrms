using Microsoft.EntityFrameworkCore;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.Infrastructure.Persistence.Interceptors;

public class OnCreateAuditInterceptor : ApplicationSaveChangesInterceptor
{
    public OnCreateAuditInterceptor(ICurrentUser currentUser) : base(currentUser) { }

    protected override void AuditRecords(DbContext context)
    {
        var entityEntries = context
            .ChangeTracker
            .Entries<IAuditEntity>()
            .Where(x => x.State == EntityState.Added);

        foreach (var entityEntry in entityEntries)
        {
            entityEntry.Property(x => x.CreatedBy).CurrentValue = CurrentUser.Id;
            entityEntry.Property(x => x.CreatedOnUtc).CurrentValue = DateTime.UtcNow;
        }
    }
}
