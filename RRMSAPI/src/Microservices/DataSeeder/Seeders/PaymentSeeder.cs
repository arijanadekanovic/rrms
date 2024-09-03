using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Domain.Entities;
using RRMS.Domain.Enums;
using RRMS.Infrastructure.Persistance;

namespace DataSeeder.Seeders
{
    internal static class PaymentSeeder
    {
        internal static async Task Seed(IServiceProvider serviceProvider)
        {
            var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

            var residents = await databaseContext.Residents
               .Where(x => x.Status == ResidentStatus.Active)
               .ToListAsync();

            foreach (var resident in residents)
            {
                await databaseContext.Payments.AddAsync(new Payment
                {
                    Amount = resident.Residence.RentPrice,
                    ResidentId = resident.Id,
                    PaymentMethod = PaymentMethod.PayPal,
                });

                await databaseContext.Payments.AddAsync(new Payment
                {
                    Amount = resident.Residence.RentPrice,
                    ResidentId = resident.Id,
                    PaymentMethod = PaymentMethod.Slip,
                    SlipUrl = "https://tourism.gov.in/sites/default/files/2019-04/dummy-pdf_2.pdf",
                });
            }

            await databaseContext.SaveChangesAsync();

            Console.WriteLine("Payments seeded successfully.");
        }
    }
}
