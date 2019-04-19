$envPaths = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)  -split ";"; 
ns$envPaths = $envPaths | select -unique | ? {$_} 

if ($envPaths -notcontains "%userprofile%\.sql-d") { 
	$envPaths = , "%userprofile%\.sql-d" + $envPaths
}

if ($envPaths -notcontains "%userprofile%\.sql-d.ui") { 
	$envPaths = , "%userprofile%\.sql-d.ui" + $envPaths
}

$joinedEnvPaths = [string]::Join(";", $envPaths)
Write-Host "Setting path environment variable to $joinedEnvPaths"
[Environment]::SetEnvironmentVariable("PATH", $joinedEnvPaths, [System.EnvironmentVariableTarget]::User) 
