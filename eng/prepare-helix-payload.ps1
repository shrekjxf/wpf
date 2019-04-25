[CmdLetBinding()]
Param(
    [string]$platform,
    [string]$configuration
)

$payloadDir = "HelixPayload\$configuration\$platform"

# TODO: Once we have the nuget package from the dotnet-wpf-test, we can better understand what we 
# need to do here.