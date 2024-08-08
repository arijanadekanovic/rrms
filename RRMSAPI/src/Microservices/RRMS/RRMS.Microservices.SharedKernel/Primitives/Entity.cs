namespace RRMS.Microservices.SharedKernel.Primitives;

public interface IEntity : IEntity<int> { }

public interface IEntity<TId>
{
    TId Id { get; set; }
}

public abstract class Entity : Entity<int>, IEntity { }

public abstract class Entity<TId> : IEntity<TId>
{
    public TId Id { get; set; }
}
