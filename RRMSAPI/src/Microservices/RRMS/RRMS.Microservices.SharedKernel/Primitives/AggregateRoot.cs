using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Microservices.SharedKernel.Primitives;

public interface IAggregateRoot : IAggregateRoot<int> { }

public interface IAggregateRoot<TId> : IAuditEntity<TId>
{
    IReadOnlyCollection<IDomainEvent> DomainEvents { get; }

    void RaiseDomainEvent(IDomainEvent domainEvent);
    void ClearDomainEvents();
}

public abstract class AggregateRoot : AggregateRoot<int>, IAggregateRoot<int> { }

public abstract class AggregateRoot<TId> : AuditEntity<TId>, IAggregateRoot<TId>
{
    protected List<IDomainEvent> _domainEvents = [];
    public IReadOnlyCollection<IDomainEvent> DomainEvents => [.. _domainEvents];

    public void RaiseDomainEvent(IDomainEvent domainEvent) => _domainEvents.Add(domainEvent);
    public void ClearDomainEvents() => _domainEvents.Clear();
}
