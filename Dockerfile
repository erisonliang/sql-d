FROM microsoft/dotnet:sdk AS build-env

WORKDIR /app

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y zip

COPY ./src/ /app/src/

RUN mkdir /app/build
RUN dotnet publish /app/src/sql-d.start/SqlD.Start.linux-x64.csproj -r linux-x64 -c Release -o /app/build/ --self-contained
FROM microsoft/dotnet:2.2-aspnetcore-runtime

ENV ASPNETCORE_URLS http://*:5000;http://*:50095;http://*:50100;http://*:50101;http://*:50102;http://*:50103;http://*:50104;http://*:50105
EXPOSE 5000 50095 50100 50101 50102 50103 50104 50105
WORKDIR /app
COPY --from=build-env /app/build/ /app/
ENTRYPOINT ["/app/SqlD.UI"]
