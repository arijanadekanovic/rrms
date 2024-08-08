using Microsoft.EntityFrameworkCore;
using RRMS.Domain.Entities;
using RRMS.Microservices.Application.Abstractions.Persistance;

namespace RRMS.Application.Abstractions.Persistance;

public interface IDatabaseContext : IBaseDatabaseContext
{
    DbSet<ChatMessage> ChatMessages { get; set; }
    DbSet<City> Cities { get; set; }
    DbSet<MaintenanceRequest> MaintenanceRequests { get; set; }
    DbSet<Notification> Notifications { get; set; }
    DbSet<Payment> Payments { get; set; }
    DbSet<Residence> Residences { get; set; }
    DbSet<ResidenceDocument> ResidenceDocuments { get; set; }
    DbSet<ResidenceImage> ResidenceImages { get; set; }
    DbSet<ResidenceInspection> ResidenceInspections { get; set; }
    DbSet<Resident> Residents { get; set; }
    DbSet<ResidentDocument> ResidentDocuments { get; set; }
    DbSet<ResidentFeedback> ResidentFeedbacks { get; set; }
    DbSet<User> Users { get; set; }
    DbSet<Role> Roles { get; set; }
    DbSet<UserRole> UserRoles { get; set; }
    DbSet<UserClaim> UserClaims { get; set; }
}
