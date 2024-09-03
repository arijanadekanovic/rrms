using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Domain.Entities;
using RRMS.Domain.Enums;
using RRMS.Infrastructure.Persistance;
using RRMS.Microservices.SharedKernel.Constants;

namespace DataSeeder.Seeders;

internal static class ResidenceSeeder
{
    internal static async Task Seed(IServiceProvider serviceProvider)
    {
        var databaseContext = serviceProvider.GetRequiredService<DatabaseContext>();

        var thumbnailUrls = new List<string>
        {
            "https://archello.s3.eu-central-1.amazonaws.com/images/2021/09/08/ab-partners-midtown-apartment--modern-interior-design-apartments-archello.1631083770.83.jpg",
            "https://mir-s3-cdn-cf.behance.net/project_modules/max_3840/9516e180691313.5ce82f4b6d95f.jpg",
            "https://images.adsttc.com/media/images/5be3/3a40/08a5/e549/e300/0315/large_jpg/42442.jpg?1541618191",
            "https://media.architecturaldigest.com/photos/635fca1de3bc540330136178/16:9/w_2560%2Cc_limit/Living%2520room.jpg",
            "https://cdn.mos.cms.futurecdn.net/jGggmwPHncRNy6B5BTvipD-1200-80.jpg",
            "https://images.adsttc.com/media/images/5eca/d858/b357/65c1/7900/00e8/large_jpg/Taylor_Beach_House_Malibu_Road_SPFarchitects_x_Matthew_Momberger_1.jpg?1590351949",
            "https://images.barrons.com/im-458500?width=700&height=466",
            "https://images.mansionglobal.com/im-697978?width=1280&size=1.33333333",
            "https://hips.hearstapps.com/hmg-prod/images/tci-villa-amaizing-grace-2021-058-1616076982.jpg",
            "https://hips.hearstapps.com/hmg-prod/images/cayman-islands-villa-kempa-kai-2020-021-1616076929.jpg",
            "https://cdn.houseplansservices.com/content/6f986585u8kknkiki6uce1pvtg/w991x660.jpg?v=2",
            "https://www.decorilla.com/online-decorating/wp-content/uploads/2019/01/luxutry-apartment-design-online-feature.jpg",
            "https://asset.skoiy.com/9b80a6f781ff336f/yrwwqpnyb7ys.jpg?w=970&q=90",
            "https://res.cloudinary.com/dw4e01qx8/f_auto,q_auto/images/jurx48w0wvufwluavwwy",
        };

        var images = new List<string>
        {
            "https://archello.s3.eu-central-1.amazonaws.com/images/2021/09/08/ab-partners-midtown-apartment--modern-interior-design-apartments-archello.1631083770.83.jpg",
            "https://www.decorilla.com/online-decorating/wp-content/uploads/2019/01/luxutry-apartment-design-online-feature.jpg",
            "https://asset.skoiy.com/9b80a6f781ff336f/yrwwqpnyb7ys.jpg?w=970&q=90",
            "https://www.e-architect.com/wp-content/uploads/2022/06/benefits-of-interior-design-style-x080622-pi.jpg",
            "https://res.cloudinary.com/dw4e01qx8/f_auto,q_auto/images/jurx48w0wvufwluavwwy",
            "https://res.cloudinary.com/dw4e01qx8/f_auto,q_auto/images/y69ru5fjqypkmqr6plwc",
            "https://res.cloudinary.com/dw4e01qx8/f_auto,q_auto/images/u67klzinicclazabmyrb",
        }.Select(x => new ResidenceImage { Url = x }).ToList();

        var cities = await databaseContext.Cities.ToListAsync();
        var types = Enum.GetValues<ResidenceType>().ToList();
        var landlords = await databaseContext.Users.Where(x => x.UserRoles.Any(y => y.Role.Name == AppRoles.Landlord)).ToListAsync();
        var residents = await databaseContext.Users.Where(x => x.UserRoles.Any(y => y.Role.Name == AppRoles.Resident)).ToListAsync();

        var lastMessages = new List<string>
        {
            "Yes. How much is the rent?",
            "Cool, I'd like to be your resident.",
            "Where exactly is this residence?",
            "Do you have high speed internet?",
            "Cool, are pets allowed?",
        };

        foreach (var landlord in landlords)
        {
            for (var i = 0; i < thumbnailUrls.Count; i++)
            {
                var city = cities.OrderBy(x => Guid.NewGuid()).FirstOrDefault();
                var random = new Random();
                var type = types.OrderBy(x => Guid.NewGuid()).FirstOrDefault();
                var resident = residents.OrderBy(x => Guid.NewGuid()).FirstOrDefault();
                var lastMessage = lastMessages.OrderBy(x => Guid.NewGuid()).FirstOrDefault();

                var residence = new Residence
                {
                    Name = $"Apartment {i + 1} ({landlord.UserName})",
                    Description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    Address = $"{i + 4}th Street",
                    Rooms = 1 + random.Next(0, 5),
                    Size = 50 + random.NextDouble() * 20,
                    RentPrice = 50 + random.Next(0, 1000),
                    Type = type,
                    ThumbnailUrl = thumbnailUrls[i],
                    CityId = city.Id,
                    OwnerId = landlord.Id,
                    ChatMessages = new List<ChatMessage>
                {
                    new ChatMessage { Text = "Hello, is the apartment free?", SenderId = resident.Id, ReceiverId = landlord.Id },
                    new ChatMessage { Text = "Hello, it's free. Are you interested?", SenderId = landlord.Id, ReceiverId = resident.Id },
                    new ChatMessage { Text = lastMessage, SenderId = resident.Id, ReceiverId = landlord.Id },
                },
                    ResidenceDocuments = new List<ResidenceDocument>
                {
                    new ResidenceDocument { Url = "https://pii.or.id/uploads/dummies.pdf" },
                    new ResidenceDocument { Url = "https://www.rd.usda.gov/sites/default/files/pdf-sample_0.pdf" },
                    new ResidenceDocument { Url = "https://tourism.gov.in/sites/default/files/2019-04/dummy-pdf_2.pdf" },
                },
                    ResidenceImages = images,
                    ResidenceInspections = new List<ResidenceInspection>
                {
                    new ResidenceInspection { Description = "Standard check", InspectionDate = DateTime.Now.AddMonths(2), },
                    new ResidenceInspection { Description = "Random check in", InspectionDate = DateTime.Now.AddMonths(4), },
                },
                    Residents = new List<Resident>
                {
                    new Resident
                    {
                        UserId = resident.Id,
                        Status = ResidentStatus.Rejected,
                        ContractStartDateUtc = new DateTime(2015, 8, (1 + i) % 28),
                        ContractEndDateUtc = new DateTime(2016, 8, (1 + i) % 28),
                    },
                    new Resident
                    {
                        UserId = resident.Id,
                        Status = ResidentStatus.ContractExpired,
                        ContractStartDateUtc = new DateTime(2015, 8, (1 + i) % 28),
                        ContractEndDateUtc = new DateTime(2016, 8, (1 + i) % 28),
                    },
                    new Resident
                    {
                        UserId = resident.Id,
                        Status = ResidentStatus.ContractExpired,
                        ContractStartDateUtc = new DateTime(2016, 8, (1 + i) % 28),
                        ContractEndDateUtc = new DateTime(2017, 8, (1 + i) % 28),
                    },
                    new Resident
                    {
                        UserId = resident.Id,
                        Status = ResidentStatus.ContractExpired,
                        ContractStartDateUtc = new DateTime(2017, 8, (1 + i) % 28),
                        ContractEndDateUtc = new DateTime(2018, 8, (1 + i) % 28),
                    },
                    new Resident
                    {
                        UserId = resident.Id,
                        Status = ResidentStatus.Active,
                        ContractStartDateUtc = new DateTime(2024, 7, (1 + i) % 28),
                        ContractEndDateUtc = new DateTime(2025, 7, (1 + i) % 28),
                    },
                    new Resident
                    {
                        UserId = resident.Id,
                        Status = ResidentStatus.PendingRequest,
                        ContractStartDateUtc = new DateTime(2025, 9, (1 + i) % 28),
                        ContractEndDateUtc = new DateTime(2026, 9, (1 + i) % 28),
                    },
                },
                };

                await databaseContext.Residences.AddAsync(residence);
            }
        }

        await databaseContext.SaveChangesAsync();
    }
}
