function New-PackageRootFile
{
    <#
        .SYNOPSIS
        Generates the License, README.md and pyproject.toml files

        .DESCRIPTION
        Generates the License, README.md and pyproject.toml files

        .PARAMETER FileName
        Name of the file created in the package root such as:
        'pyproject.toml',
        'README.md',
        'LICENSE'
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory)]
        [ValidateSet(
            'pyproject.toml',
            'README.md',
            'LICENSE'
        )]
        [string]$FileName,

        [Parameter(Mandatory)]
        [string]$Description,

        [Parameter(Mandatory)]
        [ValidateSet(
            'Hatchling',
            'setuptools',
            'Flit',
            'PDM'
        )]
        [string]$BuildSystemType
    )
    Process
    {
        switch ($FileName)
        {
            'pyproject.toml'
            {
                $TomlPath = Join-Path $FullPath $FileName
                New-Item -ItemType File -Path $TomlPath -Force -ErrorAction Stop | Out-Null

                $Splat = @{
                    Name            = $FileName
                    Path            = $TomlPath
                    AuthorName      = $AuthorName
                    AuthorEmail     = $AuthorEmail
                    Description     = $Description
                    BuildSystemType = $BuildSystemType
                }
                New-TomlContent @Splat
            }
            'README.md'
            {
                $ReadMePath = Join-Path $FullPath $FileName
                $Content = "
                    # $FileName

                    $Description
                "
                $Content = $Content -split "`r`n" | ForEach-Object { $_.Trim() }

                Add-Content -Path $ReadMePath -Value $Content
            }
            'LICENSE'
            {
                $LicensePath = Join-Path $FullPath $FileName
                New-MITLicense -Path $LicensePath -AuthorName $AuthorName
            }
        }
    }
}
