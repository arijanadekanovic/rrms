using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.Account.Domain.ValueObjects.Email.Errors;

public static class EmailDomainErrors
{
    public static readonly Error Empty = Error.Validation("Email.Empty", "Email is empty");
    public static readonly Error InvalidFormat = Error.Validation("Email.InvalidFormat", "Email has invalid format");
}
