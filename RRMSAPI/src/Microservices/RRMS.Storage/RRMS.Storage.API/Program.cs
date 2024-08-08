using RRMS.Microservices.API.Configuration.Extensions;
using RRMS.Microservices.API.Middleware;
using RRMS.Storage.API.Configuration;
using RRMS.Storage.API.Endpoints;

var builder = WebApplication.CreateBuilder(args);

builder.ConfigureServices();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwaggerApi("RRMS Storage v1.0.0");
}
else
{
    app
        .UseHsts()
        .UseHttpsRedirection();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseAuthorization();

app.UseMiddleware<GlobalExceptionHandlingMiddleware>();

app.MapApiEndpoints();

app.Run();
