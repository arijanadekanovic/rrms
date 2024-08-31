using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Errors;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class ResidenceDetailsQueryHandler : IQueryHandler<ResidenceDetailsQuery, ResidenceDetailsQueryResult>
{
    private readonly IDatabaseContext _databaseContext;

    public ResidenceDetailsQueryHandler
    (
        IDatabaseContext databaseContext
    )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);

        _databaseContext = databaseContext;
    }

    public async Task<Result<ResidenceDetailsQueryResult>> Handle(ResidenceDetailsQuery request, CancellationToken cancellationToken)
    {
        var residence = await _databaseContext.Residences
            .Where(x => !x.IsDeleted)
            .Include(x => x.City)
            .FirstOrDefaultAsync(x => x.Id == request.Id);

        if (residence == null)
        {
            return Result.Failure<ResidenceDetailsQueryResult>(ResidenceDomainErrors.NotFound);
        }

        return new ResidenceDetailsQueryResult
        {
            Id = residence.Id,
            Name = residence.Name,
            Description = residence.Description,
            Address = residence.Address,
            Rooms = residence.Rooms,
            Size = residence.Size,
            RentPrice = residence.RentPrice,
            Type = residence.Type,
            ThumbnailUrl = residence.ThumbnailUrl,
            OwnerId = residence.OwnerId,
            City = new ResidenceDetailsCityQueryResult
            {
                Id = residence.City.Id,
                Name = residence.City.Name,
            }
        };
    }
}
