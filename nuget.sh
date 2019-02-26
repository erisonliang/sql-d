echo ''
echo '[SQL-D]:PUBLISH-NUGET/'
echo ''

dotnet nuget push ./build/sql-d/sql-d.1.0.2.nupkg -s https://api.nuget.org/v3/index.json -k $NUGET_API_PUBLISH_KEY --timeout 9999

echo ''
echo '[SQL-D]:PUBLISH-NUGET/END'
echo '  Success.'
echo ''

