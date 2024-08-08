using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Domain.Entities;
using RRMS.Infrastructure.Persistance;
using RRMS.Microservices.SharedKernel.Constants;

namespace DataSeeder.Seeders;

internal static class UsersSeeder
{
    internal static async Task Seed(IServiceProvider serviceProvider)
    {
        await SeedSuperAdmin(serviceProvider);
        await SeedLandlord(serviceProvider);
        await SeedResident(serviceProvider);
    }

    internal static async Task SeedSuperAdmin(IServiceProvider serviceProvider)
    {
        var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

        var user = new User
        {
            Id = Guid.NewGuid().ToString(),
            FirstName = "Super",
            LastName = "Admin",
            UserName = "superadmin",
            NormalizedUserName = "superadmin".ToUpper(),
            Email = "superadmin@rrms.com",
            NormalizedEmail = "superadmin@rrms.com".ToUpper(),
            EmailConfirmed = true,
            PhoneNumber = "+38761234567",
            PhoneNumberConfirmed = true,
            TwoFactorEnabled = false,
            IsApproved = true,
            ProfilePhotoUrl = "https://clipart-library.com/images/8i6oer5KT.png",
        };

        var role = await databaseContext.Roles.FirstOrDefaultAsync(x => x.Name == AppRoles.SuperAdmin);

        await SeedUser(serviceProvider, user, role);
    }

    internal static async Task SeedLandlord(IServiceProvider serviceProvider)
    {
        var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

        var user = new User
        {
            Id = Guid.NewGuid().ToString(),
            FirstName = "Land",
            LastName = "Lord",
            UserName = "landlord",
            NormalizedUserName = "landlord".ToUpper(),
            Email = "landlord@rrms.com",
            NormalizedEmail = "landlord@rrms.com".ToUpper(),
            EmailConfirmed = true,
            PhoneNumber = "+38761559444",
            PhoneNumberConfirmed = true,
            TwoFactorEnabled = false,
            IsApproved = true,
            ProfilePhotoUrl = "https://cdn-icons-png.flaticon.com/512/219/219969.png",
        };

        var role = await databaseContext.Roles.FirstOrDefaultAsync(x => x.Name == AppRoles.Landlord);

        await SeedUser(serviceProvider, user, role);
    }

    internal static async Task SeedResident(IServiceProvider serviceProvider)
    {
        var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

        var user = new User
        {
            Id = Guid.NewGuid().ToString(),
            FirstName = "Resi",
            LastName = "Dent",
            UserName = "resident",
            NormalizedUserName = "resident".ToUpper(),
            Email = "resident@rrms.com",
            NormalizedEmail = "resident@rrms.com".ToUpper(),
            EmailConfirmed = true,
            PhoneNumber = "+38761334234",
            PhoneNumberConfirmed = true,
            TwoFactorEnabled = false,
            IsApproved = true,
            ProfilePhotoUrl = "https://icons.veryicon.com/png/o/internet--web/web-interface-flat/6606-male-user.png",
        };

        var role = await databaseContext.Roles.FirstOrDefaultAsync(x => x.Name == AppRoles.Resident);

        await SeedUser(serviceProvider, user, role);
    }

    internal static async Task SeedUser(IServiceProvider serviceProvider, User user, Role role, string password = "demo")
    {
        var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();
        var userManager = serviceProvider.GetRequiredService<UserManager<User>>();

        if (role != null)
        {
            user.UserRoles = new List<UserRole> { new UserRole { RoleId = role.Id.ToString() } };
        }

        await databaseContext.Users.AddAsync(user);
        await databaseContext.SaveChangesAsync();

        await userManager.AddPasswordAsync(user, password);
        await databaseContext.SaveChangesAsync();
    }
}
