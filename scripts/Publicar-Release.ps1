[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$SetupPath,

    [Parameter(Mandatory)]
    [string]$HashPath,

    [string]$Repository = 'guedesle/regua-municipios-a-vista',

    [string]$Tag = 'v1.0.0-pilot.1',

    [string]$Title = 'Entrega 1 — Piloto operacional',

    [switch]$ReplaceAssets
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$setup = [IO.Path]::GetFullPath((Resolve-Path $SetupPath).Path)
$hashFile = [IO.Path]::GetFullPath((Resolve-Path $HashPath).Path)
$notesPath = [IO.Path]::GetFullPath(
    (Join-Path $PSScriptRoot '..\RELEASE-NOTES-v1.0.0-pilot.1.md'))

if (-not (Test-Path $setup -PathType Leaf)) {
    throw 'SETUP_NOT_FOUND'
}
if (-not (Test-Path $hashFile -PathType Leaf)) {
    throw 'SETUP_HASH_FILE_NOT_FOUND'
}
if (-not (Test-Path $notesPath -PathType Leaf)) {
    throw 'RELEASE_NOTES_NOT_FOUND'
}

$actualHash = (Get-FileHash $setup -Algorithm SHA256).Hash.ToLowerInvariant()
$expectedHash = ((Get-Content $hashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()

if ($expectedHash -notmatch '^[a-f0-9]{64}$') {
    throw 'SETUP_HASH_FILE_INVALID'
}
if ($actualHash -ne $expectedHash) {
    throw "SETUP_HASH_DIVERGENCE: expected=$expectedHash actual=$actualHash"
}

$gh = Get-Command gh.exe -ErrorAction SilentlyContinue
if (-not $gh) {
    $gh = Get-Command gh -ErrorAction SilentlyContinue
}
if (-not $gh) {
    throw 'GITHUB_CLI_NOT_FOUND: instale com winget install --id GitHub.cli'
}

& $gh.Source auth status
if ($LASTEXITCODE -ne 0) {
    throw 'GITHUB_CLI_NOT_AUTHENTICATED: execute gh auth login'
}

# A ausência da Release é esperada na primeira publicação. A sondagem descarta
# stdout/stderr e usa somente o código de saída do GitHub CLI.
$previousErrorActionPreference = $ErrorActionPreference
try {
    $ErrorActionPreference = 'Continue'
    & $gh.Source release view $Tag --repo $Repository 1>$null 2>$null
    $releaseExists = $LASTEXITCODE -eq 0
} finally {
    $ErrorActionPreference = $previousErrorActionPreference
}

if ($releaseExists) {
    if ($ReplaceAssets) {
        Write-Warning 'Substituindo os ativos existentes da Release por solicitação explícita.'
        & $gh.Source release upload $Tag `
            $setup `
            $hashFile `
            --repo $Repository `
            --clobber
        if ($LASTEXITCODE -ne 0) {
            throw 'RELEASE_ASSET_UPLOAD_FAILED'
        }
    } else {
        Write-Host 'Release já existe. Ativos preservados; sincronizando apenas título e notas.'
    }

    & $gh.Source release edit $Tag `
        --repo $Repository `
        --title $Title `
        --notes-file $notesPath `
        --prerelease
    if ($LASTEXITCODE -ne 0) {
        throw 'RELEASE_NOTES_UPDATE_FAILED'
    }
} else {
    Write-Host "Criando Release $Tag..."
    & $gh.Source release create $Tag `
        $setup `
        $hashFile `
        --repo $Repository `
        --title $Title `
        --notes-file $notesPath `
        --prerelease `
        --target main
    if ($LASTEXITCODE -ne 0) {
        throw 'RELEASE_CREATION_FAILED'
    }
}

Write-Host 'Release publicada e sincronizada com sucesso.'
Write-Host "Repositório: $Repository"
Write-Host "Tag: $Tag"
Write-Host "SHA-256 local validado: $actualHash"
if ($releaseExists -and -not $ReplaceAssets) {
    Write-Host 'Ativos existentes não foram modificados.'
}

& $gh.Source release view $Tag --repo $Repository --web
