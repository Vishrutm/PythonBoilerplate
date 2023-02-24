@{
    RootModule        = 'PythonBoilerplate.psm1'
    ModuleVersion     = '0.0.1'
    GUID              = '3101fa06-1cab-41d8-b3ae-0535a01f6640'
    Author            = 'Vishrut Mittal'
    CompanyName       = ''
    Copyright         = 'Copyright (c) 2023, Vishrut Mittal. All rights reserved.'
    Description       = 'A PowerShell module for common setup related to Python'
    PowerShellVersion = '5.1'
    RequiredModules   = @()
    FunctionsToExport = @(
        'New-PythonPackage'
    )
    PrivateData       = @{
        PSData = @{}
    }
}
