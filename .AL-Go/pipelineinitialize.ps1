# Initialize BC Service and set parent variables
# Only if running on GitHub Hosted Windows Runners

if ($env:RUNNER_OS -ne "Windows") {
    Write-Host "Not running on Windows GitHub Hosted Runner. Skipping pipelineinitialize.ps1"
    return
}

Start-Job -ScriptBlock {
    # Start BC services in the job to avoid waiting the main job
    . (Join-Path $ENV:GITHUB_WORKSPACE 'Scripts/MyFunctions.ps1')
    MyStartServices
} | Out-Null

Write-Host "::group::Pipeline Initialize"
Write-Host "Set parent variable 'bcAuthContext'"
$bcAuthContext = @{
    "username" = "admin"
    "password" = ConvertTo-SecureString -String "P@ssword1" -AsPlainText -Force
}
Set-Variable -Name 'bcAuthContext' -value $bcAuthContext -scope 1

Write-Host "Set parent variable 'environment'"
Set-Variable -Name 'environment' -value "http://localhost/BC" -scope 1

Write-Host "Set parent variable 'artifactCachePath'"
Set-Variable -Name 'artifactCachePath' -value "C:\compilerfolder.cache" -scope 1

#Get-ChildItem -Path "c:\" | Out-Host
#Write-Host "C:\COMPILERFOLDER.CACHE"
#Get-ChildItem -Path "C:\compilerfolder.cache" -Recurse | ForEach-Object { Write-Host ".$($_.FullName.SubString(23))" }
#Write-Host "C:\BCARTIFACTS.CACHE"
#Get-ChildItem -Path "C:\bcartifacts.cache" -Recurse | ForEach-Object { Write-Host ".$($_.FullName.SubString(20))" }
#Write-Host "C:\PROGRAM FILES\MICROSOFT DYNAMICS NAV"
#Get-ChildItem -Path "C:\Program Files\Microsoft Dynamics NAV" -Recurse | ForEach-Object { Write-Host ".$($_.FullName.SubString(39))" }
Write-Host "::endgroup::"
