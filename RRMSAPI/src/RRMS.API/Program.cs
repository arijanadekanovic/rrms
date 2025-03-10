using RRMS.API.Configuration;
using RRMS.API.Endpoints;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Application.Abstractions.Services.ML;
using RRMS.Microservices.API.Configuration.Extensions;
using RRMS.Microservices.API.Middleware;

var builder = WebApplication.CreateBuilder(args);

// Postavite aplikaciju da koristi HTTP
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenAnyIP(5000); // HTTP port za aplikaciju
});

builder.ConfigureServices();

var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var databaseContext = scope.ServiceProvider.GetService<IDatabaseContext>();
    await MLService.StartTraining(databaseContext);
}

if (app.Environment.IsDevelopment())
{
    app.UseSwaggerApi("RRMS v1.0.0");
}

app.UseAuthorization();

app.UseMiddleware<GlobalExceptionHandlingMiddleware>();

app.MapApiEndpoints();

app.Run();
