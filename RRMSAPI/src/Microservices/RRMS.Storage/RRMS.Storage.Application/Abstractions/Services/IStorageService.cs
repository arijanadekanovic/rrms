using Microsoft.AspNetCore.Http;
using RRMS.Storage.Domain.Models;

namespace RRMS.Storage.Application.Abstractions.Services.Identity;

public interface IStorageService
{
    Task<StorageItem> Save(IFormFile file);
    Task DeleteByUrl(string url);
    Task DeleteByAbsoulutePath(string absolutePath);
}
