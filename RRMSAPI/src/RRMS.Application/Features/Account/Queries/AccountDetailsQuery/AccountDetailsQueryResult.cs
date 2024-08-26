namespace RRMS.Application.Features;

public sealed record AccountDetailsQueryResult
{
    public string Id { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Email { get; set; }
    public string Username { get; set; }
    public string PhoneNumber { get; set; }
    public string ProfilePhotoUrl { get; set; }
    public IEnumerable<string> Roles { get; set; }
}
