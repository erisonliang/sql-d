FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build-env

WORKDIR /app

RUN apt-get update
COPY ./version.props /app/
COPY ./src/ /app/src/
RUN mkdir /app/build
RUN dotnet publish /app/src/sql-d.start.linux-x64/SqlD.Start.linux-x64.csproj -f netcoreapp3.1 -r linux-x64 -c Debug -o /app/build/ --self-contained

FROM microsoft/dotnet:3.0-aspnetcore-runtime

WORKDIR /app

ENV ASPNETCORE_URLS http://*:5000
EXPOSE 5000
COPY --from=build-env /app/build/ /app/
ENTRYPOINT ["/app/SqlD.Start.linux-x64", "-n", "newservice1", "-s", "localhost:5000", "-d", "newservice1.db", "-r", "localhost:5000", "-w"]
