function New-TomlContent
{
    <#
        .SYNOPSIS
        Generates TomlContent for embedding in pyconfig.toml

        .DESCRIPTION
        Generates TomlContent for embedding in pyconfig.toml
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [string]$AuthorName,

        [Parameter(Mandatory)]
        [string]$AuthorEmail,

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
        switch ($BuildSystemType)
        {
            'Hatchling'
            {
                $BuildSystem = '
                    requires = ["hatchling"]
                    build-backend = "hatchling.build"
                '
            }
            'setuptools'
            {
                $BuildSystem = '
                    requires = ["setuptools>=61.0"]
                    build-backend = "setuptools.build_meta"
                '
            }
            'Flit'
            {
                $BuildSystem = '
                    requires = ["flit_core>=3.4"]
                    build-backend = "flit_core.buildapi"
                '
            }
            'PDM'
            {
                $BuildSystem = '
                    requires = ["pdm-pep517"]
                    build-backend = "pdm.pep517.api"
                '
            }

        }

        $BuildSystem = $BuildSystem | ForEach-Object { $_.Trim() }
        $Content = "
            [build-system]
            $BuildSystem

            [project]
            name = `"$($Name)_$($AuthorName)`"
            version = `"0.0.1`"
            authors = [ { name=`"$($AuthorName)`", email=`"$($AuthorEmail)`" } ]
            description = `"$Description`"
            readme = `"README.md`"
            requires-python = `">=3.7`"
            classifiers = [
                `"Programming Language :: Python :: 3`",
                `"License :: OSI Approved :: MIT License`",
                `"Operating System :: OS Independent`",
            ]
        "
        $Content = $Content -split "`r`n" | ForEach-Object { $_.Trim() }
        Write-Verbose "$($Content | Out-String)"
        Add-Content -Path $TomlPath -Value $Content
    }
}
