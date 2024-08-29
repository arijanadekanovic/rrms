using DataSeeder.Configuration.Extensions;
using DataSeeder.Seeders;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Microservices.Infrastructure.Configuration.Extensions;

var services = new ServiceCollection();

services
    .AddLogging()
    .ConfigureCurrentUser()
    .ConfigureDatabase()
    .ConfigureIdentity();

var serviceProvider = services.BuildServiceProvider();

await SeedManager.Seed(serviceProvider);

