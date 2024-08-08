using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using RRMS.Account.Domain.ValueObjects.Email.Errors;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Application.Abstractions.Services.Identity;
using RRMS.Domain.Entities;
using RRMS.Microservices.Infrastructure.Options;
using RRMS.Microservices.SharedKernel.Constants;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Infrastructure.Services.Identity.AccessTokenGenerator;

public class AuthTokenGenerator : IAuthTokenGenerator
{
    private readonly IDatabaseContext _databaseContext;
    private readonly AccessTokenOptions _accessTokenOptions;
    private readonly RefreshTokenOptions _refreshTokenOptions;

    public AuthTokenGenerator(
        IDatabaseContext databaseContext,
        IOptions<AccessTokenOptions> accessTokenOptions,
        IOptions<RefreshTokenOptions> refreshTokenOptions
        )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);
        ArgumentNullException.ThrowIfNull(accessTokenOptions);
        ArgumentNullException.ThrowIfNull(refreshTokenOptions);

        _databaseContext = databaseContext;
        _accessTokenOptions = accessTokenOptions.Value;
        _refreshTokenOptions = refreshTokenOptions.Value;
    }

    public ValueTask<string> GenerateAccessToken(User user, CancellationToken cancellationToken)
    {
        // Ensure the operation can be canceled
        cancellationToken.ThrowIfCancellationRequested();

        // Create a list of claims from the user details
        var claims = new List<Claim>
        {
            new(AppClaimTypes.Id, user.Id.ToString()),
            new(AppClaimTypes.Name, $"{user.FirstName} {user.LastName}"),
            new(AppClaimTypes.Email, user.Email),
            new(AppClaimTypes.Username, user.UserName)
        };

        // Add role claims
        claims.AddRange(user.UserRoles.Select(x => new Claim(AppClaimTypes.Role, x.Role.Name)));

        // Add additional user claims
        claims.AddRange(user.UserClaims.Select(x => new Claim(x.ClaimType, x.ClaimValue)).ToList());

        return GenerateToken(
            claims,
            _accessTokenOptions.SecurityKey,
            _accessTokenOptions.Issuer,
            _accessTokenOptions.Audience,
            _accessTokenOptions.DurationInSeconds,
            cancellationToken
        );
    }

    public ValueTask<string> GenerateRefreshToken(User user, CancellationToken cancellationToken)
    {
        // Ensure the operation can be canceled
        cancellationToken.ThrowIfCancellationRequested();

        // Create a list of claims from the user details
        var claims = new List<Claim>
        {
            new(AppClaimTypes.Id, user.Id.ToString()),
        };

        return GenerateToken(
            claims,
            _refreshTokenOptions.SecurityKey,
            _refreshTokenOptions.Issuer,
            _refreshTokenOptions.Audience,
            _refreshTokenOptions.DurationInSeconds,
            cancellationToken
        );
    }

    public async Task<Result<User>> GetUserByRefreshToken(string refreshToken, CancellationToken cancellationToken)
    {
        // Ensure the operation can be canceled
        cancellationToken.ThrowIfCancellationRequested();

        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.ASCII.GetBytes(_refreshTokenOptions.SecurityKey);

        try
        {
            var principal = tokenHandler.ValidateToken(refreshToken, new TokenValidationParameters
            {
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(key),
                ValidateIssuer = false,
                ValidateAudience = false,
                ClockSkew = TimeSpan.Zero
            }, out _);

            var userId = principal.FindFirstValue(AppClaimTypes.Id);

            var user = await _databaseContext.Users.FirstOrDefaultAsync(x => x.Id == userId, cancellationToken);

            return Result.Success(user);
        }
        catch
        {
            return Result.Failure<User>(AuthTokenGeneratorErrors.Invalid);
        }
    }

    private static ValueTask<string> GenerateToken(List<Claim> claims, string securityKey, string issuer, string audience, long durationInSeconds, CancellationToken cancellationToken)
    {
        // Ensure the operation can be canceled
        cancellationToken.ThrowIfCancellationRequested();

        // Create the token handler and key
        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.ASCII.GetBytes(securityKey);

        // Define the token descriptor
        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(claims),
            IssuedAt = DateTime.UtcNow,
            Issuer = issuer,
            Audience = audience,
            Expires = DateTime.UtcNow.AddSeconds(durationInSeconds),
            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature),
        };

        // Create and write the token
        var token = tokenHandler.CreateToken(tokenDescriptor);
        var tokenString = tokenHandler.WriteToken(token);

        // Return the token as a ValueTask
        return ValueTask.FromResult(tokenString);
    }
}
