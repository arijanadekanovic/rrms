namespace RRMS.Application.Features;

public sealed record UserQueryResult
{
    public string Id { get; set; }
    public string FullName { get; set; }
}
