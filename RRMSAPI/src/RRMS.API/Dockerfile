#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 5000
EXPOSE 5001

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["src/RRMS.API/RRMS.API.csproj", "src/RRMS.API/"]
COPY ["src/RRMS.Application/RRMS.Application.csproj", "src/RRMS.Application/"]
COPY ["src/RRMS.Domain/RRMS.Domain.csproj", "src/RRMS.Domain/"]
COPY ["src/RRMS.Infrastructure/RRMS.Infrastructure.csproj", "src/RRMS.Infrastructure/"]
RUN dotnet restore "./src/RRMS.API/RRMS.API.csproj"
COPY . .
WORKDIR "/src/src/RRMS.App"
RUN dotnet build "./RRMS.API.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./RRMS.API.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "RRMS.API.dll"]