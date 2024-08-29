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
        await SeedLandlords(serviceProvider);
        await SeedResidents(serviceProvider);
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

    internal static async Task SeedLandlords(IServiceProvider serviceProvider)
    {
        var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

        var profilePictureUrls = new List<string>
        {
            "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA4L2pvYjExMjAtZWxlbWVudC0xOS5wbmc.png",
            "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA4L2pvYjEwMzQtZWxlbWVudC0wNS0zODUucG5n.png",
            "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA4L2pvYjEwMzQtZWxlbWVudC0wNy00MDMucG5n.png",
            "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAxLzI3OS1wYWkxNTc5LW5hbS1qb2IxNTI5LnBuZw.png",
        };

        for (var i = 0; i < profilePictureUrls.Count; i++)
        {
            var user = new User
            {
                Id = Guid.NewGuid().ToString(),
                FirstName = "Land",
                LastName = $"Lord {i}",
                UserName = $"landlord{i}",
                NormalizedUserName = $"landlord{i}".ToUpper(),
                Email = $"landlord{i}@rrms.com",
                NormalizedEmail = $"landlord{i}@rrms.com".ToUpper(),
                EmailConfirmed = true,
                PhoneNumber = $"+3876155944{i}",
                PhoneNumberConfirmed = true,
                TwoFactorEnabled = false,
                IsApproved = true,
                ProfilePhotoUrl = profilePictureUrls[i],
            };

            var role = await databaseContext.Roles.FirstOrDefaultAsync(x => x.Name == AppRoles.Landlord);

            await SeedUser(serviceProvider, user, role);
        }
    }

    internal static async Task SeedResidents(IServiceProvider serviceProvider)
    {
        var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

        var profilePictureUrls = new List<string>
        {
            "https://photos.peopleimages.com/picture/202306/2833489-shot-of-a-young-man-looking-unsure-against-isolated-on-png-background-fit_400_400.jpg",
            "https://photos.peopleimages.com/picture/202306/2831326-studio-shot-of-a-well-dressed-man-isolated-on-a-png-background-fit_400_400.jpg",
            "https://photos.peopleimages.com/picture/202306/2831360-studio-shot-of-a-handsome-and-well-dressed-young-man-isolated-on-a-png-background-fit_400_400.jpg",
            "https://image.pngaaa.com/922/1151922-small.png",
        };

        for (var i = 0; i < profilePictureUrls.Count; i++)
        {
            var user = new User
            {
                Id = Guid.NewGuid().ToString(),
                FirstName = "Resi",
                LastName = $"Dent {i}",
                UserName = $"resident{i}",
                NormalizedUserName = $"resident{i}".ToUpper(),
                Email = $"resident{i}@rrms.com",
                NormalizedEmail = $"resident{i}@rrms.com".ToUpper(),
                EmailConfirmed = true,
                PhoneNumber = $"+3876133423{i}",
                PhoneNumberConfirmed = true,
                TwoFactorEnabled = false,
                IsApproved = true,
                ProfilePhotoUrl = profilePictureUrls[i],
            };

            var role = await databaseContext.Roles.FirstOrDefaultAsync(x => x.Name == AppRoles.Resident);

            await SeedUser(serviceProvider, user, role);
        }
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
