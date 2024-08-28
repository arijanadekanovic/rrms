using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Errors;

public static class ResidenceDomainErrors
{
    public static readonly Error NotFound = Error.Validation("Residence.NotFound", "Residence not found");
    public static readonly Error NotOwner = Error.Validation("Residence.NotOwner", "You are not the owner of this residence");
}
