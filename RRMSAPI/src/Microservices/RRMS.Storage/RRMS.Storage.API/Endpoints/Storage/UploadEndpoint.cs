using MediatR;
using Microsoft.AspNetCore.Mvc;
using RRMS.Storage.Application.Features.Storage.Commands.UploadCommand;

namespace RRMS.Storage.API.Endpoints.Storage;

internal static class UploadEndpoint
{
    internal static IEndpointRouteBuilder MapUploadEndpoint(this IEndpointRouteBuilder routeGroupBuilder)
    {
        routeGroupBuilder
            .MapPost("/upload", Upload)
            .DisableAntiforgery();

        return routeGroupBuilder;
    }

    private static async Task<IResult> Upload([FromForm] UploadRequest request, ISender sender, CancellationToken cancellationToken)
    {
        var command = new UploadCommand
        {
            File = request.File,
        };

        var result = await sender.Send(command, cancellationToken);

        return result.Match<IResult>
        (
            data => TypedResults.Ok(new UploadResponse
            {
                Url = data.Url
            }),
            TypedResults.BadRequest
        );
    }
}

public sealed record UploadRequest
{
    public IFormFile File { get; set; }
}

public sealed record UploadResponse
{
    public string Url { get; set; }
}
