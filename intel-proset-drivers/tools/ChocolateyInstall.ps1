$ErrorActionPreference = 'Stop'
$packageName        = 'intel-proset-drivers'
$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation      = "$toolsDir\unzipped"
$IntelPackageNumber = "918237"
$url                = "https://downloadmirror.intel.com/784628/WiFi-22.160.0-Driver32-Win10.exe"
$checksum           = '64F1B31AFD8F842B887C99575494EBE16BB21AFC582688008344A4FA0A3A94DE'
$url64              = "https://downloadmirror.intel.com/$IntelPackageNumber/WiFi-"+$ENV:ChocolateyPackageVersion+"-Driver64-Win10-Win11.exe"
$checksum64         = '38D81A9FCDE6DE220CDEB712D33B86E8F648AA4C1267A46C6387C709508F7453'

# Last Windows 7+8 version was 21.40.5
# Last Windows 10 32-bit version was 22.160.0
# No need to check for hardware, drivers install even if an Intel PROSet/Wireless card is not found

Confirm-Win10

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '-silent'
  softwareName   = ''  
}

Install-ChocolateyPackage @packageArgs

Write-Host "              ******************************************************"
Write-Host "              ** " -NoNewLine; Write-Host "Want to show appreciation?" -Foreground Magenta -NoNewLine; Write-Host "                       **"
Write-Host "              ** " -NoNewLine; Write-Host "EMAIL  : " -Foreground Green -NoNewLine; Write-Host "bcurran3@bcurran3.org" -Foreground White -NoNewLine; Write-Host "                   **"
Write-Host "              ** " -NoNewLine; Write-Host "BMC    : " -Foreground Green -NoNewLine; Write-Host "https://buymeacoffee.com/bcurran3" -Foreground White -NoNewLine; Write-Host "       **"
Write-Host "              ** " -NoNewLine; Write-Host "KO-FI  : " -Foreground Green -NoNewLine; Write-Host "https://ko-fi.com/bcurran3" -Foreground White -NoNewLine; Write-Host "              **"
Write-Host "              ** " -NoNewLine; Write-Host "PATREON: " -Foreground Green -NoNewLine; Write-Host "https://www.patreon.com/bcurran3" -Foreground White -NoNewLine; Write-Host "        **"
Write-Host "              ** " -NoNewLine; Write-Host "PAYPAL : " -Foreground Green -NoNewLine; Write-Host "https://www.paypal.me/bcurran3donations" -Foreground White -NoNewLine; Write-Host " **"
Write-Host "              ******************************************************"

# UPDATE INSTRUCTIONS:
# To update this package, update the IntelPackageNumber and checksum64 variables