using FluentValidation;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Application.Abstractions.Services.Identity;
using RRMS.Domain.Entities;
using RRMS.Domain.Errors;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features;

public sealed class SignInCommandHandler : ICommandHandler<SignInCommand, SignInCommandResult>
{
    private readonly IDatabaseContext _databaseContext;
    private readonly IAuthTokenGenerator _authTokenGenerator;
    private readonly IPasswordHasher<User> _passwordHasher;
    private readonly IValidator<SignInCommand> _validator;

    public SignInCommandHandler
    (
        IDatabaseContext databaseContext,
        IAuthTokenGenerator authTokenGenerator,
        IPasswordHasher<User> passwordHasher,
        IValidator<SignInCommand> validator
    )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);
        ArgumentNullException.ThrowIfNull(authTokenGenerator);
        ArgumentNullException.ThrowIfNull(passwordHasher);
        ArgumentNullException.ThrowIfNull(validator);

        _databaseContext = databaseContext;
        _authTokenGenerator = authTokenGenerator;
        _passwordHasher = passwordHasher;
        _validator = validator;
    }

    public async Task<Result<SignInCommandResult>> Handle(SignInCommand request, CancellationToken cancellationToken)
    {
        var normalizedEmailOrUsername = request.EmailOrUserName.ToUpper();

        var user = await _databaseContext.Users
            .Where(x => !x.IsDeleted)
            .Where(x => x.NormalizedEmail == normalizedEmailOrUsername || x.UserName == normalizedEmailOrUsername)
            .Include(x => x.UserClaims.Where(y => !y.IsDeleted))
            .Include(x => x.UserRoles.Where(y => !y.IsDeleted))
            .ThenInclude(x => x.Role)
            .FirstOrDefaultAsync();

        if (user is null)
        {
            return Result.Failure<SignInCommandResult>(UserDomainErrors.InvalidCredentials);
        }

        if (!user.IsApproved)
        {
            return Result.Failure<SignInCommandResult>(UserDomainErrors.AccountNotApproved);
        }

        var passwordVerificationResult = _passwordHasher.VerifyHashedPassword(user, user.PasswordHash, request.Password);

        if (passwordVerificationResult == PasswordVerificationResult.Failed)
        {
            return Result.Failure<SignInCommandResult>(UserDomainErrors.InvalidCredentials);
        }

        var refreshToken = await _authTokenGenerator.GenerateRefreshToken(user, cancellationToken);
        var accessToken = await _authTokenGenerator.GenerateAccessToken(user, cancellationToken);

        return new SignInCommandResult
        {
            AccessToken = accessToken,
            RefreshToken = refreshToken,
        };
    }
}
