using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features.City.Queries.CitiesQuery;

public sealed class CitiesQueryHandler : IQueryHandler<CitiesQuery, List<CityQueryResult>>
{
    private readonly IDatabaseContext _databaseContext;

    public CitiesQueryHandler
    (
        IDatabaseContext databaseContext
    )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);

        _databaseContext = databaseContext;
    }

    public async Task<Result<List<CityQueryResult>>> Handle(CitiesQuery request, CancellationToken cancellationToken)
    {
        var cities = await _databaseContext.Cities.ToListAsync();

        return cities.Select(x => new CityQueryResult
        {
            Id = x.Id,
            Name = x.Name,
        }).ToList();
    }
}
