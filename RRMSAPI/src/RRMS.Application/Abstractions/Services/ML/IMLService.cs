using RRMS.Domain.Entities;

namespace RRMS.Application.Abstractions.Services.Identity;

public interface IMLService
{
    Task StartTraining();
    Task<List<Residence>> RecommendById(int residenceId);
}
