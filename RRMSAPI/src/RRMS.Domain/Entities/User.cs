using Microsoft.AspNetCore.Identity;
using RRMS.Microservices.SharedKernel.Messaging;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Domain.Entities;

public class User : IdentityUser<string>, IAggregateRoot<string>
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public bool IsApproved { get; set; }
    public string ProfilePhotoUrl { get; set; }

    public List<UserClaim> UserClaims { get; set; }
    public List<UserRole> UserRoles { get; set; }
    public List<UserToken> UserTokens { get; set; }
    public List<ChatMessage> SentChatMessages { get; set; }
    public List<ChatMessage> ReceivedChatMessages { get; set; }
    public List<Notification> Notifications { get; set; }
    public List<Resident> Residents { get; set; }

    #region AggregateRoot

    private readonly List<IDomainEvent> _domainEvents = [];
    public IReadOnlyCollection<IDomainEvent> DomainEvents => [.. _domainEvents];

    public string CreatedBy { get; set; }
    public DateTime CreatedOnUtc { get; set; }
    public string ModifiedBy { get; set; }
    public DateTime? ModifiedOnUtc { get; set; }
    public string DeletedBy { get; set; }
    public DateTime? DeletedOnUtc { get; set; }
    public bool IsDeleted { get; set; }

    public void RaiseDomainEvent(IDomainEvent domainEvent) => _domainEvents.Add(domainEvent);
    public void ClearDomainEvents() => _domainEvents.Clear();

    #endregion 
}
