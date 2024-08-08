namespace RRMS.Microservices.Application.Abstractions.Services.Identity;

public interface ICurrentUser
{
    public string Id { get; }
    public string Name { get; }
    public string UserName { get; }
    public string Email { get; }
    public List<string> Roles { get; }
}
