# Imagem base do SDK .NET
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Define o diret�rio de trabalho
WORKDIR /app

# Copia o arquivo de projeto e restaura depend�ncias
COPY *.csproj ./
RUN dotnet restore

# Copia o restante do c�digo e publica a aplica��o
COPY . ./
RUN dotnet publish -c Release -o /out

# Imagem base para o runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0

# Define o diret�rio de trabalho
WORKDIR /app

# Copia o aplicativo publicado da etapa de build
COPY --from=build /out .

# Define o comando de execu��o padr�o
ENTRYPOINT ["dotnet", "AWS_ECR_GIT_ACTIONS.dll"]
