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

Function Test-PSLogParser {

    <#
.SYNOPSIS
Execute some tests to verify PS Log Parser is ready
.DESCRIPTION
Execute some tests to verify PS Log Parser is ready
.EXAMPLE
Test-PSLogParser
.NOTES

    NAME:     Test-PSLogParser
    VERSION:  1.0
    AUTHOR:   Philip Stone (Philip.Stone@bbc-chartering.com)
    LASTEDIT: 2017-08-21 16:39:25
#>

    [CmdletBinding()]
    Param(
    )

    BEGIN {
    
    }

    PROCESS {
        if (Test-Path "$($ModuleRoot)\lib\Interop.MSUtil.dll") {
            Write-Verbose -Message "Interop.MSUtil.dll Succesfully located"
        }
        else {
            if (Test-Path -Path "$($ModuleRoot)\lib\LogParser.dll") {
                throw "Unable to locate Interop.MSUtil.dll but LogParser.dll was found in library`n
                It's required to convert the file with Tlbimp.exe (Type Library Importer) into a common language runtime assembly.`n
                You can try Convert-PSLogParserComLibrary or you use"
            }
            throw "Missing Assembly Interop.MSUtil.dll"
        }
    }

    END {
    
    }
}