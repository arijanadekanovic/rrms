using Microsoft.Extensions.Primitives;

namespace RRMS.Microservices.SharedKernel.Extensions;


public static class StringValuesExtensions
{
    public static List<T> ToEnumList<T>(this StringValues value)
        where T : struct
    {
        return value
            .ToString()
            .Split(',', StringSplitOptions.RemoveEmptyEntries)
            .Select(Enum.Parse<T>)
            .ToList();
    }

    public static T? ToEnumOrDefault<T>(this StringValues value)
        where T : struct
    {
        string? v = value.ToString();

        if (string.IsNullOrWhiteSpace(v))
        {
            return null;
        }

        return Enum.Parse<T>(v);
    }

    public static int ToIntOrDefault(this StringValues value)
    {
        return int.TryParse(value, out int parsedValue) ? parsedValue : default;
    }

    public static int? ToNullableIntOrDefault(this StringValues value)
    {
        return int.TryParse(value, out int result) ? result : null;
    }

    public static Guid? ToGuidOrDefault(this StringValues value)
    {
        return Guid.TryParse(value, out Guid parsedValue) ? parsedValue : null;
    }

    public static bool ToBoolOrDefault(this StringValues value)
    {
        return bool.TryParse(value, out bool parsedValue) && parsedValue;
    }
}
