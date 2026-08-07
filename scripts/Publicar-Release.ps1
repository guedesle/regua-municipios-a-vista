[CmdletBinding()]
param(
    [string]$ArtifactsDirectory = '',

    [string]$CorporateSetupPath = '',
    [string]$CorporateHashPath = '',
    [string]$LocalHomologationSetupPath = '',
    [string]$LocalHomologationHashPath = '',

    [string]$Repository = 'guedesle/regua-municipios-a-vista',
    [string]$Tag = 'v1.0.1-pilot.1',
    [string]$Title = 'Entrega 1 — Piloto operacional 1.0.1',

    [switch]$ReplaceAssets,
    [switch]$SkipPostDownloadVerification
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$global:LASTEXITCODE = 0

$corporateName = 'ReguaEditorial-Entrega1-Corporativo-x64.exe'
$localName = 'ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe'

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

    return [pscustomobject][ordered]@{
        setup = $setup
        hashFile = $hashFile
        sha256 = $actualHash
    }
}

function Resolve-InputPaths {
    if (-not [string]::IsNullOrWhiteSpace($ArtifactsDirectory)) {
        $root = [IO.Path]::GetFullPath((Resolve-Path $ArtifactsDirectory).Path)
        return [pscustomobject][ordered]@{
            CorporateSetupPath = Join-Path $root $corporateName
            CorporateHashPath = Join-Path $root "$corporateName.sha256"
            LocalHomologationSetupPath = Join-Path $root $localName
            LocalHomologationHashPath = Join-Path $root "$localName.sha256"
        }
    }

    foreach ($value in @(
        $CorporateSetupPath,
        $CorporateHashPath,
        $LocalHomologationSetupPath,
        $LocalHomologationHashPath
    )) {
        if ([string]::IsNullOrWhiteSpace($value)) {
            throw 'INFORME_ARTIFACTS_DIRECTORY_OU_OS_QUATRO_CAMINHOS_DE_ATIVOS'
        }
    }

    return [pscustomobject][ordered]@{
        CorporateSetupPath = $CorporateSetupPath
        CorporateHashPath = $CorporateHashPath
        LocalHomologationSetupPath = $LocalHomologationSetupPath
        LocalHomologationHashPath = $LocalHomologationHashPath
    }
}

function Assert-PublishedPair {
    param(
        [Parameter(Mandatory)][string]$Directory,
        [Parameter(Mandatory)][string]$SetupName,
        [Parameter(Mandatory)][string]$ExpectedLocalHash
    )

    $setupPath = Join-Path $Directory $SetupName
    $hashPath = Join-Path $Directory "$SetupName.sha256"

    if (-not (Test-Path $setupPath -PathType Leaf)) {
        throw "PUBLISHED_SETUP_NOT_FOUND:$SetupName"
    }
    if (-not (Test-Path $hashPath -PathType Leaf)) {
        throw "PUBLISHED_HASH_NOT_FOUND:$SetupName"
    }

    $downloadedHash = (Get-FileHash $setupPath -Algorithm SHA256).Hash.ToLowerInvariant()
    $declaredHash = ((Get-Content $hashPath -Raw).Trim() -split '\s+')[0].ToLowerInvariant()

    if ($downloadedHash -ne $declaredHash) {
        throw "PUBLISHED_HASH_FILE_DIVERGENCE:$SetupName"
    }
    if ($downloadedHash -ne $ExpectedLocalHash) {
        throw "PUBLISHED_ASSET_DIFFERS_FROM_LOCAL:$SetupName:local=$ExpectedLocalHash:published=$downloadedHash"
    }

    return $downloadedHash
}

if (-not (Test-Path $notesPath -PathType Leaf)) {
    throw 'RELEASE_NOTES_NOT_FOUND'
}

$inputs = Resolve-InputPaths

$corporate = Resolve-And-ValidateAsset `
    -SetupPath $inputs.CorporateSetupPath `
    -HashPath $inputs.CorporateHashPath `
    -ExpectedSetupName $corporateName

$local = Resolve-And-ValidateAsset `
    -SetupPath $inputs.LocalHomologationSetupPath `
    -HashPath $inputs.LocalHomologationHashPath `
    -ExpectedSetupName $localName

if ($corporate.sha256 -eq $local.sha256) {
    throw 'INSTALLERS_MUST_BE_DISTINCT'
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
        Write-Warning 'Substituindo os quatro ativos da pré-release por solicitação explícita.'
        & $gh.Source release upload $Tag @assets --repo $Repository --clobber
        if ($LASTEXITCODE -ne 0) {
            throw 'RELEASE_ASSET_UPLOAD_FAILED'
        }
    } else {
        Write-Host 'Release já existe. Ativos preservados; sincronizando somente título e notas.'
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
    Write-Host "Criando Release $Tag com os quatro ativos..."
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

$verification = $null
if (-not $SkipPostDownloadVerification) {
    $verificationRoot = Join-Path $env:TEMP ('regua-release-verify-' + [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $verificationRoot -Force | Out-Null
    try {
        & $gh.Source release download $Tag `
            --repo $Repository `
            --dir $verificationRoot `
            --pattern 'ReguaEditorial-Entrega1-*.exe' `
            --pattern 'ReguaEditorial-Entrega1-*.exe.sha256'
        if ($LASTEXITCODE -ne 0) {
            throw 'RELEASE_POST_DOWNLOAD_FAILED'
        }

        $publishedCorporateHash = Assert-PublishedPair `
            -Directory $verificationRoot `
            -SetupName $corporateName `
            -ExpectedLocalHash $corporate.sha256

        $publishedLocalHash = Assert-PublishedPair `
            -Directory $verificationRoot `
            -SetupName $localName `
            -ExpectedLocalHash $local.sha256

        $verification = [pscustomobject][ordered]@{
            status = 'POST_DOWNLOAD_VERIFIED'
            corporateSha256 = $publishedCorporateHash
            localHomologationSha256 = $publishedLocalHash
        }
    } finally {
        Remove-Item $verificationRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
}

$result = [ordered]@{
    status = if ($SkipPostDownloadVerification) {
        'RELEASE_PUBLISHED_WITHOUT_POST_DOWNLOAD_VERIFICATION'
    } else {
        'RELEASE_PUBLISHED_AND_VERIFIED'
    }
    repository = $Repository
    tag = $Tag
    corporate = [ordered]@{
        file = $corporateName
        sha256 = $corporate.sha256
    }
    localHomologation = [ordered]@{
        file = $localName
        sha256 = $local.sha256
    }
    postDownload = $verification
}

$result | ConvertTo-Json -Depth 6

& $gh.Source release view $Tag --repo $Repository --web
