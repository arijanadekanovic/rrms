using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Domain.Entities;
using RRMS.Infrastructure.Persistance;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;

namespace DataSeeder.Seeders
{
    internal static class PaymentSeeder
    {

        internal static async Task Seed(IServiceProvider serviceProvider)
        {
            var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();
            var residentUser = await databaseContext.Users
               .Where(u => u.UserName == "resident")
               .Select(u => u.Id)
               .FirstOrDefaultAsync();

            if (residentUser == null)
            {
                Console.WriteLine("Resident user not found. Skipping PaymentSeeder.");
                return;
            }

            var resident = await databaseContext.Residents
                .Where(r => r.UserId == residentUser)
                .FirstOrDefaultAsync();

            if (resident == null)
            {
                Console.WriteLine("Resident not found. Skipping PaymentSeeder.");
                return;
            }

            var payments = new List<Payment>();
            for (int i = 0; i < 10; i++)
            {
                payments.Add(new Payment
                {
                    Amount = 100 + i * 10,
                    ResidentId = 1,
                    CreatedOnUtc = DateTime.Now.AddDays(-i)
                });
            }

            databaseContext.Payments.AddRange(payments);
            await databaseContext.SaveChangesAsync();
            Console.WriteLine("Payments seeded successfully.");
        }
    }
}
