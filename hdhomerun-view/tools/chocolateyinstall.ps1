$ErrorActionPreference = 'Stop'
$url            = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows.exe'
$checksum       = '8343034F53420D810F202DC24A8BF38D7B5340FF51923F1EC2BB94DA2063AFC6'

$packageArgs = @{
  packageName   = $env:chocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = 'HDHomeRun*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  

# UPDATE INSTRUCTIONS:
# Update checksum