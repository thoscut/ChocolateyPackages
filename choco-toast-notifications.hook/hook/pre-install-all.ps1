$ErrorActionPreference = 'Continue'
# choco-toast-notifications.hook v1.3.0 (2026-05-04) Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

# Create icon if it doesn't exist
if (!(Test-Path "$env:PUBLIC\Pictures\choco.ico")){ 
     [System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')  | Out-Null
     [System.Drawing.Icon]::ExtractAssociatedIcon("$env:ChocolateyInstall\choco.exe").ToBitmap().Save("$env:PUBLIC\Pictures\choco.ico")
}

# Set action for pre-install notification
$chocolateyAction="INSTALLING"

# Check if WinRM is running (required to send Toast systemwide)
$WinRMStatus=(Get-Service 'WinRM').Status

# Send Toast systemwide if admin
if (Test-ProcessAdminRights) {
    # Start WinRM if not Running
    if ((Get-Service WinRM).Status -eq 'Stopped') {Start-Service 'WinRM' -ErrorAction SilentlyContinue}
    # Show Toast notification
    if ((Get-Service WinRM).Status -eq 'Running') {
		Invoke-Command -ComputerName $(hostname) -ArgumentList $env:chocolateyPackageName,$env:chocolateyPackageTitle,$env:chocolateyPackageVersion,$chocolateyAction -ScriptBlock {param([string]$chocolateyPackageName, [string]$chocolateyPackageTitle, [string]$chocolateyPackageVersion, [string]$chocolateyAction)
		Import-Module BurntToast -ErrorAction SilentlyContinue
		[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing') | Out-Null
		$icon = New-BTImage -Path "$env:PUBLIC\Pictures\choco.ico"
		$text1 = New-BTText -Content "Chocolatey" -Size Title
		$text2 = New-BTText -Content "$chocolateyPackageName"
		$text3 = New-BTText -Content "$chocolateyPackageTitle"
		$text4 = New-BTText -Content "Version: $chocolateyPackageVersion"
		$text5 = New-BTText -Content "$chocolateyAction" -Size Header
		New-BurntToastNotification -Text $text1, $text2, $text3, $text4, $text5 -AppLogo $icon -AppId "Chocolatey" 2>$null
		}
    } else {
      Write-Host "** Can't send global choco-toast-notifications because WinRM service is not running." -Foreground Yellow
	  Invoke-Command -ArgumentList $env:chocolateyPackageName,$env:chocolateyPackageTitle,$env:chocolateyPackageVersion,$chocolateyAction -ScriptBlock {param([string]$chocolateyPackageName, [string]$chocolateyPackageTitle, [string]$chocolateyPackageVersion, [string]$chocolateyAction)
		Import-Module BurntToast -ErrorAction SilentlyContinue
		[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing') | Out-Null
		$icon = New-BTImage -Path "$env:PUBLIC\Pictures\choco.ico"
		$text1 = New-BTText -Content "Chocolatey" -Size Title
		$text2 = New-BTText -Content "$chocolateyPackageName"
		$text3 = New-BTText -Content "$chocolateyPackageTitle"
		$text4 = New-BTText -Content "Version: $chocolateyPackageVersion"
		$text5 = New-BTText -Content "$chocolateyAction" -Size Header
		New-BurntToastNotification -Text $text1, $text2, $text3, $text4, $text5 -AppLogo $icon -AppId "Chocolatey" 2>$null
		}
	  }
    # Stop WinRM if it was previously in Stopped state
    if ($WinRMStatus -eq 'Stopped') {Stop-Service 'WinRM' -ErrorAction SilentlyContinue}
} else {
  # Show Toast notification to running user if non-admin
  Invoke-Command -ArgumentList $env:chocolateyPackageName,$env:chocolateyPackageTitle,$env:chocolateyPackageVersion,$chocolateyAction -ScriptBlock {param([string]$chocolateyPackageName, [string]$chocolateyPackageTitle, [string]$chocolateyPackageVersion, [string]$chocolateyAction)
	Import-Module BurntToast -ErrorAction SilentlyContinue
	[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing') | Out-Null
	$icon = New-BTImage -Path "$env:PUBLIC\Pictures\choco.ico"
	$text1 = New-BTText -Content "Chocolatey" -Size Title
	$text2 = New-BTText -Content "$chocolateyPackageName"
	$text3 = New-BTText -Content "$chocolateyPackageTitle"
	$text4 = New-BTText -Content "Version: $chocolateyPackageVersion"
	$text5 = New-BTText -Content "$chocolateyAction" -Size Header
	New-BurntToastNotification -Text $text1, $text2, $text3, $text4, $text5 -AppLogo $icon -AppId "Chocolatey" 2>$null
	}
}