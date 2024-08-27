using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Entities;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class ResidenceAddCommandHandler : ICommandHandler<ResidenceAddCommand>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public ResidenceAddCommandHandler
    (
        IDatabaseContext databaseContext,
        ICurrentUser currentUser
    )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);
        ArgumentNullException.ThrowIfNull(currentUser);

        _databaseContext = databaseContext;
        _currentUser = currentUser;
    }

    public async Task<Result> Handle(ResidenceAddCommand request, CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();

        var residence = new Residence
        {
            Name = request.Name,
            Description = request.Description,
            Address = request.Address,
            Rooms = request.Rooms,
            Size = request.Size,
            RentPrice = request.RentPrice,
            Type = request.Type,
            ThumbnailUrl = request.ThumbnailUrl,
            CityId = request.CityId,
            OwnerId = _currentUser.Id,
        };

        await _databaseContext.Residences.AddAsync(residence);
        await _databaseContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
