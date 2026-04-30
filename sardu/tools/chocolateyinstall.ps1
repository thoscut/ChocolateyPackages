$ErrorActionPreference = 'Stop'
$packageName   = 'sardu' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','')
$url           = "https://www.sarducd.it/download/SARDU_$TodaysVersion.zip"
$checksum      = '4B57E4E60D0520C6C7EA6DEFD6EE5137D226412BAF841F698932FCE82AABA9ED'
$shortcutName  = 'SARDU.lnk'
$workingDir    = "SARDU_$TodaysVersion"
$exe           = 'sardu_5.exe'

Remove-Item "$toolsDir\SARDU_*" -recurse -force # remove old versions but will break old version if new install fails

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
 }

Install-ChocolateyZipPackage @packageArgs
New-Item "$toolsDir\SARDU_$TodaysVersion\7z.exe.ignore" -type file
New-Item "$toolsDir\SARDU_$TodaysVersion\sardu_5.exe.ignore" -type file
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"

# UPDATE INSTRUCTIONS:
# Update the checksum
