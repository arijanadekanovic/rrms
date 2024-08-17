using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Domain.Entities;
using RRMS.Infrastructure.Persistance;

namespace DataSeeder.Seeders
{
    internal static class PaymentSeeder
    {
        internal static async Task Seed(IServiceProvider serviceProvider)
        {
            var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

            var residentUserId = await databaseContext.Users
               .Where(u => u.UserName == "resident")
               .Select(u => u.Id)
               .FirstOrDefaultAsync();

            if (residentUserId == null)
            {
                Console.WriteLine("Resident user not found. Skipping PaymentSeeder.");
                return;
            }

            var resident = await databaseContext.Residents
                .Where(r => r.UserId == residentUserId)
                .FirstOrDefaultAsync();

            if (resident == null)
            {
                Console.WriteLine("Resident not found. Skipping PaymentSeeder.");
                return;
            }

            for (int i = 0; i < 10; i++)
            {
                await databaseContext.Payments.AddAsync(new Payment
                {
                    Amount = 100 + i * 10,
                    ResidentId = resident.Id,
                    CreatedOnUtc = DateTime.Now.AddDays(-i)
                });
            }

            await databaseContext.SaveChangesAsync();

            Console.WriteLine("Payments seeded successfully.");
        }
    }
}
