using Microsoft.AspNetCore.Identity;

namespace RRMS.Domain.Entities;

public sealed class Role : IdentityRole<string>
{
    public List<UserRole> UserRoles { get; set; }
}
