$ErrorActionPreference = 'Stop'
$packageName = 'intel-bluetooth-drivers' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber = '918120'
$url64       = "https://downloadmirror.intel.com/$IntelPackageNumber/BT-"+$env:ChocolateyPackageVersion+"-64UWD-Win10-Win11.exe"
$checksum64  = '406F438EF4B6CE6EBA6F28C9CB4EBB12E01549CC1A4C3A497FDCECF221CE585E'

Confirm-Win10

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = "/quiet /norestart"
  softwareName   = ''
  validExitCodes = @(0, 3010, 1641, 14)
   }

Write-Warning "During instalation of the drivers, Bluetooth peripherals will temporarily be unavailable."
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
# Update the IntelPackageNumber and checksum variables
