using Microsoft.AspNetCore.Http;
using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Storage.Application.Features.Storage.Commands.UploadCommand;

public sealed record UploadCommand : ICommand<UploadCommandResult>
{
    public IFormFile File { get; set; }
}
