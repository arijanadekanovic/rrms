namespace RRMS.Microservices.SharedKernel.Constants;

public static class AppRoles
{
    public const string SuperAdmin = nameof(SuperAdmin);
    public const string Landlord = nameof(Landlord);
    public const string Resident = nameof(Resident);

    public static List<string> OpenValues =
    [
        Landlord,
        Resident
    ];

    public static List<string> Values =
    [
        SuperAdmin,
        Landlord,
        Resident
    ];
}
