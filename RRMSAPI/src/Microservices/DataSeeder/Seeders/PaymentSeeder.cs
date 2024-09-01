using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Domain.Entities;
using RRMS.Domain.Enums;
using RRMS.Infrastructure.Persistance;
using RRMS.Microservices.SharedKernel.Constants;

namespace DataSeeder.Seeders
{
    internal static class PaymentSeeder
    {
        internal static async Task Seed(IServiceProvider serviceProvider)
        {
            var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

            var residentUsersId = await databaseContext.Residents
               .Select(u => u.Id)
               .ToListAsync();

            if (residentUsersId == null)
            {
                Console.WriteLine("Residents not found. Skipping PaymentSeeder.");
                return;
            }

            foreach (var residentUserId in residentUsersId) 
            {
                for (int i = 0; i < 5; i++)
                {
                    await databaseContext.Payments.AddAsync(new Payment
                    {
                        Amount = 100 + i * 10,
                        ResidentId = residentUserId,
                        PaymentMethod = PaymentMethod.PayPal,
                    });
                } 
                
                for (int i = 5; i < 10; i++)
                {
                    await databaseContext.Payments.AddAsync(new Payment
                    {
                        Amount = 100 + i * 10,
                        ResidentId = residentUserId,
                        PaymentMethod = PaymentMethod.Slip,
                        SlipUrl = "https://tourism.gov.in/sites/default/files/2019-04/dummy-pdf_2.pdf",
                    });
                }
            }

            await databaseContext.SaveChangesAsync();

            Console.WriteLine("Payments seeded successfully.");
        }
    }
}
