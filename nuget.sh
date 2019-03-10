echo ''
echo '[SQL-D]:PUBLISH-NUGET/'
echo ''

export VERSION=1.0.2

dotnet nuget push "./build/sql-d.$VERSION.nupkg" -s https://api.nuget.org/v3/index.json -k $NUGET_API_PUBLISH_KEY --timeout 9999
dotnet nuget push "./build/sql-d.$VERSION.start.linux-x64.nupkg" -s https://api.nuget.org/v3/index.json -k $NUGET_API_PUBLISH_KEY --timeout 9999
dotnet nuget push "./build/sql-d.$VERSION.start.osx-x64.nupkg" -s https://api.nuget.org/v3/index.json -k $NUGET_API_PUBLISH_KEY --timeout 9999
dotnet nuget push "./build/sql-d.$VERSION.start.win-x64.nupkg" -s https://api.nuget.org/v3/index.json -k $NUGET_API_PUBLISH_KEY --timeout 9999
