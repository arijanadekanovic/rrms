using Microsoft.EntityFrameworkCore;

namespace DataSeeder.Seeders;

public static class Seeder
{
    public static async Task RunAsync(
        Func<IServiceProvider, Task> seedMethod,
        IServiceProvider serviceProvider,
        DbContext databaseContext
        )
    {
        await using var transaction = await databaseContext.Database.BeginTransactionAsync();

        try
        {
            Console.WriteLine("Connecting to database via AccountDatabaseContext");

            if (!await databaseContext.Database.CanConnectAsync())
            {
                throw new Exception("Cannot connect to the database");
            }

            Console.WriteLine("Seeding data");

            await seedMethod(serviceProvider);

            await transaction.CommitAsync();

            Console.WriteLine("Finished seeding data");
        }
        catch (Exception e)
        {
            await transaction.RollbackAsync();

            Console.WriteLine("Error while seeding data");
            Console.WriteLine(e.ToString());
        }
    }
}
