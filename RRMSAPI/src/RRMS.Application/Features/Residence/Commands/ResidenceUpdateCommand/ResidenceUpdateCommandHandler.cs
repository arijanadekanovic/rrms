using MassTransit;
using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Errors;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;
using RRMS.Microservices.Transport.Messages.Account.ProfilePhotoChanged;

namespace RRMS.Application.Features;

public sealed class ResidenceUpdateCommandHandler : ICommandHandler<ResidenceUpdateCommand>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;
    private readonly IPublishEndpoint _publishEndpoint;

    public ResidenceUpdateCommandHandler
    (
        IDatabaseContext databaseContext,
        ICurrentUser currentUser,
        IPublishEndpoint publishEndpoint
    )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);
        ArgumentNullException.ThrowIfNull(currentUser);
        ArgumentNullException.ThrowIfNull(publishEndpoint);

        _databaseContext = databaseContext;
        _currentUser = currentUser;
        _publishEndpoint = publishEndpoint;
    }

    public async Task<Result> Handle(ResidenceUpdateCommand request, CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();

        var residence = await _databaseContext.Residences.FirstOrDefaultAsync(x => x.Id == request.Id);

        if (residence == null)
        {
            return Result.Failure(ResidenceDomainErrors.NotFound);
        }

        if (residence.OwnerId != _currentUser.Id)
        {
            return Result.Failure(ResidenceDomainErrors.NotOwner);
        }

        var photoChanged = residence.ThumbnailUrl != request.ThumbnailUrl;
        var oldPhotoUrl = residence.ThumbnailUrl;

        residence.Name = request.Name;
        residence.Description = request.Description;
        residence.Address = request.Address;
        residence.Rooms = request.Rooms;
        residence.Size = request.Size;
        residence.RentPrice = request.RentPrice;
        residence.Type = request.Type;
        residence.ThumbnailUrl = request.ThumbnailUrl;
        residence.CityId = request.CityId;

        await _databaseContext.SaveChangesAsync(cancellationToken);

        if (photoChanged)
        {
            await _publishEndpoint.Publish(new ResidenceThumbnailChangedMessage
            {
                OldUrl = oldPhotoUrl,
            });
        }

        return Result.Success();
    }
}
