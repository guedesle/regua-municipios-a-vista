[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$CorporateSetupPath,

    [Parameter(Mandatory)]
    [string]$CorporateHashPath,

    [Parameter(Mandatory)]
    [string]$LocalHomologationSetupPath,

    [Parameter(Mandatory)]
    [string]$LocalHomologationHashPath,

    [string]$Repository = 'guedesle/regua-municipios-a-vista',

    [string]$Tag = 'v1.0.1-pilot.1',

    [string]$Title = 'Entrega 1 — Piloto operacional 1.0.1',

    [switch]$ReplaceAssets
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$notesPath = [IO.Path]::GetFullPath(
    (Join-Path $PSScriptRoot '..\RELEASE-NOTES-v1.0.1-pilot.1.md'))

function Resolve-And-ValidateAsset {
    param(
        [Parameter(Mandatory)][string]$SetupPath,
        [Parameter(Mandatory)][string]$HashPath,
        [Parameter(Mandatory)][string]$ExpectedSetupName
    )

    $setup = [IO.Path]::GetFullPath((Resolve-Path $SetupPath).Path)
    $hashFile = [IO.Path]::GetFullPath((Resolve-Path $HashPath).Path)

    if (-not (Test-Path $setup -PathType Leaf)) {
        throw "SETUP_NOT_FOUND:$ExpectedSetupName"
    }
    if (-not (Test-Path $hashFile -PathType Leaf)) {
        throw "SETUP_HASH_FILE_NOT_FOUND:$ExpectedSetupName"
    }
    if ([IO.Path]::GetFileName($setup) -ne $ExpectedSetupName) {
        throw "UNEXPECTED_SETUP_FILENAME:expected=$ExpectedSetupName actual=$([IO.Path]::GetFileName($setup))"
    }
    if ([IO.Path]::GetFileName($hashFile) -ne "$ExpectedSetupName.sha256") {
        throw "UNEXPECTED_HASH_FILENAME:$([IO.Path]::GetFileName($hashFile))"
    }

    $actualHash = (Get-FileHash $setup -Algorithm SHA256).Hash.ToLowerInvariant()
    $expectedHash = ((Get-Content $hashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()

    if ($expectedHash -notmatch '^[a-f0-9]{64}$') {
        throw "SETUP_HASH_FILE_INVALID:$ExpectedSetupName"
    }
    if ($actualHash -ne $expectedHash) {
        throw "SETUP_HASH_DIVERGENCE:$ExpectedSetupName:expected=$expectedHash:actual=$actualHash"
    }

    return [ordered]@{
        setup = $setup
        hashFile = $hashFile
        sha256 = $actualHash
    }
}

if (-not (Test-Path $notesPath -PathType Leaf)) {
    throw 'RELEASE_NOTES_NOT_FOUND'
}

$corporate = Resolve-And-ValidateAsset `
    -SetupPath $CorporateSetupPath `
    -HashPath $CorporateHashPath `
    -ExpectedSetupName 'ReguaEditorial-Entrega1-Corporativo-x64.exe'

$local = Resolve-And-ValidateAsset `
    -SetupPath $LocalHomologationSetupPath `
    -HashPath $LocalHomologationHashPath `
    -ExpectedSetupName 'ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe'

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

$previousErrorActionPreference = $ErrorActionPreference
try {
    $ErrorActionPreference = 'Continue'
    & $gh.Source release view $Tag --repo $Repository 1>$null 2>$null
    $releaseExists = $LASTEXITCODE -eq 0
} finally {
    $ErrorActionPreference = $previousErrorActionPreference
}

$assets = @(
    $corporate.setup,
    $corporate.hashFile,
    $local.setup,
    $local.hashFile
)

if ($releaseExists) {
    if ($ReplaceAssets) {
        Write-Warning 'Substituindo os quatro ativos existentes da Release por solicitação explícita.'
        & $gh.Source release upload $Tag @assets --repo $Repository --clobber
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
    Write-Host "Criando Release $Tag com os dois instaladores..."
    & $gh.Source release create $Tag @assets `
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
Write-Host "Corporativo SHA-256: $($corporate.sha256)"
Write-Host "Homologação local SHA-256: $($local.sha256)"
if ($releaseExists -and -not $ReplaceAssets) {
    Write-Host 'Ativos existentes não foram modificados.'
}

& $gh.Source release view $Tag --repo $Repository --web
