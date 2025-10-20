param(
    [Parameter(Mandatory = $true)]
    [string]$ScriptPath
)

Get-Content $ScriptPath | mysql -u root -p practica
