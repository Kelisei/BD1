param(
    [Parameter(Mandatory = $true)]
    [string]$ScriptPath
)

Get-Content -Raw $ScriptPath | mysql -u root -p practica
