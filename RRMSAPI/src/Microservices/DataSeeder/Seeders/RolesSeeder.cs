using Microsoft.Extensions.DependencyInjection;
using RRMS.Domain.Entities;
using RRMS.Infrastructure.Persistance;
using RRMS.Microservices.SharedKernel.Constants;

namespace DataSeeder.Seeders;

internal static class RolesSeeder
{
    internal static async Task Seed(IServiceProvider serviceProvider)
    {
        var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

        await databaseContext.Roles.AddRangeAsync(AppRoles.Values.Select(roleName => new Role
        {
            Id = Guid.NewGuid().ToString(),
            Name = roleName,
            NormalizedName = roleName.ToUpper()
        }).ToList());

        await databaseContext.SaveChangesAsync();
    }
}
