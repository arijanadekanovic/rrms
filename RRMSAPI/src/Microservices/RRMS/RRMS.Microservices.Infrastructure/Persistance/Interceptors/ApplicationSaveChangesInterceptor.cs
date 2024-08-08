using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using RRMS.Microservices.Application.Abstractions.Services.Identity;

namespace RRMS.Microservices.Infrastructure.Persistence.Interceptors;

public abstract class ApplicationSaveChangesInterceptor : SaveChangesInterceptor
{
    protected readonly ICurrentUser CurrentUser;

    public ApplicationSaveChangesInterceptor
    (
        ICurrentUser currentUser
    )
    {
        ArgumentNullException.ThrowIfNull(currentUser);

        CurrentUser = currentUser;
    }

    public override ValueTask<InterceptionResult<int>> SavingChangesAsync(DbContextEventData eventData, InterceptionResult<int> result,
        CancellationToken cancellationToken = default)
    {
        var databaseContext = eventData.Context;

        if (databaseContext is null)
        {
            return base.SavingChangesAsync(eventData, result, cancellationToken);
        }

        AuditRecords(databaseContext);

        return base.SavingChangesAsync(eventData, result, cancellationToken);
    }

    public override InterceptionResult<int> SavingChanges(DbContextEventData eventData, InterceptionResult<int> result)
    {
        var databaseContext = eventData.Context;

        if (databaseContext is null)
        {
            return base.SavingChanges(eventData, result);
        }

        AuditRecords(databaseContext);

        return base.SavingChanges(eventData, result);
    }

    protected abstract void AuditRecords(DbContext context);
}
