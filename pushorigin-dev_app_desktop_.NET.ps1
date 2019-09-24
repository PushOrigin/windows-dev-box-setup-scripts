# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for desktop app development

#--- Workaround boxstarter/choco issue with infinity temp/chocolatey too long
#--- path error. https://github.com/chocolatey/boxstarter/issues/241
$ChocoCachePath = "$env:USERPROFILE\AppData\Local\Temp\chocolatey";
New-Item -Path $ChocoCachePath -ItemType Directory -Force

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    Write-Host "executing $helperUri/$script ..."
	Invoke-Expression ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Put the items that require a restart first ---
choco upgrade -y --cacheLocation="$ChocoCachePath" visualstudio2019community;
choco upgrade -y --cacheLocation="$ChocoCachePath" visualstudio2019-workload-manageddesktop;
choco upgrade -y --cacheLocation="$ChocoCachePath" visualstudio2019-workload-netcoretools;
choco upgrade -y --cacheLocation="$ChocoCachePath" visualstudio2019-workload-node;

#--- Skip until needed ---
#choco upgrade -y --cacheLocation="$ChocoCachePath"visualstudio2019-workload-azure;

#--- V1.0.0 shows as approved but "possibly broken"? Skip until it's needed ---
#choco upgrade -y --cacheLocation="$ChocoCachePath" visualstudio2019-workload-netcoretools;

#--- Chrome requires a restart ---
executeScript "PushOrigin-Browsers.ps1";

#--- SSMS requires a restart ---
choco upgrade -y sql-server-management-studio --cacheLocation="$ChocoCachePath"

choco upgrade -y azure-data-studio --cacheLocation="$ChocoCachePath"

choco upgrade -y linqpad --cacheLocation="$ChocoCachePath"

choco upgrade -y nodejs --cacheLocation="$ChocoCachePath"
choco upgrade -y yarn --cacheLocation="$ChocoCachePath"

#--- Utilities ---
#choco upgrade -y beyondcompare --cacheLocation="$ChocoCachePath"
#choco upgrade -y cryptomator --cacheLocation="$ChocoCachePath"
#choco upgrade -y dashlane --cacheLocation="$ChocoCachePath"

#--- Setting up Windows, do this last so it doesn't get repeated on every restart ---
executeScript "PushOrigin-CommonDevTools.ps1";
executeScript "PushOrigin-SystemConfiguration.ps1";
executeScript "PushOrigin-FileExplorerSettings.ps1";
executeScript "PushOrigin-TaskbarSettings.ps1"
#executeScript "UnpinAllStartMenuItems.ps1"
executeScript "PushOrigin-RemoveDefaultApps.ps1";

#--- reenabling critical items ---
Enable-MicrosoftUpdate

#--- Right now this is causing errors, run it manually ---
#Install-WindowsUpdate -acceptEula

Write-Host "TODO:"
Write-Host "-------------------------" 
Write-Host "Install updates." 
Write-Host "Restart to apply taskbar settings."
Write-Host "Install Windows Terminal."
Write-Host "Install WSL, Ubuntu."
Write-Host "Clean up start menu."