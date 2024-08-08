using RRMS.Microservices.Application.Abstractions.Services.Identity;

namespace RRMS.Microservices.Infrastructure.Services.Identity;

public sealed record CurrentUser
(
    string Id,
    string Name,
    string UserName,
    string Email,
    List<string> Roles
) : ICurrentUser;
