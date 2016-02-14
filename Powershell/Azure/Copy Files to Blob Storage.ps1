param (
    [string]$SrcArtifactsPath = "$PSScriptRoot\AzurePackage",
    [string]$DestStorageContainerName="dev-build-artifacts\",
    [string]$DestStorageUrl="https://MyStorage.blob.core.windows.net/",
    [string]$DestStorageAccessKey
)

# source of all cool details https://github.com/Microsoft/vso-agent-tasks/

$DestinationContainer = "$DestStorageUrl/$DestStorageContainerName"

$azcopy = Get-ToolPath -Name "AzCopy\AzCopy.exe"
Write-Verbose "Calling AzCopy = $azcopy" -Verbose

$azlog = ("{0}\..\azlog" -f $src)
$args = ("/Source:`"{0}`" /Dest:{1} /DestKey:{2} /S" -f $SrcArtifactsPath, $DestinationContainer, $DestStorageAccessKey)

Write-Verbose "AzCopy Args = $args" -Verbose
Invoke-Tool -Path $azcopy -Arguments $args

# &$azcopy /Source:"$SrcArtifactsPath" /Dest:"$DestStorageUrl/$DestStorageContainerName" /DestKey:$DestStorageAccessKey /S
