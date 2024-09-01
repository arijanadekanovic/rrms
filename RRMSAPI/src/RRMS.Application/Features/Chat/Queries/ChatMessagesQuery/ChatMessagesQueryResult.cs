namespace RRMS.Application.Features;

public sealed record ChatMessagesQueryResult
{
    public int ResidenceId { get; set; }
    public string ChatPartnerId { get; set; }
    public string ChatPartnerProfilePictureUrl { get; set; }
    public string ChatPartnerName { get; set; }
    public List<ChatMessageQueryResult> ChatMessages { get; set; }

}

public sealed record ChatMessageQueryResult
{
    public string Message { get; set; }
    public DateTime MessageDateTimeUtc { get; set; }
    public bool IsMyMessage { get; set; }
    public string ProfilePhotoUrl { get; set; }
}
