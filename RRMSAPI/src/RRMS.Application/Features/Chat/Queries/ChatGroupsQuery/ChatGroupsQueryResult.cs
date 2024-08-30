namespace RRMS.Application.Features;

public sealed record ChatGroupQueryResult
{
    public int ResidenceId { get; set; }
    public string ChatPartnerId { get; set; }
    public string ChatPartnerProfilePictureUrl { get; set; }
    public string ChatPartnerName { get; set; }
    public string LastMessage { get; set; }
    public DateTime LastMessageDateTimeUtc { get; set; }
    public bool Seen { get; set; }
}
