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
    public AccountDetailsResidentQueryResult ResidentInfo { get; set; }
}

public sealed record AccountDetailsResidentQueryResult
{
    public int ResidentId { get; set; }
    public int ResidenceId { get; set; }
    public double ResidencePrice { get; set; }
}
