using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Entities;
using RRMS.Domain.Errors;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class PaymentAddCommandHandler : ICommandHandler<PaymentAddCommand>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public PaymentAddCommandHandler(
        IDatabaseContext databaseContext,
        UserManager<User> userManager,
        ICurrentUser currentUser,
        IHttpContextAccessor httpContextAccessor)
    {
        ArgumentNullException.ThrowIfNull(databaseContext);
        ArgumentNullException.ThrowIfNull(userManager);
        ArgumentNullException.ThrowIfNull(httpContextAccessor);

        _databaseContext = databaseContext;
        _currentUser = currentUser;
    }

    public async Task<Result> Handle(PaymentAddCommand request, CancellationToken cancellationToken)
    {
        var resident = await _databaseContext.Residents
            .Where(r => r.Id == request.ResidentId)
            .Where(r => r.UserId == _currentUser.Id)
            .FirstOrDefaultAsync();

        if (resident == null)
        {
            return Result.Failure(ResidentDomainErrors.NotFound);
        }

        var payment = new Payment
        {
            Amount = request.Amount,
            ResidentId = resident.Id,
            SlipUrl = request.SlipUrl,
            PayPalPaymentId = request.PayPalPaymentId,
            PaymentMethod = request.PaymentMethod,
        };

        _databaseContext.Payments.Add(payment);
        await _databaseContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
