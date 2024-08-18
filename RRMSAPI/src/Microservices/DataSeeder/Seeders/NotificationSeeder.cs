using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Domain.Entities;
using RRMS.Domain.Enums;
using RRMS.Infrastructure.Persistance;

namespace DataSeeder.Seeders;

internal static class NotificationSeeder
{
    internal static async Task Seed(IServiceProvider serviceProvider)
    {
        var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

        var users = await databaseContext.Users.ToListAsync();


        foreach (var user in users)
        {
            for (var i = 0; i < 7; i++)
            {
                var type = RandomNotificationType();

                var notification = new Notification
                {
                    UserId = user.Id,
                    Title = $"Notification title ({type.ToString()})",
                    Description = $"Description of the notification ({type.ToString()})",
                    Type = type,
                };

                await databaseContext.Notifications.AddAsync(notification);
            }
        }

        await databaseContext.SaveChangesAsync();
    }

    private static NotificationType RandomNotificationType()
    {
        var values = Enum.GetValues(typeof(NotificationType)).Cast<NotificationType>().ToList();
        var random = new Random();
        return values[random.Next(values.Count)];
    }
}
