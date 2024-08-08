using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;
using RRMS.Storage.Application.Abstractions.Services.Identity;

namespace RRMS.Storage.Application.Features.Storage.Commands.UploadCommand;

public sealed class UploadCommandHandler : ICommandHandler<UploadCommand, UploadCommandResult>
{
    private readonly IStorageService _storageService;

    public UploadCommandHandler
    (
        IStorageService storageService
    )
    {
        ArgumentNullException.ThrowIfNull(storageService);

        _storageService = storageService;
    }

    public async Task<Result<UploadCommandResult>> Handle(UploadCommand request, CancellationToken cancellationToken)
    {
        var storageItem = await _storageService.Save(request.File);

        return new UploadCommandResult
        {
            Url = storageItem.Url,
        };
    }
}
