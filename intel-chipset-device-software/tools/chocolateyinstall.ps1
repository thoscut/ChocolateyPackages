$ErrorActionPreference = 'Stop'
$packageName        = 'intel-chipset-device-software'
$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber = "872506"
$url                = "https://downloadmirror.intel.com/$IntelPackageNumber/SetupChipset.exe"
$checksum           = '5DA882149294917142CEA8666832E37F4D846FF04E14A313913B6A22F05E0CE2'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1,3010)
  silentArgs     = '/exenoui /quiet /norestart'
  softwareName   = 'Intel(R) Chipset Device Software'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

Write-Host "              ******************************************************"
Write-Host "              ** " -NoNewLine; Write-Host "Want to show appreciation?" -Foreground Magenta -NoNewLine; Write-Host "                       **"
Write-Host "              ** " -NoNewLine; Write-Host "EMAIL  : " -Foreground Green -NoNewLine; Write-Host "bcurran3@bcurran3.org" -Foreground White -NoNewLine; Write-Host "                   **"
Write-Host "              ** " -NoNewLine; Write-Host "BUYMEACOFFEE: " -Foreground Green -NoNewLine; Write-Host "https://buymeacoffee.com/bcurran3" -Foreground White -NoNewLine; Write-Host "  **"
Write-Host "              ** " -NoNewLine; Write-Host "KO-FI  : " -Foreground Green -NoNewLine; Write-Host "https://ko-fi.com/bcurran3" -Foreground White -NoNewLine; Write-Host "              **"
Write-Host "              ** " -NoNewLine; Write-Host "PATREON: " -Foreground Green -NoNewLine; Write-Host "https://www.patreon.com/bcurran3" -Foreground White -NoNewLine; Write-Host "        **"
Write-Host "              ** " -NoNewLine; Write-Host "PAYPAL : " -Foreground Green -NoNewLine; Write-Host "https://www.paypal.me/bcurran3donations" -Foreground White -NoNewLine; Write-Host " **"
Write-Host "              ******************************************************"

# UPDATE INSTRUCTIONS:
# Update IntelPackageNumber and checksum variables (wa_uam_primary_id (once, always?) when viewing javascript)
