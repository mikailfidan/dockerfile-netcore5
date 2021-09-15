FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /src
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY *.csproj ./
RUN dotnet restore "app-backend.csproj"
COPY . .

RUN dotnet publish -c Release -o out

FROM base AS final
WORKDIR /src
COPY --from=build /src/out .
ENTRYPOINT ["dotnet", "app-backend.dll"]
