[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$SourceDirectory,

    [string]$ExpectedSetupVersion = '1.0.1',

    [string]$ExpectedExtensionId = 'chdfbekdjpecdajbpdelmhpemenoelmd',

    [string]$ExpectedSha256 = '',

    [string]$LocalStagingRoot = "$env:ProgramData\EGBA\ReguaEditorial\deploy",

    [string]$LogPath = "$env:ProgramData\EGBA\ReguaEditorial\Logs\gpo-deploy.log",

    [switch]$ForceReinstall
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$global:LASTEXITCODE = 0

$setupName = 'ReguaEditorial-Entrega1-Corporativo-x64.exe'
$hashName = "$setupName.sha256"
$sourceRoot = [IO.Path]::GetFullPath((Resolve-Path $SourceDirectory).Path)
$sourceSetup = Join-Path $sourceRoot $setupName
$sourceHash = Join-Path $sourceRoot $hashName
$stagingDirectory = Join-Path $LocalStagingRoot $ExpectedSetupVersion
$localSetup = Join-Path $stagingDirectory $setupName
$localHash = Join-Path $stagingDirectory $hashName
$productKey = 'HKLM:\Software\EGBA\ReguaEditorial'
$helperPath = "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe"
$installationState = "$env:ProgramData\EGBA\ReguaEditorial\state\installation.json"
$policyState = "$env:ProgramData\EGBA\ReguaEditorial\state\chrome-policy.json"

function Write-DeployLog {
    param([Parameter(Mandatory)][string]$Message)

    $directory = Split-Path $LogPath -Parent
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
    $line = '{0} {1}' -f (Get-Date).ToString('s'), $Message
    Add-Content -Path $LogPath -Value $line -Encoding UTF8
    Write-Host $line
}

function Assert-Administrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        throw 'DEPLOY_REQUIRES_ADMINISTRATOR_OR_SYSTEM'
    }
}

function Assert-ActiveDirectory {
    $computer = Get-CimInstance Win32_ComputerSystem
    if (-not [bool]$computer.PartOfDomain) {
        throw 'ACTIVE_DIRECTORY_REQUIRED'
    }
    return [string]$computer.Domain
}

function Get-DeclaredHash {
    param([Parameter(Mandatory)][string]$Path)

    $value = ((Get-Content $Path -Raw).Trim() -split '\s+')[0].ToLowerInvariant()
    if ($value -notmatch '^[a-f0-9]{64}$') {
        throw 'INVALID_SHA256_FILE'
    }
    return $value
}

function Test-InstalledHealth {
    $product = Get-ItemProperty $productKey -ErrorAction SilentlyContinue
    if (-not $product) { return $false }
    if ([string]$product.Version -ne $ExpectedSetupVersion) { return $false }
    if (-not (Test-Path $helperPath -PathType Leaf)) { return $false }
    if (-not (Test-Path $installationState -PathType Leaf)) { return $false }
    if (-not (Test-Path $policyState -PathType Leaf)) { return $false }

    try {
        $state = Get-Content $installationState -Raw | ConvertFrom-Json
        if ([string]$state.extensionId -ne $ExpectedExtensionId) { return $false }
        if ([string]$state.extensionVersion -ne '0.7.4') { return $false }
    } catch {
        return $false
    }

    return $true
}

Assert-Administrator
$domain = Assert-ActiveDirectory
Write-DeployLog "DOMAIN_OK:$domain"

foreach ($required in @($sourceSetup, $sourceHash)) {
    if (-not (Test-Path $required -PathType Leaf)) {
        throw "SOURCE_ASSET_MISSING:$required"
    }
}

