namespace RRMS.Microservices.Transport.Messages.Account.ProfilePhotoChanged;

public sealed record ProfilePhotoChangedMessage
{
    public string OldProfilePhotoUrl { get; set; }
}
