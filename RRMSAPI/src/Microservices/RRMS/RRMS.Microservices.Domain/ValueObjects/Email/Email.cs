using RRMS.Microservices.Account.Domain.ValueObjects.Email.Errors;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.Account.Domain.ValueObjects.Email;

public sealed class Email : ValueObject
{
    private Email(string value)
    {
        Value = value;
    }

    public string Value { get; }

    public static Result<Email> Create(string value)
    {
        if (string.IsNullOrWhiteSpace(value))
        {
            return Result.Failure<Email>(EmailDomainErrors.Empty);
        }

        if (value.Split('@').Length != 2)
        {
            return Result.Failure<Email>(EmailDomainErrors.InvalidFormat);
        }

        return new Email(value);
    }

    public override IEnumerable<object> GetAtomicValues()
    {
        yield return Value;
    }
}
