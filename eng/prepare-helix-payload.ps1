[CmdLetBinding()]
Param(
    [string]$Platform,
    [string]$Configuration
)

$payloadDir = "HelixPayload\$Configuration\$Platform"

# TODO: Once we have the nuget package from the dotnet-wpf-test, we can better understand what we 
# need to do here.