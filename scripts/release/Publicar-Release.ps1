[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$ArtifactsDirectory,
    [string]$Repository = 'guedesle/regua-municipios-a-vista',
    [string]$Tag = 'v1.0.1-pilot.1',
    [string]$Title = 'Entrega 1 — Piloto operacional 1.0.1',
    [switch]$ReplaceAssets
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$global:LASTEXITCODE = 0

$root = [IO.Path]::GetFullPath((Resolve-Path $ArtifactsDirectory).Path)
$notes = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..\release\v1.0.1-pilot.1.md'))
$names = @(
    'ReguaEditorial-Entrega1-Corporativo-x64.exe',
    'ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe'
)

function Get-ValidatedPair {
    param([Parameter(Mandatory)][string]$Name)
    $exe = Join-Path $root $Name
    $hashFile = "$exe.sha256"
    if (-not (Test-Path $exe -PathType Leaf)) { throw "ASSET_MISSING:$Name" }
    if (-not (Test-Path $hashFile -PathType Leaf)) { throw "ASSET_MISSING:$Name.sha256" }
    $actual = (Get-FileHash $exe -Algorithm SHA256).Hash.ToLowerInvariant()
    $declared = ((Get-Content $hashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()
    if ($declared -notmatch '^[a-f0-9]{64}$') { throw "INVALID_HASH_FILE:$Name" }
    if ($actual -ne $declared) { throw "HASH_DIVERGENCE:$Name" }
    [pscustomobject]@{ exe = $exe; hashFile = $hashFile; sha256 = $actual }
}

if (-not (Test-Path $notes -PathType Leaf)) { throw 'RELEASE_NOTES_NOT_FOUND' }
$gh = Get-Command gh.exe -ErrorAction SilentlyContinue
if (-not $gh) { $gh = Get-Command gh -ErrorAction SilentlyContinue }
if (-not $gh) { throw 'GITHUB_CLI_NOT_FOUND' }
& $gh.Source auth status
if ($LASTEXITCODE -ne 0) { throw 'GITHUB_CLI_NOT_AUTHENTICATED' }

$pairs = @($names | ForEach-Object { Get-ValidatedPair $_ })
if ($pairs[0].sha256 -eq $pairs[1].sha256) { throw 'INSTALLERS_MUST_BE_DISTINCT' }
$assets = @($pairs | ForEach-Object { $_.exe; $_.hashFile })

$oldPreference = $ErrorActionPreference
try {
    $ErrorActionPreference = 'Continue'
    & $gh.Source release view $Tag --repo $Repository 1>$null 2>$null
    $exists = $LASTEXITCODE -eq 0
} finally { $ErrorActionPreference = $oldPreference }

if ($exists) {
    if ($ReplaceAssets) {
        & $gh.Source release upload $Tag @assets --repo $Repository --clobber
        if ($LASTEXITCODE -ne 0) { throw 'RELEASE_ASSET_UPLOAD_FAILED' }
    }
    & $gh.Source release edit $Tag --repo $Repository --title $Title --notes-file $notes --prerelease
    if ($LASTEXITCODE -ne 0) { throw 'RELEASE_EDIT_FAILED' }
} else {
    & $gh.Source release create $Tag @assets --repo $Repository --title $Title --notes-file $notes --prerelease --target main
    if ($LASTEXITCODE -ne 0) { throw 'RELEASE_CREATE_FAILED' }
}

$verify = Join-Path $env:TEMP ('regua-release-' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory $verify -Force | Out-Null
try {
    & $gh.Source release download $Tag --repo $Repository --dir $verify --pattern 'ReguaEditorial-Entrega1-*.exe' --pattern 'ReguaEditorial-Entrega1-*.exe.sha256'
    if ($LASTEXITCODE -ne 0) { throw 'RELEASE_DOWNLOAD_FAILED' }
    foreach ($pair in $pairs) {
        $name = [IO.Path]::GetFileName($pair.exe)
        $downloaded = Join-Path $verify $name
        $downloadedHash = (Get-FileHash $downloaded -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($downloadedHash -ne $pair.sha256) { throw "PUBLISHED_ASSET_DIFFERS:$name" }
    }
} finally { Remove-Item $verify -Recurse -Force -ErrorAction SilentlyContinue }

[ordered]@{
    status = 'RELEASE_PUBLISHED_AND_VERIFIED'
    repository = $Repository
    tag = $Tag
    corporateSha256 = $pairs[0].sha256
    localHomologationSha256 = $pairs[1].sha256
} | ConvertTo-Json -Depth 4
