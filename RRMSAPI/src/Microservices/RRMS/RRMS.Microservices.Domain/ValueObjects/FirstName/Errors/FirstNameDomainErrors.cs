using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.Account.Domain.ValueObjects.Email.Errors;

public static class FirstNameDomainErrors
{
    public static readonly Error Empty = Error.Validation("FirstName.Empty", "FirstName is empty");
    public static readonly Error TooLong = Error.Validation("FirstName.TooLong", "FirstName is too long");
}
