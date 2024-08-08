using MassTransit;
using Microsoft.AspNetCore.Http;

namespace RRMS.Microservices.SharedKernel.Primitives;

public class MicroResult<T>
{
    public T Value { get; set; }
    public ErrorType? Type { get; set; }
    public string Code { get; set; }
    public string Message { get; set; }

    public static implicit operator MicroResult<T>(Result<T> result) => new MicroResult<T>
    {
        Value = result.Value,
        Type = result.Error?.Type,
        Code = result.Error?.Code,
        Message = result.Error?.Message,
    };
}

public class Result
{
    public Error Error { get; set; }

    public bool IsSuccess => Error == null;
    public bool IsFailure => !IsSuccess;

    public Result() { }

    public Result(Error error)
    {
        Error = error;
    }

    public static Result Success() => new(null);
    public static Result Failure() => new(Error.Unknown());
    public static Result Failure(Error error) => new(error);

    public static Result<TValue> Success<TValue>(TValue value) => new(value, null);
    public static Result<TValue> Failure<TValue>() => new(default, Error.Unknown());
    public static Result<TValue> Failure<TValue>(Error error) => new(default, error);
    public static Result<TValue> ValidationFailure<TValue>(FluentValidation.Results.ValidationResult validationResult)
    {
        var validationError = validationResult.Errors.FirstOrDefault();

        return new(default, Error.Validation(validationError.ErrorCode, validationError.ErrorMessage));
    }

    public TResult Match<TResult>(Func<TResult> success, Func<Error, TResult> faulted)
    {
        return IsSuccess ? success() : faulted(Error);
    }

    public virtual IResult ToHttpResult()
    {
        return IsSuccess ? TypedResults.Ok() : TypedResults.BadRequest(Error);
    }

    public static Result<TValue> FromMicroResponse<TValue>(Response<TValue, Error> response) where TValue : class
    {
        if (response.Is(out Response<TValue> responseValue))
        {
            return Success(responseValue.Message);
        }

        if (response.Is(out Response<Error> responseError))
        {
            return Failure<TValue>(responseError.Message);
        }

        return Failure<TValue>();
    }
}
