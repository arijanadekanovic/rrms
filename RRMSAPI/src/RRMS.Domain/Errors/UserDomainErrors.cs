using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Errors;

public static class UserDomainErrors
{
    public static readonly Error InvalidCredentials = Error.Validation("User.InvalidCredentials", "Invalid credentials");
    public static readonly Error AccountNotApproved = Error.Validation("User.AccountNotApproved", "Account is not approved");
    public static readonly Error InvalidRefreshToken = Error.Validation("User.InvalidToken", "Invalid refresh token");
    public static readonly Error NotFound = Error.Validation("User.NotFound", "User not found");
    public static readonly Error InvalidRole = Error.Validation("User.InvalidRole", "Invalid role");
}
