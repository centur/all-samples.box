$currentPath = $(Split-Path $MyInvocation.MyCommand.Path)
$Command ="$currentPath\..\packages\AutoRest.0.9.7\tools\AutoRest.exe"

$apiSuffix = "SampleProxy"
$jsonUrl = "http://pathtoswagger.com.au/swagger/docs/v1"

$jsonFileName = "$currentPath\$apiSuffix.swagger.json"

$GeneratedNamespace = "SampleApp.$apiSuffix";
$GeneratedPath = "$currentPath\..\PathToSwaggerProject\$apiSuffix";
$GeneratedHeader += [System.Environment]::NewLine + """IMPORTANT: This class is auto-generated. Any changes to it will be lost during proxy re-generation process"""
$GeneratedHeader += [System.Environment]::NewLine + """Generated by AutoRest ($Command) from $jsonUrl"""
$GeneratedHeader += [System.Environment]::NewLine + """Visit https://github.com/Azure/autorest for details and usage examples."""


#Download json to file
(Invoke-webrequest -URI $jsonUrl).Content | Set-Content $jsonFileName

$Parameters = "-CodeGenerator CSharp -Modeler Swagger -Input $jsonFileName -Namespace $GeneratedNamespace -OutputDirectory $GeneratedPath -Header $GeneratedHeader -AddCredentials true"
$paramsArray = $Parameters.Split(" ")

# Build up command and execute it
& "$Command" $paramsArray
