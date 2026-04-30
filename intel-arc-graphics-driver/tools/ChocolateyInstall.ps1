$ErrorActionPreference = 'Stop'
$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysArray        = ($env:ChocolateyPackageVersion.split('.'))
$TodaysVersion      = $TodaysArray[2] + "." + $TodaysArray[3]
$IntelPackageNumber = '917974'
$url64              = "https://downloadmirror.intel.com/$IntelPackageNumber/gfx_win_"+"$TodaysVersion"+".exe"
$checksum64         = '582DB74F0467B25E98C619F7DFF7A34D05F33D969A6C7081E38D92BA72561EEF'

Confirm-WinMinimumBuild 19042
if (!(Get-IsIntelVideo)){
    Write-Warning "  ** No Intel display adapter found."
    throw
   }
   
Write-Host "  ** These drivers are for Intel Core Ultra processors and Arc Series Graphics." -Foreground Yellow
Write-Host "  ** Use ``intel-graphics-driver`` for Intel 6th thru 10th Gen Intel processors." -Foreground Yellow
Write-Host "  ** Use ``intel-11th-14th-gen-processor-graphics`` for Intel 11th thru 14th Gen Intel processors." -Foreground Yellow

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = "--overwrite --fresh --silent --report $toolsDir\install.log"
  softwareName   = 'Intel(R) Arc Software & Drivers'
  validExitCodes = @(0, 3010, 1641, 1014, 1000)
   }

Install-ChocolateyPackage @packageArgs

Write-Host "  ** REBOOT NEEDED to apply all required settings/changes." -Foreground Yellow

Write-Host "              ******************************************************"
Write-Host "              ** " -NoNewLine; Write-Host "Want to show appreciation?" -Foreground Magenta -NoNewLine; Write-Host "                       **"
Write-Host "              ** " -NoNewLine; Write-Host "EMAIL  : " -Foreground Green -NoNewLine; Write-Host "bcurran3@bcurran3.org" -Foreground White -NoNewLine; Write-Host "                   **"
Write-Host "              ** " -NoNewLine; Write-Host "BMC    : " -Foreground Green -NoNewLine; Write-Host "https://buymeacoffee.com/bcurran3" -Foreground White -NoNewLine; Write-Host "       **"
Write-Host "              ** " -NoNewLine; Write-Host "KO-FI  : " -Foreground Green -NoNewLine; Write-Host "https://ko-fi.com/bcurran3" -Foreground White -NoNewLine; Write-Host "              **"
Write-Host "              ** " -NoNewLine; Write-Host "PATREON: " -Foreground Green -NoNewLine; Write-Host "https://www.patreon.com/bcurran3" -Foreground White -NoNewLine; Write-Host "        **"
Write-Host "              ** " -NoNewLine; Write-Host "PAYPAL : " -Foreground Green -NoNewLine; Write-Host "https://www.paypal.me/bcurran3donations" -Foreground White -NoNewLine; Write-Host " **"
Write-Host "              ******************************************************"

# UPDATE INSTRUCTIONS:
# To update this package update the IntelPackageNumber and checksum64 variables
# Get the IntelPackageNumber from the updated Release Notes link.
