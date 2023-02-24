Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public')  | ForEach-Object { . $_.FullName }
Get-ChildItem -Path (Join-Path $PSScriptRoot 'Private') | ForEach-Object { . $_.FullName }

$PSDefaultParameterValues = @{
    "Add-Content:Encoding" = "utf8"
}
