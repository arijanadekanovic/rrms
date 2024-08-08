using RRMS.Domain.Entities;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Application.Abstractions.Services.Identity;

public interface IAuthTokenGenerator
{
    ValueTask<string> GenerateAccessToken(User user, CancellationToken cancellationToken);
    ValueTask<string> GenerateRefreshToken(User user, CancellationToken cancellationToken);
    Task<Result<User>> GetUserByRefreshToken(string refreshToken, CancellationToken cancellationToken);
}
