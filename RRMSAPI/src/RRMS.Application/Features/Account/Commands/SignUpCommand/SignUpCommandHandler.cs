using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Domain.Entities;
using RRMS.Microservices.SharedKernel.Constants;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features.Account.Commands.SignUpCommand;

public sealed class SignUpCommandHandler : ICommandHandler<SignUpCommand>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly UserManager<User> _userManager;

    public SignUpCommandHandler
    (
        IDatabaseContext databaseContext,
        UserManager<User> userManager
    )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);
        ArgumentNullException.ThrowIfNull(userManager);

        _databaseContext = databaseContext;
        _userManager = userManager;
    }

    public async Task<Result> Handle(SignUpCommand request, CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();

        var requestRole = AppRoles.OpenValues.FirstOrDefault(x => x.ToLower() == request.Role.ToLower()) ?? AppRoles.Resident;

        var role = await _databaseContext.Roles.FirstOrDefaultAsync(x => x.Name == requestRole);

        var user = new User
        {
            Id = Guid.NewGuid().ToString(),
            FirstName = request.FirstName,
            LastName = request.LastName,
            UserName = request.Username,
            NormalizedUserName = request.Username.ToUpper(),
            Email = request.Email,
            NormalizedEmail = request.Email.ToUpper(),
            IsApproved = true,
            ProfilePhotoUrl = request.ProfilePhotoUrl,
            UserRoles = new List<UserRole>
            {
                new UserRole
                {
                    RoleId = role.Id,
                }
            }
        };

        await _userManager.CreateAsync(user, request.Password);
        await _databaseContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
