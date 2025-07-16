# --------------------
# Stage 1: Build
# --------------------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY Asp.csproj ./
RUN dotnet restore

# Copy the rest of the project
COPY . ./
RUN dotnet publish -c Release -o /app/out

# --------------------
# Stage 2: Run
# --------------------
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out ./

# Expose the port the app runs on (optional, useful for local run)
EXPOSE 80

# Run the app
ENTRYPOINT ["dotnet", "Asp.dll"]
