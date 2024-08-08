using DataSeeder.Configuration.Extensions;
using DataSeeder.Seeders;
using Microsoft.Extensions.DependencyInjection;

var services = new ServiceCollection();

services
    .AddLogging()
    .ConfigureDatabase()
    .ConfigureIdentity();

var serviceProvider = services.BuildServiceProvider();

await SeedManager.Seed(serviceProvider);

