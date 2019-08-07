
# tools we expect devs across many scenarios will want
choco upgrade -y vscode --cacheLocation="$ChocoCachePath";
choco upgrade -y git-fork
choco upgrade -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'" --cacheLocation="$ChocoCachePath";
#choco upgrade -y sourcetree --cacheLocation="$ChocoCachePath";
#choco upgrade -y python --cacheLocation="$ChocoCachePath";
#choco upgrade -y 7zip.install --cacheLocation="$ChocoCachePath";
choco upgrade -y sysinternals --cacheLocation="$ChocoCachePath";
