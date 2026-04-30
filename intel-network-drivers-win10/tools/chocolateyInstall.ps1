$ErrorActionPreference = 'Stop'
$packageName        = 'intel-network-drivers-win10' 
$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation      = "$toolsDir\unzipped"
$bits               = Get-ProcessorBits
#$TodaysVersion      = $ENV:ChocolateyPackageVersion.trim(".0,")
$TodaysVersion      = "31.1"
$IntelPackageNumber = "916206"
# Drivers
$url64          = "https://downloadmirror.intel.com/$IntelPackageNumber/Wired_driver_"+$TodaysVersion+"_x64.zip"
$checksum64     = 'C91C0E373656F62634AE561475CC498175649E95F0F02B2E43778DAE318B3B5C'

Confirm-Win10

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64    
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\SetupBD.exe"
  file64         = "$unzipLocation\SetupBD.exe"
  silentArgs     = '/m /nr /s '
  validExitCodes = @(0,1150)
  softwareName   = 'Intel(R) Network Connections*'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $unzipLocation -Recurse -EA SilentlyContinue | Out-Null

# PROSet 

# PROSet software is Win10 only - no Win11 support
$OSBuild=[Environment]::OSVersion.Version.Build
if ($OSBuild -gt 22000){
	Write-Host "  ** PROSet software is for Win10 only, not installing." -Foreground Magenta
	return
}

$url64          = "https://downloadmirror.intel.com/$IntelPackageNumber/Wired_PROSet_"+$TodaysVersion+"_x64.zip"
$checksum64     = '476CC8CBA2974B5093ACF5659DD29B5B52B85E3459FAE905F136167C2F5B91AF'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64    
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\DxSetup.exe"
  file64         = "$unzipLocation\DxSetup.exe"
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0,1150)
  softwareName   = 'Intel(R) Network Connections*'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $unzipLocation -Recurse -EA SilentlyContinue | Out-Null

Write-Host "              ******************************************************"
Write-Host "              ** " -NoNewLine; Write-Host "Want to show appreciation?" -Foreground Magenta -NoNewLine; Write-Host "                       **"
Write-Host "              ** " -NoNewLine; Write-Host "EMAIL  : " -Foreground Green -NoNewLine; Write-Host "bcurran3@bcurran3.org" -Foreground White -NoNewLine; Write-Host "                   **"
Write-Host "              ** " -NoNewLine; Write-Host "BMC    : " -Foreground Green -NoNewLine; Write-Host "https://buymeacoffee.com/bcurran3" -Foreground White -NoNewLine; Write-Host "       **"
Write-Host "              ** " -NoNewLine; Write-Host "KO-FI  : " -Foreground Green -NoNewLine; Write-Host "https://ko-fi.com/bcurran3" -Foreground White -NoNewLine; Write-Host "              **"
Write-Host "              ** " -NoNewLine; Write-Host "PATREON: " -Foreground Green -NoNewLine; Write-Host "https://www.patreon.com/bcurran3" -Foreground White -NoNewLine; Write-Host "        **"
Write-Host "              ** " -NoNewLine; Write-Host "PAYPAL : " -Foreground Green -NoNewLine; Write-Host "https://www.paypal.me/bcurran3donations" -Foreground White -NoNewLine; Write-Host " **"
Write-Host "              ******************************************************"

# UPDATE INSTRUCTIONS:
# Update IntelPackageNumber and checksums
