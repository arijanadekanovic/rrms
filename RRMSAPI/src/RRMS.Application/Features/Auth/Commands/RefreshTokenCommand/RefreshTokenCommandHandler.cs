using RRMS.Application.Abstractions.Services.Identity;
using RRMS.Domain.Errors;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Features.Auth.Commands.RefreshTokenCommand;

public sealed class RefreshTokenCommandHandler : ICommandHandler<RefreshTokenCommand, RefreshTokenCommandResult>
{
    private readonly IAuthTokenGenerator _authTokenGenerator;

    public RefreshTokenCommandHandler
    (
        IAuthTokenGenerator authTokenGenerator
    )
    {
        ArgumentNullException.ThrowIfNull(authTokenGenerator);

        _authTokenGenerator = authTokenGenerator;
    }

    public async Task<Result<RefreshTokenCommandResult>> Handle(RefreshTokenCommand request, CancellationToken cancellationToken)
    {
        var userResult = await _authTokenGenerator.GetUserByRefreshToken(request.Token, cancellationToken);

        if (userResult.IsFailure)
        {
            return Result.Failure<RefreshTokenCommandResult>(UserDomainErrors.InvalidRefreshToken);
        }

        var refreshToken = await _authTokenGenerator.GenerateRefreshToken(userResult.Value, cancellationToken);
        var accessToken = await _authTokenGenerator.GenerateAccessToken(userResult.Value, cancellationToken);

        return new RefreshTokenCommandResult
        {
            AccessToken = accessToken,
            RefreshToken = refreshToken,
        };
    }
}
