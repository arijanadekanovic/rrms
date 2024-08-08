using RRMS.Microservices.Account.Domain.ValueObjects.Email.Errors;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.Account.Domain.ValueObjects.LastName;

public sealed class LastName : ValueObject
{
    public const int MaxLength = 50;

    private LastName(string value)
    {
        Value = value;
    }

    public string Value { get; }

    public static Result<LastName> Create(string value)
    {
        if (string.IsNullOrWhiteSpace(value))
        {
            return Result.Failure<LastName>(LastNameDomainErrors.Empty);
        }

        if (value.Length > MaxLength)
        {
            return Result.Failure<LastName>(LastNameDomainErrors.TooLong);
        }

        return new LastName(value);
    }

    public override IEnumerable<object> GetAtomicValues()
    {
        yield return Value;
    }
}
