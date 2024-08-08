using Microsoft.EntityFrameworkCore;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.Infrastructure.Persistence.Interceptors;

public class OnUpdateAuditInterceptor : ApplicationSaveChangesInterceptor
{
    public OnUpdateAuditInterceptor(ICurrentUser currentUser) : base(currentUser) { }

    protected override void AuditRecords(DbContext context)
    {
        var entityEntries = context
            .ChangeTracker
            .Entries<IAuditEntity>()
            .Where(x => x.State == EntityState.Modified);

        foreach (var entityEntry in entityEntries)
        {
            entityEntry.Property(x => x.ModifiedBy).CurrentValue = CurrentUser.Id;
            entityEntry.Property(x => x.ModifiedOnUtc).CurrentValue = DateTime.UtcNow;
        }
    }
}
