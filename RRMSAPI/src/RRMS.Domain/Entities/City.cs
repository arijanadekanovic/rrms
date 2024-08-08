using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class City : Entity
{
    public string Name { get; set; }

    public List<Residence> Residences { get; set; }
}
