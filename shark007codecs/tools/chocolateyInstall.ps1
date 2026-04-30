# https://shark007.net/files/Shark007Codecs.7z
$ErrorActionPreference = 'Stop';
$packageName  = 'shark007codecs'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutNameOld = 'Shark007''s 64bit ADVANCED Codecs.lnk'
$shortcutName = 'Shark007Codecs.lnk'

# Future banner for BCURRAN3 packages - preliminary ■■■
# Write-Host "`n  ▓▓ " -Foreground White -NoNewLine; Write-Host "This package maintained by BCURRAN3 and originated from " -Foreground Magenta -NoNewLine; Write-Host "▓▓" -Foreground White; Write-Host "  ▓▓ " -Foreground White -NoNewLine; Write-Host "https://nuts.bcurran3.org/ " -Foreground Cyan -NoNewLine; Write-Host "                             ▓▓`n" -Foreground White

if (Test-Path "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs"){ Remove-Item "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs" -Recurse -Force -ErrorAction SilentlyContinue }
if (Test-Path "$env:ProgramFiles\Shark007\Shark007Codecs\Tools\AutoUpdate.exe"){
	Write-Host "  ** Running AutoUpdate." -Foreground Magenta
	Start-ChocolateyProcessAsAdmin -Statements "silent" -ExeToRun "$env:ProgramFiles\Shark007\Shark007Codecs\Tools\AutoUpdate.exe" -WorkingDirectory "$env:ProgramFiles\Shark007\Shark007Codecs\Tools"
# TODO: Check for exit code 1 and if so, run again
	return
}

$packageArgs = @{
  packageName    = $env:chocolateyPackageName
  Destination    = "$env:ProgramFiles\Shark007"
  FileFullPath64 = "$toolsDir\Shark007Codecs.7z"
}
Get-ChocolateyUnzip @packageArgs

Start-ChocolateyProcessAsAdmin -Statements "silent" -ExeToRun "$env:ProgramFiles\Shark007\Shark007Codecs\Launcher64.exe" -WorkingDirectory "$env:ProgramFiles\Shark007\Shark007Codecs"
Start-ChocolateyProcessAsAdmin -Statements "users" -ExeToRun "$env:ProgramFiles\Shark007\Shark007Codecs\Tools\Settings64_portable.exe" -WorkingDirectory "$env:ProgramFiles\Shark007\Shark007Codecs\Tools\"
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutNameOld" -Force -ErrorAction SilentlyContinue
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$env:ProgramFiles\Shark007\Shark007Codecs\Launcher64.exe" -RunAsAdmin
Remove-Item "$toolsDir\Shark007Codecs.7z" | Out-Null

# UPDATE INSTRUCTIONS:
# replace the .7z file
