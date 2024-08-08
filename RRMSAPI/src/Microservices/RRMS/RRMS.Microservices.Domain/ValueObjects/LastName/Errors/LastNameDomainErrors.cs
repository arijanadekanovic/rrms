using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.Account.Domain.ValueObjects.Email.Errors;

public static class LastNameDomainErrors
{
    public static readonly Error Empty = Error.Validation("LastName.Empty", "LastName is empty");
    public static readonly Error TooLong = Error.Validation("LastName.TooLong", "LastName is too long");
}
