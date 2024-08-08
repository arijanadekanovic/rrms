using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using RRMS.Microservices.Infrastructure.Options;
using RRMS.Storage.Application.Abstractions.Services.Identity;
using RRMS.Storage.Domain.Models;

namespace RRMS.Storage.Infrastructure.Services;

public class StorageService : IStorageService
{
    private readonly IWebHostEnvironment _webHostEnvironment;
    private readonly AppOptions _appOptions;

    public StorageService(
        IWebHostEnvironment webHostEnvironment,
        IOptions<AppOptions> appOptions
        )
    {
        _webHostEnvironment = webHostEnvironment;
        _appOptions = appOptions.Value;
    }

    public async Task<StorageItem> Save(IFormFile file)
    {
        // Get the absolute path to the wwwroot folder
        var wwwrootPath = _webHostEnvironment.WebRootPath;

        // Create random file name so that file overrides are avoided
        var fileName = $"{Guid.NewGuid()}.{file.FileName.Split('.').Last()}";

        // Define the relative path to the uploaded pictures folder
        var relativePath = Path.Combine("storage-files", fileName);

        // Combine the wwwroot path with the relative path to get the absolute path
        var absolutePath = Path.Combine(wwwrootPath, relativePath);

        // Ensure the directory exists, create it if necessary
        var directoryPath = Path.GetDirectoryName(absolutePath);
        if (!Directory.Exists(directoryPath))
        {
            Directory.CreateDirectory(directoryPath);
        }

        // Process the profile picture, save it to storage, etc.
        using (var stream = new FileStream(absolutePath, FileMode.Create))
        {
            await file.CopyToAsync(stream);
        }

        var url = $"{_appOptions.ApiUrl}/{relativePath}";

        return new StorageItem
        {
            RelativePath = relativePath,
            AbsolutePath = absolutePath,
            Url = url
        };
    }

    public async Task DeleteByUrl(string url)
    {
        var wwwrootPath = _webHostEnvironment.WebRootPath;
        var relativePath = url.Replace($"{_appOptions.ApiUrl}/", "");
        var absolutePath = Path.Combine(wwwrootPath, relativePath);

        await DeleteByAbsoulutePath(absolutePath);
    }

    public Task DeleteByAbsoulutePath(string absolutePath)
    {
        try
        {
            // Check if the file exists before attempting to delete
            if (File.Exists(absolutePath))
            {
                File.Delete(absolutePath);
            }
            else
            {
                Console.WriteLine($"File '{absolutePath}' does not exist.");
            }
        }
        catch (IOException ex)
        {
            Console.WriteLine($"An error occurred while deleting the file: {ex.Message}");
        }

        return Task.CompletedTask;
    }
}
