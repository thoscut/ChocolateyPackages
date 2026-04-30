$ErrorActionPreference = 'Stop'
$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysArray        = ($env:ChocolateyPackageVersion.split('.'))
$TodaysVersion      = $TodaysArray[2] + "." + $TodaysArray[3]
$IntelPackageNumber = '873460'
$url64              = "https://downloadmirror.intel.com/$IntelPackageNumber/gfx_win_"+"$TodaysVersion"+".exe"
$checksum64         = '339008B4C3B2F3358D2F901358749F202917580CB74E4894526B3CFD8649C197'

Confirm-WinMinimumBuild 19042
if (!(Get-IsIntelVideo)){
    Write-Warning "  ** No Intel display adapter found."
    throw
   }
   
Write-Host "  ** These drivers are for Intel 11th thru 14th Gen processors." -Foreground Yellow
Write-Host "  ** Use ``intel-graphics-driver`` for Intel 6th thru 10th Gen processors." -Foreground Yellow
Write-Host "  ** Use ``intel-arc-graphics-driver`` for Intel Ultra Core processors." -Foreground Yellow

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

Write-Host "              ******************************************************"
Write-Host "              ** " -NoNewLine; Write-Host "Want to show appreciation?" -Foreground Magenta -NoNewLine; Write-Host "                       **"
Write-Host "              ** " -NoNewLine; Write-Host "EMAIL  : " -Foreground Green -NoNewLine; Write-Host "bcurran3@bcurran3.org" -Foreground White -NoNewLine; Write-Host "                   **"
Write-Host "              ** " -NoNewLine; Write-Host "BUYMEACOFFEE: " -Foreground Green -NoNewLine; Write-Host "https://buymeacoffee.com/bcurran3" -Foreground White -NoNewLine; Write-Host "  **"
Write-Host "              ** " -NoNewLine; Write-Host "KO-FI  : " -Foreground Green -NoNewLine; Write-Host "https://ko-fi.com/bcurran3" -Foreground White -NoNewLine; Write-Host "              **"
Write-Host "              ** " -NoNewLine; Write-Host "PATREON: " -Foreground Green -NoNewLine; Write-Host "https://www.patreon.com/bcurran3" -Foreground White -NoNewLine; Write-Host "        **"
Write-Host "              ** " -NoNewLine; Write-Host "PAYPAL : " -Foreground Green -NoNewLine; Write-Host "https://www.paypal.me/bcurran3donations" -Foreground White -NoNewLine; Write-Host " **"
Write-Host "              ******************************************************"

# UPDATE INSTRUCTIONS:
# To update this package update the IntelPackageNumber and checksum64 variables
# Get the IntelPackageNumber from the updated Release Notes link.
