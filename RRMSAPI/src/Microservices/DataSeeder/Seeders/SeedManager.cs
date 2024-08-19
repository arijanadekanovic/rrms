using Microsoft.Extensions.DependencyInjection;
using RRMS.Infrastructure.Persistance;

namespace DataSeeder.Seeders;

internal static class SeedManager
{
    internal static async Task Seed(IServiceProvider serviceProvider)
    {
        try
        {
            var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

            await databaseContext.Database.EnsureDeletedAsync();
            await databaseContext.Database.EnsureCreatedAsync();

            await Seeder.RunAsync(RolesSeeder.Seed, serviceProvider, databaseContext);
            await Seeder.RunAsync(UsersSeeder.Seed, serviceProvider, databaseContext);
            await Seeder.RunAsync(CitySeeder.Seed, serviceProvider, databaseContext);
            await Seeder.RunAsync(ResidenceSeeder.Seed, serviceProvider, databaseContext);
            await Seeder.RunAsync(PaymentSeeder.Seed, serviceProvider, databaseContext);
            await Seeder.RunAsync(NotificationSeeder.Seed, serviceProvider, databaseContext);
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
        }
    }
}
