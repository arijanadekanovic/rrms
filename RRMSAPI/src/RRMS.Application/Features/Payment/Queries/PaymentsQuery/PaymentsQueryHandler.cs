﻿using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;


namespace RRMS.Application.Features.Payment.Queries.PaymentsQuery
{
    public sealed class PaymentQueryHandler : IQueryHandler<PaymentsQuery, List<PaymentQueryResult>>
    {
        private readonly IDatabaseContext _databaseContext;
        private readonly ICurrentUser _currentUser;
        public PaymentQueryHandler
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

        public async Task<Result<List<PaymentQueryResult>>> Handle(PaymentsQuery request, CancellationToken cancellationToken)
        {
            var payments = await _databaseContext.Payments
                .Where(x => x.Resident.User.Id == _currentUser.Id)
                .Where(x => request.FromDateUtc == null || x.CreatedOnUtc >= request.FromDateUtc)
                .Where(x => request.ToDateUtc == null || x.CreatedOnUtc <= request.ToDateUtc)
                .Include(x => x.Resident)
                .ThenInclude(x => x.User)
                .Include(x => x.Resident)
                .ThenInclude(x => x.Residence)
                .ToListAsync(cancellationToken);

            return payments.Select(p => new PaymentQueryResult
            {
                Amount = p.Amount,
                ResidenceName = p.Resident.Residence.Name,
                ResidentName = $"{p.Resident.User.FirstName} {p.Resident.User.LastName}",
                PaymentDateUtc = p.CreatedOnUtc
            }).ToList();
        }
    }
}