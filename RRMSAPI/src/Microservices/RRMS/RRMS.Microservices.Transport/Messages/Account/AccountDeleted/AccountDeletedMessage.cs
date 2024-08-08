namespace RRMS.Microservices.Transport.Messages.Account.AccountDelete;

public sealed record AccountDeletedMessage
{
    public string Id { get; set; }
    public string ProfilePhotoUrl { get; set; }
}
