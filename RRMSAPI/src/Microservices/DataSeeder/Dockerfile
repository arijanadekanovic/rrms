# Use the .NET SDK to build the project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

# Copy project files and restore dependencies
COPY ["src/Microservices/DataSeeder/DataSeeder.csproj", "src/Microservices/DataSeeder/"]
COPY ["src/RRMS.Application/RRMS.Application.csproj", "src/RRMS.Application/"]
COPY ["src/RRMS.Domain/RRMS.Domain.csproj", "src/RRMS.Domain/"]
#COPY ["src/RRMS.SharedKernel/RRMS.SharedKernel.csproj", "src/RRMS.SharedKernel/"]
COPY ["src/RRMS.Infrastructure/RRMS.Infrastructure.csproj", "src/RRMS.Infrastructure/"]
RUN dotnet restore "src/Microservices/DataSeeder/DataSeeder.csproj"

# Copy the rest of the files and build the project
COPY . .
WORKDIR "/src/src/Microservices/DataSeeder"
RUN dotnet build "DataSeeder.csproj" -c $BUILD_CONFIGURATION -o /app/build

# Publish the project
RUN dotnet publish "DataSeeder.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# Use the ASP.NET Core runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "DataSeeder.dll"]
