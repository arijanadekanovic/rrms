namespace RRMS.Microservices.SharedKernel.Primitives;

public enum ErrorType
{
    None,
    Validation,
    Unknown,
}

public class Error
{
    public static Error Validation(string code, string message) => new(code, message, ErrorType.Validation);
    public static Error Unknown(string code = "", string message = "") => new(code, message, ErrorType.Unknown);

    public ErrorType Type { get; }
    public string Code { get; }
    public string Message { get; }

    public Error(string code, string message, ErrorType type)
    {
        Code = code;
        Message = message;
        Type = type;
    }

    public static implicit operator Result(Error error) => Result.Failure(error);
    public static implicit operator string(Error error) => error.Code;
}
