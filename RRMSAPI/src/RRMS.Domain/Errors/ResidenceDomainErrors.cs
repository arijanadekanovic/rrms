using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Errors;

public static class ResidenceDomainErrors
{
    public static readonly Error NotFound = Error.Validation("Residence.NotFound", "Residence not found");
}
