using Microsoft.Extensions.DependencyInjection;
using RRMS.Domain.Entities;
using RRMS.Infrastructure.Persistance;

namespace DataSeeder.Seeders;

internal static class CitySeeder
{
    internal static async Task Seed(IServiceProvider serviceProvider)
    {
        var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

        await databaseContext.Cities.AddAsync(new City { Name = "New York" });
        await databaseContext.Cities.AddAsync(new City { Name = "Boston" });
        await databaseContext.Cities.AddAsync(new City { Name = "Seattle" });
        await databaseContext.Cities.AddAsync(new City { Name = "Washington" });
        await databaseContext.Cities.AddAsync(new City { Name = "Chicago" });
        await databaseContext.Cities.AddAsync(new City { Name = "New Jersey" });
        await databaseContext.Cities.AddAsync(new City { Name = "Los Angeles" });

        await databaseContext.SaveChangesAsync();
    }
}
