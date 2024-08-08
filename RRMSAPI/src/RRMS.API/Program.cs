using RRMS.API.Configuration;
using RRMS.API.Endpoints;
using RRMS.Microservices.API.Configuration.Extensions;
using RRMS.Microservices.API.Middleware;

var builder = WebApplication.CreateBuilder(args);

builder.ConfigureServices();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwaggerApi("RRMS v1.0.0");
}
else
{
    app
        .UseHsts()
        .UseHttpsRedirection();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.UseMiddleware<GlobalExceptionHandlingMiddleware>();

app.MapApiEndpoints();

app.Run();
