# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for desktop app development

Disable-UAC

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
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "PushOrigin-SystemConfiguration.ps1";
executeScript "PushOrigin-FileExplorerSettings.ps1";
executeScript "PushOrigin-RemoveDefaultApps.ps1";
executeScript "PushOrigin-CommonDevTools.ps1";
executeScript "PushOrigin-Browsers.ps1";

#--- Tools ---
#--- Installing VS and VS Code with Git
# See this for install args: https://chocolatey.org/packages/VisualStudio2017Community
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-ids
# visualstudio2017community
# visualstudio2017professional
# visualstudio2017enterprise

choco upgrade -y visualstudio2019community 
choco upgrade -y visualstudio2019-workload-manageddesktop
choco upgrade -y visualstudio2019-workload-netcoretools
choco upgrade -y visualstudio2019-workload-node
choco upgrade -y visualstudio2019-workload-azure

choco upgrade -y sql-server-management-studio
choco upgrade -y azure-data-studio

choco upgrade -y linqpad

choco upgrade -y nodejs
choco upgrade -y yarn

#--- Utilities ---
choco upgrade -y beyondcompare
choco upgrade -y cryptomator
choco upgrade -y dashlane

#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
