[CmdletBinding()]
param(
    [string]$Repository = 'guedesle/regua-municipios-a-vista',
    [string]$Tag = 'v1.0.1-pilot.1'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$global:LASTEXITCODE = 0

$corporateName = 'ReguaEditorial-Entrega1-Corporativo-x64.exe'
$localName = 'ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe'

$gh = Get-Command gh.exe -ErrorAction SilentlyContinue
if (-not $gh) { $gh = Get-Command gh -ErrorAction SilentlyContinue }
if (-not $gh) { throw 'GITHUB_CLI_NOT_FOUND' }

& $gh.Source auth status
if ($LASTEXITCODE -ne 0) { throw 'GITHUB_CLI_NOT_AUTHENTICATED' }

$root = Join-Path $env:TEMP ('regua-release-audit-' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $root -Force | Out-Null

function Test-Pair {
    param([Parameter(Mandatory)][string]$Name)

    $setup = Join-Path $root $Name
    $hashFile = Join-Path $root "$Name.sha256"
    if (-not (Test-Path $setup -PathType Leaf)) { throw "ASSET_MISSING:$Name" }
    if (-not (Test-Path $hashFile -PathType Leaf)) { throw "ASSET_MISSING:$Name.sha256" }

    $actual = (Get-FileHash $setup -Algorithm SHA256).Hash.ToLowerInvariant()
    $declared = ((Get-Content $hashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()
    if ($declared -notmatch '^[a-f0-9]{64}$') { throw "INVALID_HASH_FILE:$Name" }
    if ($actual -ne $declared) { throw "HASH_DIVERGENCE:$Name" }

    $signature = Get-AuthenticodeSignature $setup
    $version = (Get-Item $setup).VersionInfo

    return [pscustomobject][ordered]@{
        file = $Name
        sha256 = $actual
        sizeBytes = (Get-Item $setup).Length
        signatureStatus = $signature.Status.ToString()
        signer = if ($signature.SignerCertificate) { $signature.SignerCertificate.Subject } else { $null }
        fileVersion = $version.FileVersion
        productVersion = $version.ProductVersion
    }
}

try {
    & $gh.Source release download $Tag `
        --repo $Repository `
        --dir $root `
        --pattern 'ReguaEditorial-Entrega1-*.exe' `
        --pattern 'ReguaEditorial-Entrega1-*.exe.sha256'
    if ($LASTEXITCODE -ne 0) { throw 'RELEASE_DOWNLOAD_FAILED' }

    $corporate = Test-Pair -Name $corporateName
    $local = Test-Pair -Name $localName

    if ($corporate.sha256 -eq $local.sha256) {
        throw 'INSTALLERS_MUST_BE_DISTINCT'
    }

    [ordered]@{
        status = 'PUBLISHED_RELEASE_VALIDATED'
        repository = $Repository
        tag = $Tag
        corporate = $corporate
        localHomologation = $local
    } | ConvertTo-Json -Depth 6
} finally {
    Remove-Item $root -Recurse -Force -ErrorAction SilentlyContinue
}
