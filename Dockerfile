# .NET SDK kullanarak projeyi derle
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Dosyaları kopyala ve bağımlılıkları indir
COPY . .
RUN dotnet restore

# Projeyi derle (Release modunda)
RUN dotnet publish -c Release -o out

# Çalıştırma ortamını hazırla
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Sunucuyu başlat (Dosya isminin doğruluğunu kontrol et)
ENTRYPOINT ["dotnet", "Supercell.Laser.Server.dll"]
