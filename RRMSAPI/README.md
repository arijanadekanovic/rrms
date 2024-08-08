# WorkFlow
Whitelabel app that is used for managing internal company elements like employees, announcements, vacation leave tracking, employee-manager communication etc.

# Setup

## Init containers
- Open the solution in Visual Studio
- Set docker-compose as startup project
- Close and reopen visual studio (check if the container are generated in your Docker Desktop)

## Add migrations
- Right click on API project from which we want to generate migrations 
- Open terminal 
- execute: "dotnet ef migrations add InitialAccount --project ../WorkFlow.Account.Infrastructure --startup-project . --output-dir Migrations"
- Repeat these steps for all APIs in your solution (Account API and Main API)

## Run DataSeeder
- Select "Docker Compose (DataSeeder)" from your Visual Studio debug options dropdown
- Run DataSeeder project in Visual Studio (migrations will be applied)



