# New-PythonPackage

## SYNOPSIS
Creates boilerplate package directory for Python Packages as defined in
https://packaging.python.org/en/latest/tutorials/packaging-projects/

## SYNTAX

```
New-PythonPackage [-PackageName] <String> [-AuthorName] <String> [-AuthorEmail] <String>
 [-Description] <String> [-Path] <String> [[-BuildSystemType] <String>] [-Force] [-ShowWindow] [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates boilerplate package directory for Python Packages as defined in
https://packaging.python.org/en/latest/tutorials/packaging-projects/

## EXAMPLES

### EXAMPLE 1
```
$Splat = @{
    PackageName = 'sample1'
    Path        = 'C:\Projects'
    Description = 'A simple sample'
    AuthorName  = 'Vishrut Mittal'
    AuthorEmail = 'vishrutm94@gmail.com'
}
New-PythonPackage @Splat
```

Creates the directory in 'C:\Projects\sample1'.
Nothing is returned in output unless the -PassThru switch is passed

### EXAMPLE 2
```
$Splat = @{
    PackageName     = 'sample1'
    Path            = 'C:\Projects'
    Description     = 'A simple sample'
    AuthorName      = 'Vishrut Mittal'
    AuthorEmail     = 'vishrutm94@gmail.com'
    BuildSystemType = 'Hatchling'
}
New-PythonPackage @Splat
```

Creates the directory in 'C:\Projects\sample1'.
The pyproject.toml file contains the Hatchling tool requirements.
Defaults to setup tools when this parameter is not passed

### EXAMPLE 3
```
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
```

Displays directory structure and opens directory in windows explorer

## PARAMETERS

### -PackageName
Name of the package

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthorName
Name of the author of the python package.
This gets embedded into the LICENSE, README.md and the pyproject.toml
files (found at the root level of the python package)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthorEmail
Email of the author of the python package.
This gets embedded into the pyproject.toml file (found at the root
level of the python package)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
A description for the python package.
This is embedded in the README.md (found at the root level of the python
package)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Path of the folder in which the package directory will be created in

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BuildSystemType
{{ Fill BuildSystemType Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Overwrite any existing package paths

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowWindow
Opens the newly created package folder in the explorer

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Shows the directory structure using the Tree Command

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).


## OUTPUTS

### [System.IO.DirectoryInfo]
### [System.IO.FileInfo]

