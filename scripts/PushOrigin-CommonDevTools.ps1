
# tools we expect devs across many scenarios will want
choco upgrade -y --cacheLocation="$ChocoCachePath" vscode;
choco upgrade -y --cacheLocation="$ChocoCachePath" git-fork;
choco upgrade -y --cacheLocation="$ChocoCachePath" git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'";
#choco upgrade -y --cacheLocation="$ChocoCachePath" sourcetree;
#--- Python is now a store app?
#choco upgrade -y --cacheLocation="$ChocoCachePath" python;
#choco upgrade -y --cacheLocation="$ChocoCachePath" 7zip.install;
choco upgrade -y --cacheLocation="$ChocoCachePath" sysinternals;
