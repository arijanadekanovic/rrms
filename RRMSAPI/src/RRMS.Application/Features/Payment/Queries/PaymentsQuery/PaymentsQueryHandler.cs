using MediatR;
using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;


namespace RRMS.Application.Features.Payment.Queries.PaymentsQuery
{
    public sealed class PaymentQueryHandler : IQueryHandler<PaymentsQuery, List<PaymentsQueryResult>>
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

        public async Task<Result<List<PaymentsQueryResult>>> Handle(PaymentsQuery request, CancellationToken cancellationToken)
        {
                var paymentsQuery = _databaseContext.Payments
                    .Include(p => p.Resident)
                    .ThenInclude(r => r.User)
                    .Include(p => p.Resident)
                    .ThenInclude(r => r.Residence)
                    //.Where(p => p.Resident.User.Id == _currentUser.Id)
                    .AsQueryable();

                if (request.ResidentId.HasValue)
                {
                    paymentsQuery = paymentsQuery.Where(p => p.ResidentId == request.ResidentId.Value);
                }

                if (request.FromDate.HasValue)
                {
                    paymentsQuery = paymentsQuery.Where(p => p.CreatedOnUtc >= request.FromDate.Value);
                }

                if (request.ToDate.HasValue)
                {
                    paymentsQuery = paymentsQuery.Where(p => p.CreatedOnUtc <= request.ToDate.Value);
                }

                var payments = await paymentsQuery.ToListAsync(cancellationToken);


                var paymentResults = payments.Select(p => new PaymentsQueryResult
                {
                    Amount = p.Amount,
                    ResidenceName = p.Resident.Residence.Name,
                    ResidentName = p.Resident.User.FirstName + " " + p.Resident.User.LastName,
                    PaymentDate = p.CreatedOnUtc
                }).ToList();

            return paymentResults;
        }
    }
}
