@echo off

setlocal EnableDelayedExpansion

echo.
echo [SQL-D]:INSTALL/
echo.

dotnet tool install --global dotnet-cli-zip
powershell -Command "Invoke-WebRequest https://www.nuget.org/api/v2/package/sql-d.start.win-x64/1.0.5 -OutFile build\sql-d.start.win-x64.nupkg"
z -e ./build/sql-d.start.win-x64.nupkg ./build/sql-d.start.win-x64/
rm -rf %userprofile%\.sql-d\
mkdir %userprofile%\.sql-d\
xcopy .\build\sql-d.start.win-x64\contentFiles\any\any\sql-d.start\win-x64\* %userprofile%\.sql-d\ /s /e
copy %userprofile%\.sql-d\SqlD.Start.win-x64.exe %userprofile%\.sql-d\sql-d.exe 
set "PATH_TO_INSERT=%userprofile%\.sql-d\"
if "!path:%PATH_TO_INSERT%=!" equ "%path%" (
   setx PATH "%PATH_TO_INSERT%;%PATH%"
)

echo "[SQL-D]: Please restart your console so that the environment variables can take effect"
echo "[SQL-D]: Please type 'sql-d -w' to launch and browse to http://localhost:5000/swagger"
echo "[SQL-D]: For more sql-d options, please type 'sql-d' and hit enter"
echo "[SQL-D]: Example ~> sql-d -n newservice1 -s "localhost:9000" -d "newservice1.db" -r "localhost:9000" -w"

