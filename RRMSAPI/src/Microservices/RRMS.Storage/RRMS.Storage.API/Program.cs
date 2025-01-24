using RRMS.Microservices.API.Configuration.Extensions;
using RRMS.Microservices.API.Middleware;
using RRMS.Storage.API.Configuration;
using RRMS.Storage.API.Endpoints;

var builder = WebApplication.CreateBuilder(args);

// Postavite aplikaciju da koristi HTTP
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenAnyIP(5002); // HTTP port za aplikaciju
});

builder.ConfigureServices();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwaggerApi("RRMS Storage v1.0.0");
}

app.UseStaticFiles();

app.UseAuthorization();

app.UseMiddleware<GlobalExceptionHandlingMiddleware>();

app.MapApiEndpoints();

app.Run();
