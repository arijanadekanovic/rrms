using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Errors;

public static class ResidentDomainErrors
{
    public static readonly Error NotFound = Error.Validation("Resident.NotFound", "Resident not found");
    public static readonly Error AlreadyExists = Error.Validation("Resident.AlreadyExists", "Resident request already exists");
}
