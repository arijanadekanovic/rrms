using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Entities;
using RRMS.Microservices.Application.Abstractions.Services.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;
using System.Security.Claims;

namespace RRMS.Application.Features.Payment.Commands.PaymentsAddCommand;

public sealed class PaymentsAddCommandHandler : ICommandHandler<PaymentAddCommand>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly ICurrentUser _currentUser;

    public PaymentsAddCommandHandler(
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

    public async Task<Result> Handle (PaymentAddCommand request, CancellationToken cancellationToken)
    {
        var userId = _currentUser.Id;

        if (string.IsNullOrEmpty(userId))
        {
            throw new Exception("User not found");
        }

        var resident = await _databaseContext.Residents
            .Include(r => r.User)
            .FirstOrDefaultAsync(r => r.User.Id == userId, cancellationToken);

        if (resident == null)
        {
            throw new Exception ("Resident not found.");
        }

        var payment = new RRMS.Domain.Entities.Payment
        {
            Amount = request.Amount,
            ResidentId = resident.Id,
            CreatedOnUtc = DateTime.UtcNow
        };

        _databaseContext.Payments.Add(payment);
        await _databaseContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
