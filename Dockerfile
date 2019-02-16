FROM microsoft/dotnet:sdk AS build-env

WORKDIR /app

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y zip

COPY ./src/sql-d/ /app/src/sql-d/
COPY ./src/sql-d.start/ /app/src/sql-d.start/
COPY ./src/sql-d.ui/ /app/src/sql-d.ui/

RUN mkdir /app/build
RUN mkdir /app/build/sql-d.start
RUN touch /app/build/sql-d.start/linux-x64.zip
RUN touch /app/build/sql-d.start/win-x64.zip
RUN touch /app/build/sql-d.start/osx-x64.zip
RUN dotnet publish /app/src/sql-d.start/SqlD.Start.csproj -r linux-x64 -c Release -o /app/build/sql-d.start/linux-x64/ --self-contained

WORKDIR /app/build/sql-d.start/linux-x64/

RUN rm -rf /app/build/sql-d.start/linux-x64.zip
RUN zip -r /app/build/sql-d.start/linux-x64.zip *

WORKDIR /app

RUN dotnet clean /app/src/sql-d/SqlD.csproj -r linux-x64
RUN dotnet clean /app/src/sql-d.start/SqlD.Start.csproj -r linux-x64
RUN dotnet clean /app/src/sql-d.ui/SqlD.UI.csproj -r linux-x64
RUN dotnet publish /app/src/sql-d.ui/SqlD.UI.csproj -r linux-x64 -c Release -o /app/build/sql-d.ui/linux-x64/ --self-contained

FROM microsoft/dotnet:2.1-aspnetcore-runtime

ENV ASPNETCORE_URLS http://*:5000;http://*:50095;http://*:50100;http://*:50101;http://*:50102;http://*:50103;http://*:50104;http://*:50105
EXPOSE 5000 50095 50100 50101 50102 50103 50104 50105
WORKDIR /app
COPY --from=build-env /app/build/sql-d.ui/linux-x64/ /app/
ENTRYPOINT ["/app/SqlD.UI"]
