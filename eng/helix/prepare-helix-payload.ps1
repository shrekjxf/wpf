[CmdLetBinding()]
Param(
    [string]$platform,
    [string]$configuration
)

$payloadDir = "HelixPayload\$configuration\$platform"

$nugetPackagesDir = Join-Path (Split-Path -Parent $script:MyInvocation.MyCommand.Path) "packages"

# TODO: Once we have the nuget package from the dotnet-wpf-test, we can better understand what we 
# need to do here.
# Create the payload directory. Remove it if it already exists.
if(Test-Path $payloadDir)
{
    Remove-Item $payloadDir -Recurse
}
New-Item -ItemType Directory -Force -Path $payloadDir

function CopyFolderStructure($from, $to)
{
    if(Test-Path $to)
    {
        Remove-Item $to -Recurse
    }
    New-Item -ItemType Directory -Force -Path $to

    if (Test-Path $from)
    {
        Get-ChildItem $from | Copy-Item -Destination $to -Recurse 
    }
    else
    {
        Write-Output "Location doesn't exist: $from"
    }

}

# Copy files from nuget packages
$testNugetLocation = Join-Path $nugetPackagesDir "qv.wpf.test\1.0.0\tools\win-$platform\"
$testPayloadLocation = Join-Path $payloadDir "Test"
CopyFolderStructure $testNugetLocation $testPayloadLocation

# Copy local dotnet install
$localDotnetInstall = Join-Path $env:BUILD_SOURCESDIRECTORY '.dotnet'
$dotnetPayloadLocation = Join-Path $payloadDir "dotnet"
CopyFolderStructure $localDotnetInstall $dotnetPayloadLocation

$configScriptLocation = Join-Path (Split-Path -Parent $script:MyInvocation.MyCommand.Path) "configure-helix-machine.ps1"
Copy-Item $configScriptLocation $payloadDir