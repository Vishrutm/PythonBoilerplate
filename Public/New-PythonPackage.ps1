function New-PythonPackage
{
    <#
        .SYNOPSIS
        Creates boilerplate package directory for Python Packages as defined in
        https://packaging.python.org/en/latest/tutorials/packaging-projects/

        .DESCRIPTION
        Creates boilerplate package directory for Python Packages as defined in
        https://packaging.python.org/en/latest/tutorials/packaging-projects/

        .OUTPUTS
        [System.IO.DirectoryInfo]
        [System.IO.FileInfo]

        .PARAMETER PackageName
        Name of the package

        .PARAMETER Path
        Path of the folder in which the package directory will be created in

        .PARAMETER AuthorName
        Name of the author of the python package. This gets embedded into the LICENSE, README.md and the pyproject.toml
        files (found at the root level of the python package)

        .PARAMETER AuthorEmail
        Email of the author of the python package. This gets embedded into the pyproject.toml file (found at the root
        level of the python package)

        .PARAMETER Force
        Overwrite any existing package paths

        .PARAMETER Description
        A description for the python package. This is embedded in the README.md (found at the root level of the python
        package)

        .PARAMETER ShowWindow
        Opens the newly created package folder in the explorer

        .PARAMETER PassThru
        Shows the directory structure using the Tree Command

        .EXAMPLE
        $Splat = @{
            PackageName = 'sample1'
            Path        = 'C:\Projects'
            Description = 'A simple sample'
            AuthorName  = 'Vishrut Mittal'
            AuthorEmail = 'vishrutm94@gmail.com'
        }
        New-PythonPackage @Splat

        Creates the directory in 'C:\Projects\sample1'. Nothing is returned in output unless the -PassThru switch is passed

        .EXAMPLE
        $Splat = @{
            PackageName     = 'sample1'
            Path            = 'C:\Projects'
            Description     = 'A simple sample'
            AuthorName      = 'Vishrut Mittal'
            AuthorEmail     = 'vishrutm94@gmail.com'
            BuildSystemType = 'Hatchling'
        }
        New-PythonPackage @Splat

        Creates the directory in 'C:\Projects\sample1'. The pyproject.toml file contains the Hatchling tool requirements.
        Defaults to setup tools when this parameter is not passed

        .EXAMPLE
        $Splat = @{
            PackageName = 'leetcode_timer'
            Path        = 'C:\Projects'
            Description = 'A timer for leetcode OA'
            ShowWindow  = $true
            PassThru    = $true
            AuthorName  = 'Vishrut Mittal'
            AuthorEmail = 'vishrutm94@gmail.com'
        }
        New-PythonPackage @Splat

        C:\PROJECTS\LEETCODE_TIMER
        |   LICENSE
        |   pyproject.toml
        |   README.md
        |
        +---src
        |   \---leetcode_timer
        |           leetcode_timer.py
        |           __init__.py
        |
        \---tests

        Displays directory structure and opens directory in windows explorer
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.IO.DirectoryInfo], [System.IO.FileInfo])]
    Param
    (
        [Parameter(Mandatory)]
        [ValidateScript({
                if ($_ -notmatch '\s+')
                {
                    $true
                }
                else
                {
                    throw 'Name should not contain whitespaces'
                }
            })]
        [string]$PackageName,

        [Parameter(Mandatory)]
        [string]$AuthorName,

        [Parameter(Mandatory)]
        [string]$AuthorEmail,

        [Parameter(Mandatory)]
        [string]$Description,

        [Parameter(Mandatory)]
        [ValidateScript({
                if (Test-Path $_)
                {
                    $true
                }
                else
                {
                    throw "Path '$_' does not exist"
                }
            })]
        [string]$Path,

        [Parameter()]
        [ValidateSet(
            'Hatchling',
            'setuptools',
            'Flit',
            'PDM'
        )]
        [string]$BuildSystemType,

        [Parameter()]
        [switch]$Force,

        [Parameter()]
        [switch]$ShowWindow,

        [Parameter()]
        [switch]$PassThru
    )
    Begin
    {
        # ValidateSet is not working with default values?
        if (-not $BuildSystemType)
        {
            $BuildSystemType = 'setuptools'
        }
    }
    Process
    {
        try
        {
            $FullPath = Join-Path $Path $PackageName

            if ((Test-Path $FullPath) -and (-not $Force))
            {
                throw "Path '$FullPath' already exists. Pass the -Force switch to force create directory"
            }

            Write-Verbose "Creating directory in $FullPath"
            $Splat = @{
                Path        = $FullPath
                ItemType    = 'Directory'
                Force       = $Force
                ErrorAction = 'Stop'
            }
            New-Item @Splat | Out-Null

            # This hashtable represents the directory structure
            $Structure = @{
                Root  = @(
                    'LICENSE',
                    'pyproject.toml',
                    'README.md'
                )
                src   = @(
                    '__init__.py',
                    "$PackageName.py"
                )
                tests = $null
            }

            $Structure.Keys | ForEach-Object {
                $Key = $_
                switch ($Key)
                {
                    'Root'
                    {
                        Write-Verbose "Adding root level files"
                        $Structure['Root'] | ForEach-Object {
                            New-PackageRootFile -FileName $_ -Description $Description -BuildSystemType $BuildSystemType
                        }
                    }
                    'src'
                    {
                        Write-Verbose "Adding src level files"
                        $SrcPath = Join-Path $FullPath 'src'
                        New-Item -ItemType Directory -Path $SrcPath -Force | Out-Null

                        $Name = Join-Path $SrcPath $PackageName
                        New-Item -ItemType Directory -Path $Name -Force | Out-Null

                        $Structure['src'] | ForEach-Object {
                            New-Item -ItemType File -Path (Join-Path $Name $_) -Force | Out-Null
                        }
                    }
                    default
                    {
                        Write-Verbose "Adding '$_' directory"
                        New-Item -ItemType Directory -Path (Join-Path $FullPath $_) -Force | Out-Null
                    }
                }
            }

            # Tree is MUCH better than Get-ChildItem for representation. Although what is returned is a string and not a PSObject
            if ($PassThru)
            {
                tree /A $FullPath /F | Select-Object -Skip 2
            }

            if ($ShowWindow)
            {
                explorer.exe $FullPath
            }
        }
        catch
        {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}
