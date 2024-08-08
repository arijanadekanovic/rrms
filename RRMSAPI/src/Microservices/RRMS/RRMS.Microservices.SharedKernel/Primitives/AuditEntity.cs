namespace RRMS.Microservices.SharedKernel.Primitives;

public interface IAuditEntity : IEntity<int>
{
    string CreatedBy { get; set; }
    DateTime CreatedOnUtc { get; set; }
    string ModifiedBy { get; set; }
    DateTime? ModifiedOnUtc { get; set; }
    string DeletedBy { get; set; }
    DateTime? DeletedOnUtc { get; set; }
    bool IsDeleted { get; set; }
}

public interface IAuditEntity<TId> : IEntity<TId>
{
    string CreatedBy { get; set; }
    DateTime CreatedOnUtc { get; set; }
    string ModifiedBy { get; set; }
    DateTime? ModifiedOnUtc { get; set; }
    string DeletedBy { get; set; }
    DateTime? DeletedOnUtc { get; set; }
    bool IsDeleted { get; set; }
}

public abstract class AuditEntity : AuditEntity<int>, IAuditEntity { }

public abstract class AuditEntity<TId> : Entity<TId>, IAuditEntity<TId>
{
    public string CreatedBy { get; set; }
    public DateTime CreatedOnUtc { get; set; }
    public string ModifiedBy { get; set; }
    public DateTime? ModifiedOnUtc { get; set; }
    public string DeletedBy { get; set; }
    public DateTime? DeletedOnUtc { get; set; }
    public bool IsDeleted { get; set; }
}
