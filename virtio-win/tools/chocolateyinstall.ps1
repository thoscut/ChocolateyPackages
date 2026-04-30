$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName  = 'virtio-win' 

# Download ISO
$url      = 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.285-1/virtio-win-0.1.285.iso'
$checksum = 'E14CF2B94492C3E925F0070BA7FDFEDEB2048C91EEA9C5A5AFB30232A3976331'
$ISOPath  = "$toolsDir\virtio-win.ISO"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'ISO'
  url           = $url
  FileFullPath  = "$ISOPath"
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}
 
Get-ChocolateyWebFile @packageArgs

# Download and mount ISO
$ISODrive = Get-DiskImage -ImagePath $ISOPath
if (!$ISODrive.Attached) {
    Write-Host "  ** Mounting virtio-win.iso..." -Foreground Yellow
    $ISODrive = Mount-DiskImage -ImagePath $ISOPath -PassThru
}
$ISOLetter = ($ISODrive | Get-Volume).DriveLetter
$ISOLetter = "$ISOLetter"+":"

# Install virtio-win-gt-x64
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = ''
  file          = "$ISOLetter\virtio-win-gt-x64.msi"
  fileType      = 'MSI'
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\virtio-win-gt-x64.$env:ChocolateyPackageVersion.log`""
  validExitCodes= @(0,1603,1641,3010)
}

Write-Host "  ** Installing virtio-win-gt-x64..." -Foreground Yellow
Install-ChocolateyInstallPackage @packageArgs

# Install virtio-win-guest-tools
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = ''
  file          = "$ISOLetter\virtio-win-guest-tools.exe"
  fileType      = 'EXE'
  silentArgs    = "/install /quiet /norestart /log `"$env:TEMP\virtio-win-guest-tools.$env:ChocolateyPackageVersion.log`""
  validExitCodes= @(0,1,1603)
}

Write-Host "  ** Installing virtio-win-guest-tools..." -Foreground Yellow
Install-ChocolateyInstallPackage @packageArgs

Write-Host "  ** Dismounting virtio-win.iso..." -Foreground Yellow
$ISODrive | Dismount-DiskImage | Out-Null
Remove-Item "$ISOPath"
