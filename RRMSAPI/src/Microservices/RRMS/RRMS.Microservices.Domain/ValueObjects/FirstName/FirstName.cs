using RRMS.Microservices.Account.Domain.ValueObjects.Email.Errors;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.Account.Domain.ValueObjects.FirstName;

public sealed class FirstName : ValueObject
{
    public const int MaxLength = 50;

    private FirstName(string value) => Value = value;

    public string Value { get; }

    public static Result<FirstName> Create(string value)
    {
        if (string.IsNullOrWhiteSpace(value))
        {
            return Result.Failure<FirstName>(FirstNameDomainErrors.Empty);
        }

        if (value.Length > MaxLength)
        {
            return Result.Failure<FirstName>(FirstNameDomainErrors.TooLong);
        }

        return new FirstName(value);
    }

    public override IEnumerable<object> GetAtomicValues()
    {
        yield return Value;
    }
}
