using System.Text.Json;
using FluentValidation;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using RRMS.Microservices.SharedKernel.Exceptions;

namespace RRMS.Microservices.API.Middleware;

public class GlobalExceptionHandlingMiddleware(RequestDelegate next)
{
    public async Task InvokeAsync(HttpContext context, ILogger<GlobalExceptionHandlingMiddleware> logger)
    {
        try
        {
            await next(context);
        }
        catch (Exception exception)
        {
            logger.LogError("Error Occured {e}", new { e = exception });

            var problemDetails = GetProblemDetails(exception);

            if (exception is ValidationException && (exception as ValidationException).Errors is not null)
            {
                problemDetails.Extensions["errors"] = (exception as ValidationException).Errors;
            }

            context.Response.ContentType = "application/problem+json";
            context.Response.StatusCode = problemDetails.Status!.Value;

            var response = JsonSerializer.Serialize(problemDetails);

            await context.Response.WriteAsync(response);
        }
    }

    private static ProblemDetails GetProblemDetails(Exception ex) => ex switch
    {
        NotFoundException => new ValidationProblemDetails()
        {
            Status = StatusCodes.Status404NotFound
        },
        ValidationException x => new ProblemDetails
        {
            Status = StatusCodes.Status400BadRequest,
            Type = "ValidationFailure",
            Title = "Validation error",
            Detail = "One or more validation errors has occurred",
        },
        _ => new ProblemDetails
        {
            Title = "An unhandled exception has occurred",
            Detail = ex.Message,
            Status = StatusCodes.Status500InternalServerError
        }
    };
}
