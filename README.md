# PSLogParser

br_spaces 2

## Synopsis

PSLogParser is a wrapper for Microsofts Log Parser. The Module requires the converted LogParser.dll which is not included in this package. At the moment this Module only handle IIS Log's as I needed a quick way to automate my process.

## Code Example

## Installation

Place the module in your $env:PSModulePath. Download and install LogParser. Locate the LogParser.dll in the installation path and
copy it to the {ModulePath}\lib\ folder. Open a Powershell and run

```PowerShell
Import-Module Import-Module -Name PSLogParser
Convert-PSLogParserComLibrary
Test-PSLogParser
```

## References

[Log Parser 2.2 Download Link](https://www.microsoft.com/en-us/download/details.aspx?id=24659)  
[Log Parser 2.2 Documentation](https://technet.microsoft.com/de-de/scriptcenter/dd919274.aspx?f=255&MSPPError=-2147217396)  
[LogParser on msxfaq(German)](https://www.msxfaq.de/tools/mswin/logparser.htm)  
Kristofer Grafvert <http://www.it-notebook.org/iis/article/cs_requests_per_folder.htm>  
[shadow-wizard](https://stackoverflow.com/users/447356/shadow-wizard): <https://stackoverflow.com/a/11203698>  

## License

MIT License

Copyright (c) 2017 Philip Stone

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.