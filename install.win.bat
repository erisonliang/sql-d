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

dotnet tool install --global dotnet-cli-zip
powershell -Command "Invoke-WebRequest https://www.nuget.org/api/v2/package/sql-d.ui.win-x64/1.0.5 -OutFile build\sql-d.ui.win-x64.nupkg"
z -e ./build/sql-d.ui.win-x64.nupkg ./build/sql-d.ui.win-x64/
rm -rf %userprofile%\.sql-d.ui\
mkdir %userprofile%\.sql-d.ui\
xcopy .\build\sql-d.ui.win-x64\contentFiles\any\any\sql-d.ui\win-x64\* %userprofile%\.sql-d.ui\ /s /e
copy %userprofile%\.sql-d.ui\SqlD.UI.win-x64.exe %userprofile%\.sql-d.ui\sql-d.ui.exe 
set "PATH_TO_INSERT=%userprofile%\.sql-d.ui\"
if "!path:%PATH_TO_INSERT%=!" equ "%path%" (
   setx PATH "%PATH_TO_INSERT%;%PATH%"
)

echo "[SQL-D]: Type 'sql-d.ui' to launch ui and browse to http://localhost:5000/"
echo "[SQL-D]: Type 'sql-d -w' to launch and browse to http://localhost:5000/swagger"
echo "[SQL-D]: For more sql-d options, please type 'sql-d' and hit enter"
echo "[SQL-D]: Example ~> sql-d -n newservice1 -s "localhost:9000" -d "newservice1.db" -r "localhost:9000" -w"
echo "[SQL-D]: Please restart your console so that the environment variables can take effect"
