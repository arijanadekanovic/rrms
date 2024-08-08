using Microsoft.AspNetCore.Identity;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class UserToken : IdentityUserToken<string>, IAuditEntity
{
    public int Id { get; set; }
    public string Token { get; set; }
    public string TokenType { get; set; }
    public DateTime? ExpiresOnUtc { get; set; }
    public DateTime? UsedOnUtc { get; set; }
    public bool IsValid { get; set; }

    public User User { get; set; }

    internal bool IsExpired => DateTime.UtcNow > ExpiresOnUtc;
    internal bool IsUsed => UsedOnUtc.HasValue;

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
