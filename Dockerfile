# 1. Aşama: Derleme (Build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Tüm dosyaları kopyala
COPY . .

# Solution dosyasını kullanarak tüm projeleri derle
RUN dotnet publish "Supercell.Laser.Server/Supercell.Laser.Server.csproj" -c Release -o out

# 2. Aşama: Çalıştırma (Runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Sunucuyu çalıştır
ENTRYPOINT ["dotnet", "Supercell.Laser.Server.dll"]
