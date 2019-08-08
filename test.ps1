# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for desktop app development

Disable-UAC

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

executeScript "UnpinAllStartMenuItems.ps1"

#--- reenabling critical items ---
Enable-UAC
Enable-MicrosoftUpdate

#--- Right now this is causing errors, run it manually ---
#Install-WindowsUpdate -acceptEula

Write-Host "TODO: Install updates, restart to apply taskbar settings."