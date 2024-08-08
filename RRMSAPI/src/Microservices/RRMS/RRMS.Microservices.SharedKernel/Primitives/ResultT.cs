using Microsoft.AspNetCore.Http;

namespace RRMS.Microservices.SharedKernel.Primitives;

public class Result<T> : Result
{
    public T Value { get; set; }

    public Result() : base() { }
    public Result(T value, Error error) : base(error) => Value = value;


    public static implicit operator Result<T>(T value) => value is not null ? Success(value) : Failure<T>();

    public TResult Match<TResult>(Func<T, TResult> success, Func<Error, TResult> faulted)
    {
        return IsSuccess ? success(Value) : faulted(Error);
    }

    public IResult ToHttpResult<TResult>(Func<T, TResult> mapper)
    {
        return IsSuccess ? TypedResults.Ok(mapper(Value)) : TypedResults.BadRequest(Error);
    }
}
