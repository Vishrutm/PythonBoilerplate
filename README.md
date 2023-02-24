# PythonBoilerplate
A simple PowerShell module to create Python boilerplates. Work in Progress.

## Why?
I keep forgetting how to do things in Python. This module helps in quick setup. Mostly for my learning.

## Public Functions

| Name | Short Description | Full Documentation |
| ----------- | ----------- | ----------- |
| New-PythonPackage | Creates boilerplate package directory for Python Packages as defined in https://packaging.python.org/en/latest/tutorials/packaging-projects/ | [Documentation](/PythonBoilerplate/Docs/New-PythonPackage.md)


## Notes
### New-PythonPackage
The pyproject.toml file will always contain the following entries:

```toml
version = `"0.0.1`"
readme = `"README.md`"
requires-python = `">=3.7`"
classifiers = [
    `"Programming Language :: Python :: 3`",
    `"License :: OSI Approved :: MIT License`",
    `"Operating System :: OS Independent`",
]
```
