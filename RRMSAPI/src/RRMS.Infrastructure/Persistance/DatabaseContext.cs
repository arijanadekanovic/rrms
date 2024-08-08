using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Entities;
using RRMS.Microservices.Infrastructure.Extensions;
using RRMS.Microservices.SharedKernel.Persistance;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Infrastructure.Persistance;

public class DatabaseContext : DbContext, IDatabaseContext
{
    public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options) { }

    public DbSet<ChatMessage> ChatMessages { get; set; }
    public DbSet<City> Cities { get; set; }
    public DbSet<MaintenanceRequest> MaintenanceRequests { get; set; }
    public DbSet<Notification> Notifications { get; set; }
    public DbSet<Payment> Payments { get; set; }
    public DbSet<Residence> Residences { get; set; }
    public DbSet<ResidenceDocument> ResidenceDocuments { get; set; }
    public DbSet<ResidenceImage> ResidenceImages { get; set; }
    public DbSet<ResidenceInspection> ResidenceInspections { get; set; }
    public DbSet<Resident> Residents { get; set; }
    public DbSet<ResidentDocument> ResidentDocuments { get; set; }
    public DbSet<ResidentFeedback> ResidentFeedbacks { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<Role> Roles { get; set; }
    public DbSet<UserRole> UserRoles { get; set; }
    public DbSet<UserClaim> UserClaims { get; set; }
    public DbSet<OutboxMessage> OutboxMessages { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.ApplyConfigurationsFromAssembly(typeof(DatabaseContext).Assembly);

        modelBuilder.SetQueryFilterOnAllEntities<IAuditEntity>(x => !x.IsDeleted);
    }
}

