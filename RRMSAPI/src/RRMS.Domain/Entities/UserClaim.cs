using Microsoft.AspNetCore.Identity;using RRMS.Microservices.SharedKernel.Primitives;
namespace RRMS.Domain.Entities;

public sealed class UserClaim : IdentityUserClaim<string>, IAuditEntity
{
    public User User { get; set; }

    #region AuditEntity

    public string CreatedBy { get; set; }
    public DateTime CreatedOnUtc { get; set; }
    public string ModifiedBy { get; set; }
    public DateTime? ModifiedOnUtc { get; set; }
    public string DeletedBy { get; set; }
    public DateTime? DeletedOnUtc { get; set; }
    public bool IsDeleted { get; set; }

    #endregion 
}
