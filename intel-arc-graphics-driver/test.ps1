# --- Configuration ---
$pkgId = "intel-arc-graphics-driver" # Example, script handles this dynamically below

# --- Package Data Extraction ---
$nuspecPath = Get-ChildItem *.nuspec | Select-Object -First 1
if (-not $nuspecPath) { Write-Error "No .nuspec file found!"; return }
[xml]$nuspec = Get-Content $nuspecPath

$pkgId      = $nuspec.package.metadata.id
$pkgVersion = $nuspec.package.metadata.version
$pkgTitle   = $nuspec.package.metadata.title
$pkgNotes   = $nuspec.package.metadata.releaseNotes
$packageUrl = "https://nuts.bcurran3.org/feeds/chocolatey/$pkgId/$pkgVersion"

# --- Format the Content for Clipboard ---
$postTitle = "Package Update: $pkgTitle v$pkgVersion"
$postBody  = @"
TITLE: $postTitle

CONTENT:
<h3>$pkgTitle has been updated!</h3>
<p>Version <b>$pkgVersion</b> is now available at bcurran3.org.</p>
<h4>Release Notes:</h4>
<p>$($pkgNotes -replace "`n", "<br>")</p>
<br>
<p><b>Installation:</b></p>
<code>choco upgrade $pkgId -y</code>
<hr>
<p><a href="$packageUrl">View this package on bcurran3.org</a></p>
"@

# Copy to clipboard
$postBody | Set-Clipboard
Write-Host "Patreon content for $pkgId v$pkgVersion copied to clipboard!" -ForegroundColor Green
Write-Host "Just go to Patreon and paste."