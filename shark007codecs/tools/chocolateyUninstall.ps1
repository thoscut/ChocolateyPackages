$ErrorActionPreference = 'Stop'
$packageName  = 'shark007codecs'
$shortcutNameOld = 'Shark007''s 64bit ADVANCED Codecs.lnk'
$shortcutName = 'Shark007Codecs.lnk'

if (Test-Path "$Env:ProgramFiles\Shark007"){
    Start-ChocolateyProcessAsAdmin -Statements "uninstall" -ExeToRun "$env:ProgramFiles\Shark007\Shark007Codecs\Tools\Settings64_portable.exe" -WorkingDirectory "$env:ProgramFiles\Shark007\ADVANCED_64bitCodecs\Tools\"
    Remove-Item -Recurse -Force "$Env:ProgramFiles\Shark007" -ErrorAction SilentlyContinue | Out-Null
}

if (Test-Path "$Env:ProgramFiles\Shark007"){
	Write-Host "  ** $Env:ProgramFiles\Shark007 could not be deleted. Manually remove after a reboot." -Foreground Magenta
}

Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutNameOld" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
