# choco-protocol-support.ps1 Copyleft 2017-2024 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

param(
     [Parameter()]
     [string]$chocoprotocolURL
 )

$CPSDEBUG=$false
$chocopackageoptions=$null
$installarguments=$null
$params=$null
$upgrade=$false
$version=$null

$ErrorActionPreference = 'Continue'
Write-Host "Choco-Protocol-Support.ps1 v0.3 (2024-12-24) - install Chocolatey packages from URLs" -Foreground White
Write-Host "Copyleft 2017-2024 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

if (!($chocoprotocolURL)){Write-Warning "choco URL not provided, nothing to do!"; return}

Write-Host "  ** Processing $chocoprotocolURL" -ForegroundColor Magenta

[array]$split=$chocoprotocolURL.split("/")
$packagename=($split[2])
for($num=0; $num -lt $split.count; $num++) {
	if ($split[$num] -match 'version=') {$version=($split[$num]); $version=$version.replace('version=','')}
	if ($split[$num] -match 'v=') {$version=($split[$num]); $version=$version.replace('v=','')}
	if ($split[$num] -match 'params=') {($params=$split[$num]); $params=$params.replace('params=','')}
	if ($split[$num] -match 'p=') {$params=($split[$num]); $params=$params.replace('p=','')}
	if ($split[$num] -match 'installarguments=') {$installarguments=($split[$num]); $installarguments=$installarguments.replace('arguments=','')}
	if ($split[$num] -match 'ia=') {$installarguments=($split[$num]); $installarguments=$installarguments.replace('ia=','')}
}

if (($chocoprotocolURL -match 's=https?://\S+') -OR ($chocoprotocolURL -match 'source=https?://\S+')) {
    $source = $matches[0]
	$source=$source.replace('s=','')
	$source=$source.replace('source=','')
	if ($CPSDEBUG){ Write-Host "DEBUG: source = $source" -Foreground Yellow }
}
	
if (Test-Path $env:ChocolateyInstall\lib\$packagename\$packagename.nuspec) {
	[xml]$nuspecFile = Get-Content "$env:ChocolateyInstall\lib\$packagename\$packagename.nuspec"
	$OldVersion = $nuspecFile.package.metadata.version
	$upgrade=$true
}

if (!$upgrade) {
	Write-Host "  ** INSTALLING $packagename" -NoNewline -ForegroundColor Magenta
	if ($version){Write-Host " v$version" -Foreground Magenta}
} else {
	Write-Host "  ** UPGRADING $packagename" -NoNewline -ForegroundColor Magenta
	if ($version){Write-Host " v$OldVersion to v$version" -Foreground Magenta}
}
Write-Host ""

if (!$upgrade) {$chocopackagecommand='install'} else {$chocopackagecommand='upgrade'}
if ($version) {$chocopackageoptions=$chocopackageoptions + " --version=$version"}
if ($params) {$chocopackageoptions=$chocopackageoptions + " --params=`'`"$params`"`'"}
if ($installarguments) {$chocopackageoptions=$chocopackageoptions + " --installarguments=$installarguments"}
if ($source) {$chocopackageoptions=$chocopackageoptions + " --source=$source"}

if ($CPSDEBUG){ Write-Host "DEBUG: command = $env:ChocolateyInstall\choco.exe -ArgumentList $chocopackagecommand -y $packagename $chocopackageoptions" -ForegroundColor Yellow }

Start-Process -Filepath "$env:ChocolateyInstall\choco.exe" -ArgumentList "$chocopackagecommand -y $packagename $chocopackageoptions" -Wait -Verb RunAs

Write-Host "`n`nFound choco-protocol-support.ps1 useful?" -ForegroundColor White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor White
Start-Sleep -s 5

# TDL:
# Improve parsing of parameters, install arguments, and source better. - Medium priority.
# Add a config file that allows setting of other default choco.exe options and switches. - Low priority.
