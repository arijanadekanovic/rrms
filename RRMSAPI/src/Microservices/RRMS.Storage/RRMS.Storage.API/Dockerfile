FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 5002
EXPOSE 5003

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["src/Microservices/RRMS.Storage/RRMS.Storage.API/RRMS.Storage.API.csproj", "src/Microservices/RRMS.Storage/RRMS.Storage.API/"]
COPY ["src/Microservices/RRMS.Storage/RRMS.Storage.Application/RRMS.Storage.Application.csproj", "src/Microservices/RRMS.Storage/RRMS.Storage.Application/"]
COPY ["src/Microservices/RRMS.Storage/RRMS.Storage.Domain/RRMS.Storage.Domain.csproj", "src/Microservices/RRMS.Storage/RRMS.Storage.Domain/"]
COPY ["src/Microservices/RRMS.Storage/RRMS.Storage.Infrastructure/RRMS.Storage.Infrastructure.csproj", "src/Microservices/RRMS.Storage/RRMS.Storage.Infrastructure/"]
RUN dotnet restore "./src/Microservices/RRMS.Storage/RRMS.Storage.API/RRMS.Storage.API.csproj"
COPY . .
WORKDIR "/src/src/Microservices/RRMS.Storage/RRMS.Storage.API"
RUN dotnet build "./RRMS.Storage.API.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./RRMS.Storage.API.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "RRMS.Storage.API.dll"]