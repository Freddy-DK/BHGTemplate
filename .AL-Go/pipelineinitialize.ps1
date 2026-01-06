Start-Job -ScriptBlock {
    # Start BC services in the job to avoid waiting the main job
    . (Join-Path $ENV:GITHUB_WORKSPACE 'Scripts/MyFunctions.ps1')
    MyStartServices
} | Out-Null

Write-Host "Set parent variable 'bcAuthContext'"
$bcAuthContext = @{
    "username" = "admin"
    "password" = ConvertTo-SecureString -String "P@ssword1" -AsPlainText -Force
}
Set-Variable -Name 'bcAuthContext' -value $bcAuthContext -scope 1

Write-Host "Set parent variable 'environment'"
Set-Variable -Name 'environment' -value "http://localhost/BC" -scope 1