[CmdletBinding()]
param(
    [string]$Repository = 'guedesle/regua-municipios-a-vista',
    [string]$Tag = 'v1.0.1-pilot.1'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$global:LASTEXITCODE = 0

$names = @(
    'ReguaEditorial-Entrega1-Corporativo-x64.exe',
    'ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe'
)
$gh = Get-Command gh.exe -ErrorAction SilentlyContinue
if (-not $gh) { $gh = Get-Command gh -ErrorAction SilentlyContinue }
if (-not $gh) { throw 'GITHUB_CLI_NOT_FOUND' }

$root = Join-Path $env:TEMP ('regua-release-audit-' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory $root -Force | Out-Null
try {
    & $gh.Source release download $Tag --repo $Repository --dir $root --pattern 'ReguaEditorial-Entrega1-*.exe' --pattern 'ReguaEditorial-Entrega1-*.exe.sha256'
    if ($LASTEXITCODE -ne 0) { throw 'RELEASE_DOWNLOAD_FAILED' }

    $results = foreach ($name in $names) {
        $exe = Join-Path $root $name
        $hashFile = "$exe.sha256"
        if (-not (Test-Path $exe -PathType Leaf)) { throw "ASSET_MISSING:$name" }
        if (-not (Test-Path $hashFile -PathType Leaf)) { throw "ASSET_MISSING:$name.sha256" }
        $actual = (Get-FileHash $exe -Algorithm SHA256).Hash.ToLowerInvariant()
        $declared = ((Get-Content $hashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()
        if ($actual -ne $declared) { throw "HASH_DIVERGENCE:$name" }
        $signature = Get-AuthenticodeSignature $exe
        $version = (Get-Item $exe).VersionInfo
        [pscustomobject]@{
            file = $name
            sha256 = $actual
            sizeBytes = (Get-Item $exe).Length
            signatureStatus = $signature.Status.ToString()
            signer = if ($signature.SignerCertificate) { $signature.SignerCertificate.Subject } else { $null }
            fileVersion = $version.FileVersion
            productVersion = $version.ProductVersion
        }
    }

    if ($results[0].sha256 -eq $results[1].sha256) { throw 'INSTALLERS_MUST_BE_DISTINCT' }

    [ordered]@{
        status = 'PUBLISHED_RELEASE_VALIDATED'
        repository = $Repository
        tag = $Tag
        corporate = $results[0]
        localHomologation = $results[1]
    } | ConvertTo-Json -Depth 5
} finally { Remove-Item $root -Recurse -Force -ErrorAction SilentlyContinue }
