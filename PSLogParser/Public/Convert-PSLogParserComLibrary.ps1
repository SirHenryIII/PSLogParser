#MIT License
#
#Copyright (c) 2017 Philip Stone
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

Function Convert-PSLogParserComLibrary {

    <#
.SYNOPSIS
Convert the LibParser.dll from a COM Type Library into language runtime assembly
.DESCRIPTION
Convert the LibParser.dll from a COM Type Library into language runtime assembly
.EXAMPLE
Convert-PSLogParserComLibrary
.NOTES

    NAME:     Convert-PSLogParserComLibrary
    VERSION:  1.0
    AUTHOR:   Philip Stone (Philip.Stone@bbc-chartering.com)
    LASTEDIT: 2017-08-22 11:12:48
#>

    [CmdletBinding()]
    Param(
    )

    BEGIN {
    
    }

    PROCESS {
        $SDKPathDefault = ("$($env:ProgramFiles)\Microsoft SDKs\Windows\", "$(${env:ProgramFiles(x86)})\Microsoft SDKs\Windows\")
        $Tlbimp = $SDKPathDefault | ForEach-Object {Get-ChildItem -Path $_ -Filter "Tlbimp.exe" -Recurse -ErrorAction SilentlyContinue} | Sort-Object -Property CreationTime -Descending | Select-Object -First 1
        if ($Tlbimp -eq $null) {
            throw "Unable to locate Tlbimp.exe"
        }

        $ComLibrary = "$($ModuleRoot)\lib\LogParser.dll"
        #$ComLibrary = "\..\lib\LogParser.dll"
        if (-not (Test-Path $ComLibrary -ErrorAction SilentlyContinue)) {
            throw "Unable to locate LogParser.dll, please copy the LogParser.dll to $($ComLibrary)"
        }

        $TargetLibrary = "$($ModuleRoot)\lib\Interop.MSUtil.dll"
        #$TargetLibrary = "lib\Interop.MSUtil.dll"
        Try { [io.file]::OpenWrite($TargetLibrary).Close() }
        Catch { Write-Warning "Unable to write to output file $outputfile" }
        $TargetLibrary.Length
        . $Tlbimp.FullName "$($ComLibrary)" /out:"$($TargetLibrary)"

        if ($? -and (Test-Path -Path $TargetLibrary)) {
            Write-Host -Object "Type Library Importer return success and file was created $($TargetLibrary)"
        }
    }

    END {
    
    }
}