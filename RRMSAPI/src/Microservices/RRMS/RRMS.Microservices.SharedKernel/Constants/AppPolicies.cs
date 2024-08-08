namespace RRMS.Microservices.SharedKernel.Constants;

public static class AppPolicies
{
    public static AppPolicy SuperAdmin = new("SuperAdmin", [AppRoles.SuperAdmin]);
    public static AppPolicy Landlord = new("Landlord", [AppRoles.Landlord]);
    public static AppPolicy Resident = new("Resident", [AppRoles.Resident]);

    public static List<AppPolicy> Values =
    [
        SuperAdmin,
        Landlord,
        Resident,
    ];
}

public record AppPolicy
(
    string Name,
    List<string> Roles
);
