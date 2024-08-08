using Microsoft.EntityFrameworkCore;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.Infrastructure.Persistence.Interceptors;

public class OnDeleteAuditInterceptor : ApplicationSaveChangesInterceptor
{
    public OnDeleteAuditInterceptor(ICurrentUser currentUser) : base(currentUser) { }

    protected override void AuditRecords(DbContext context)
    {
        var entityEntries = context
            .ChangeTracker
            .Entries<IAuditEntity>()
            .Where(x => x.State == EntityState.Deleted);

        foreach (var entityEntry in entityEntries)
        {
            entityEntry.Property(x => x.DeletedBy).CurrentValue = CurrentUser.Id;
            entityEntry.Property(x => x.DeletedOnUtc).CurrentValue = DateTime.UtcNow;
            entityEntry.Property(x => x.IsDeleted).CurrentValue = true;
            entityEntry.State = EntityState.Modified;
        }
    }
}
