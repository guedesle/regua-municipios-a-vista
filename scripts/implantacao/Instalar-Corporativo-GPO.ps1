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
$staging = Join-Path $LocalStagingRoot $ExpectedSetupVersion
$localSetup = Join-Path $staging $setupName
$localHash = Join-Path $staging $hashName
$productKey = 'HKLM:\Software\EGBA\ReguaEditorial'
$helper = "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe"
$installationState = "$env:ProgramData\EGBA\ReguaEditorial\state\installation.json"
$policyState = "$env:ProgramData\EGBA\ReguaEditorial\state\chrome-policy.json"

function Write-DeployLog([string]$Message) {
    New-Item -ItemType Directory (Split-Path $LogPath -Parent) -Force | Out-Null
    $line = '{0} {1}' -f (Get-Date).ToString('s'), $Message
    Add-Content $LogPath $line -Encoding UTF8
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
    if (-not [bool]$computer.PartOfDomain) { throw 'ACTIVE_DIRECTORY_REQUIRED' }
    [string]$computer.Domain
}

function Get-DeclaredHash([string]$Path) {
    $value = ((Get-Content $Path -Raw).Trim() -split '\s+')[0].ToLowerInvariant()
    if ($value -notmatch '^[a-f0-9]{64}$') { throw 'INVALID_SHA256_FILE' }
    $value
}

function Test-InstalledHealth {
    $product = Get-ItemProperty $productKey -ErrorAction SilentlyContinue
    if (-not $product -or [string]$product.Version -ne $ExpectedSetupVersion) { return $false }
    if (-not (Test-Path $helper -PathType Leaf)) { return $false }
    if (-not (Test-Path $installationState -PathType Leaf)) { return $false }
    if (-not (Test-Path $policyState -PathType Leaf)) { return $false }
    try {
        $state = Get-Content $installationState -Raw | ConvertFrom-Json
        return [string]$state.extensionId -eq $ExpectedExtensionId -and [string]$state.extensionVersion -eq '0.7.4'
    } catch { return $false }
}

Assert-Administrator
$domain = Assert-ActiveDirectory
Write-DeployLog "DOMAIN_OK:$domain"

foreach ($required in @($sourceSetup, $sourceHash)) {
    if (-not (Test-Path $required -PathType Leaf)) { throw "SOURCE_ASSET_MISSING:$required" }
}

$declared = Get-DeclaredHash $sourceHash
$actual = (Get-FileHash $sourceSetup -Algorithm SHA256).Hash.ToLowerInvariant()
if ($actual -ne $declared) { throw 'SOURCE_HASH_DIVERGENCE' }
if ($ExpectedSha256 -and $actual -ne $ExpectedSha256.ToLowerInvariant()) { throw 'SOURCE_HASH_DIFFERS_FROM_EXPECTED' }
Write-DeployLog "SOURCE_HASH_OK:$actual"

if (-not $ForceReinstall -and (Test-InstalledHealth)) {
    Write-DeployLog 'ALREADY_INSTALLED_HEALTHY'
    [ordered]@{ status='ALREADY_INSTALLED_HEALTHY'; setupVersion=$ExpectedSetupVersion; sha256=$actual } | ConvertTo-Json
    exit 0
}

New-Item -ItemType Directory $staging -Force | Out-Null
Copy-Item $sourceSetup $localSetup -Force
Copy-Item $sourceHash $localHash -Force
if ((Get-FileHash $localSetup -Algorithm SHA256).Hash.ToLowerInvariant() -ne $actual) { throw 'LOCAL_STAGING_HASH_DIVERGENCE' }

if (Get-Process chrome -ErrorAction SilentlyContinue) { Write-DeployLog 'WARNING:CHROME_RUNNING_RESTART_REQUIRED' }
Write-DeployLog 'STARTING_SETUP_SILENT'
$process = Start-Process $localSetup -ArgumentList '/S' -Wait -PassThru
Write-DeployLog "SETUP_EXIT_CODE:$($process.ExitCode)"
if ($process.ExitCode -ne 0) { throw "SETUP_FAILED_EXIT_CODE:$($process.ExitCode)" }
if (-not (Test-InstalledHealth)) { throw 'POST_INSTALL_HEALTH_CHECK_FAILED' }

$probeText = & $helper --probe --workspace $env:TEMP
if ($LASTEXITCODE -ne 0) { throw 'HELPER_PROBE_FAILED' }
$probe = ($probeText | Out-String) | ConvertFrom-Json
if ([string]$probe.helperVersion -ne '0.1.4' -or [string]$probe.contractVersion -ne '1.2.0') { throw 'HELPER_VERSION_OR_CONTRACT_DIVERGENCE' }
if (-not [bool]$probe.workspaceWritable -or -not [bool]$probe.available) { throw 'HELPER_CAPABILITY_CHECK_FAILED' }

$state = Get-Content $installationState -Raw | ConvertFrom-Json
Write-DeployLog 'DEPLOYMENT_VALIDATED'
[ordered]@{
    status='DEPLOYMENT_VALIDATED'
    setupVersion=$ExpectedSetupVersion
    extensionVersion=[string]$state.extensionVersion
    extensionId=[string]$state.extensionId
    helperVersion=[string]$probe.helperVersion
    contractVersion=[string]$probe.contractVersion
    sha256=$actual
    stagingDirectory=$staging
    deploymentLog=$LogPath
} | ConvertTo-Json -Depth 5
