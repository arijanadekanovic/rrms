using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;
using RRMS.Storage.Application.Abstractions.Services.Identity;

namespace RRMS.Storage.Application.Features.Storage.Commands.DeleteCommand;

public sealed class DeleteCommandHandler : ICommandHandler<DeleteCommand, DeleteCommandResult>
{
    private readonly IStorageService _storageService;

    public DeleteCommandHandler
    (
        IStorageService storageService
    )
    {
        ArgumentNullException.ThrowIfNull(storageService);

        _storageService = storageService;
    }

    public async Task<Result<DeleteCommandResult>> Handle(DeleteCommand request, CancellationToken cancellationToken)
    {
        await _storageService.DeleteByUrl(request.Url);

        return new DeleteCommandResult
        {
            Url = request.Url,
        };
    }
}
