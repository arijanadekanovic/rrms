using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Account.Domain.ValueObjects.Email.Errors;

public static class AuthTokenGeneratorErrors
{
    public static readonly Error Invalid = Error.Validation("AuthTokenGenerator.Invalid", "Token is invalid");
}
