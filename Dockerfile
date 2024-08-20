# Imagem base do SDK .NET
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo de projeto e restaura dependências
COPY *.csproj ./
RUN dotnet restore

# Copia o restante do código e publica a aplicação
COPY . ./
RUN dotnet publish -c Release -o /out

# Imagem base para o runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0

# Define o diretório de trabalho
WORKDIR /app

# Copia o aplicativo publicado da etapa de build
COPY --from=build /out .

# Define o comando de execução padrão
ENTRYPOINT ["dotnet", "AWS_ECR_GIT_ACTIONS.dll"]
