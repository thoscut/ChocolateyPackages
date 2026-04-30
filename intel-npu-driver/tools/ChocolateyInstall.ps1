$ErrorActionPreference = 'Stop'
$packageName = 'intel-npu-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber = '917145'
$url64       = "https://downloadmirror.intel.com/$IntelPackageNumber/npu_win_"+$env:ChocolateyPackageVersion+".exe"
$checksum64  = '5B2E71C8DB93511BD1EAD3E5E544B43180DCE1A80D4FCA20E8E116AACF3C8DD5'

Confirm-Win11

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = "-o -f -s"
  softwareName   = 'Intel(R) NPU Software & Drivers'
  validExitCodes = @(0, 1000, 3010, 1641, 14)
   }

Install-ChocolateyPackage @packageArgs

Write-Host "              ******************************************************"
Write-Host "              ** " -NoNewLine; Write-Host "Want to show appreciation?" -Foreground Magenta -NoNewLine; Write-Host "                       **"
Write-Host "              ** " -NoNewLine; Write-Host "EMAIL  : " -Foreground Green -NoNewLine; Write-Host "bcurran3@bcurran3.org" -Foreground White -NoNewLine; Write-Host "                   **"
Write-Host "              ** " -NoNewLine; Write-Host "BMC: " -Foreground Green -NoNewLine; Write-Host "https://buymeacoffee.com/bcurran3" -Foreground White -NoNewLine; Write-Host "           **"
Write-Host "              ** " -NoNewLine; Write-Host "KO-FI  : " -Foreground Green -NoNewLine; Write-Host "https://ko-fi.com/bcurran3" -Foreground White -NoNewLine; Write-Host "              **"
Write-Host "              ** " -NoNewLine; Write-Host "PATREON: " -Foreground Green -NoNewLine; Write-Host "https://www.patreon.com/bcurran3" -Foreground White -NoNewLine; Write-Host "        **"
Write-Host "              ** " -NoNewLine; Write-Host "PAYPAL : " -Foreground Green -NoNewLine; Write-Host "https://www.paypal.me/bcurran3donations" -Foreground White -NoNewLine; Write-Host " **"
Write-Host "              ******************************************************"

# UPDATE INSTRUCTIONS:
# Update the IntelPackageNumber and checksum variables
