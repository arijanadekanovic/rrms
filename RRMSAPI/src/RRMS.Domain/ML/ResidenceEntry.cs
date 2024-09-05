using Microsoft.ML.Data;

namespace RRMS.Domain.Entities;

public class Copurchase_prediction
{
    public float Score { get; set; }
}

public class ResidenceEntry
{
    [KeyType(count: 150)]
    public uint ResidenceId { get; set; }

    [KeyType(count: 150)]
    public uint CoPurchaseResidenceId { get; set; }
    public float Label { get; set; }
}
