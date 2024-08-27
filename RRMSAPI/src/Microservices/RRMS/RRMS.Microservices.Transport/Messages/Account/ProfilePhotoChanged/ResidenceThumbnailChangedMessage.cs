namespace RRMS.Microservices.Transport.Messages.Account.ProfilePhotoChanged;

public sealed record ResidenceThumbnailChangedMessage
{
    public string OldUrl { get; set; }
}
