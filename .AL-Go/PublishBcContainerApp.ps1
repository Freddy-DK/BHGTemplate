Param(
    [Hashtable]$parameters
)

. (Join-Path $ENV:GITHUB_WORKSPACE 'Scripts/MyFunctions.ps1')
MyStartServices
MyPublishBcContainerApp @parameters