$declaredSourceHash = Get-DeclaredHash -Path $sourceHash
$actualSourceHash = (Get-FileHash $sourceSetup -Algorithm SHA256).Hash.ToLowerInvariant()
if ($actualSourceHash -ne $declaredSourceHash) {
    throw "SOURCE_HASH_DIVERGENCE:declared=$declaredSourceHash:actual=$actualSourceHash"
}
if (-not [string]::IsNullOrWhiteSpace($ExpectedSha256) -and
    $actualSourceHash -ne $ExpectedSha256.ToLowerInvariant()) {
    throw "SOURCE_HASH_DIFFERS_FROM_EXPECTED:$actualSourceHash"
}
Write-DeployLog "SOURCE_HASH_OK:$actualSourceHash"

if (-not $ForceReinstall -and (Test-InstalledHealth)) {
    Write-DeployLog 'ALREADY_INSTALLED_HEALTHY'
    [ordered]@{
        status = 'ALREADY_INSTALLED_HEALTHY'
        setupVersion = $ExpectedSetupVersion
        extensionId = $ExpectedExtensionId
        sha256 = $actualSourceHash
    } | ConvertTo-Json -Depth 4
    exit 0
}

New-Item -ItemType Directory -Path $stagingDirectory -Force | Out-Null
Copy-Item $sourceSetup $localSetup -Force
Copy-Item $sourceHash $localHash -Force

$declaredLocalHash = Get-DeclaredHash -Path $localHash
$actualLocalHash = (Get-FileHash $localSetup -Algorithm SHA256).Hash.ToLowerInvariant()
if ($actualLocalHash -ne $declaredLocalHash -or $actualLocalHash -ne $actualSourceHash) {
    throw 'LOCAL_STAGING_HASH_DIVERGENCE'
}
Write-DeployLog "LOCAL_STAGING_OK:$localSetup"

$chromeProcesses = Get-Process chrome -ErrorAction SilentlyContinue
if ($chromeProcesses) {
    Write-DeployLog 'WARNING:CHROME_RUNNING_EXTENSION_ACTIVATION_MAY_REQUIRE_RESTART'
}

Write-DeployLog 'STARTING_SETUP_SILENT'
$process = Start-Process -FilePath $localSetup -ArgumentList '/S' -Wait -PassThru
Write-DeployLog "SETUP_EXIT_CODE:$($process.ExitCode)"
if ($process.ExitCode -ne 0) {
    throw "SETUP_FAILED_EXIT_CODE:$($process.ExitCode)"
}

if (-not (Test-InstalledHealth)) {
    throw 'POST_INSTALL_HEALTH_CHECK_FAILED'
}

$probeText = & $helperPath --probe --workspace $env:TEMP
if ($LASTEXITCODE -ne 0) {
    throw 'HELPER_PROBE_FAILED'
}

try {
    $probe = ($probeText | Out-String) | ConvertFrom-Json
} catch {
    throw 'HELPER_PROBE_INVALID_JSON'
}

if ([string]$probe.helperVersion -ne '0.1.4') {
    throw "HELPER_VERSION_DIVERGENCE:$($probe.helperVersion)"
}
if ([string]$probe.contractVersion -ne '1.2.0') {
    throw "HELPER_CONTRACT_DIVERGENCE:$($probe.contractVersion)"
}
if (-not [bool]$probe.workspaceWritable -or -not [bool]$probe.available) {
    throw 'HELPER_CAPABILITY_CHECK_FAILED'
}

$state = Get-Content $installationState -Raw | ConvertFrom-Json
Write-DeployLog 'DEPLOYMENT_VALIDATED'

$result = [ordered]@{
    status = 'DEPLOYMENT_VALIDATED'
    setupVersion = $ExpectedSetupVersion
    extensionVersion = [string]$state.extensionVersion
    extensionId = [string]$state.extensionId
    helperVersion = [string]$probe.helperVersion
    contractVersion = [string]$probe.contractVersion
    activeDirectoryJoined = [bool]$state.activeDirectoryJoined
    sha256 = $actualLocalHash
    stagingDirectory = $stagingDirectory
    installLog = 'C:\ProgramData\EGBA\ReguaEditorial\Logs\install.log'
    deploymentLog = $LogPath
    chromeRestartRequired = [bool]$chromeProcesses
}

$result | ConvertTo-Json -Depth 6
