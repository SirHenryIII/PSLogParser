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

Function Get-IISLog
{

<#
.SYNOPSIS
Convert a IIS Log File with LogParser
.DESCRIPTION
Convert a IIS Log File with LogParser
.PARAMETER Query
LogParser Query String
.EXAMPLE
Get-IISLog -Query "SELECT cs-username, date, time, c-ip, cs-uri-stem, cs(User-Agent) FROM u_ex170720.log WHERE cs-method LIKE '%post%' and cs-uri-stem LIKE '%Microsoft-Server-ActiveSync%'"
.NOTES

    NAME:     Get-IISLog
    VERSION:  1.0
    AUTHOR:   Philip Stone (Philip.Stone@bbc-chartering.com)
    LASTEDIT: Date
#>

    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline = $false, Mandatory = $true, ValueFromPipelineByPropertyName = $false, ParameterSetName = "Default")]
        [ValidateNotNullOrEmpty()]
        [string]
        $Query
    )

    BEGIN
    {
        $LogParserDll = "$($ModuleRoot)\lib\Interop.MSUtil.dll"
        try {
            Test-PSLogParser
            Add-Type -Path $LogParserDll
        }
        catch {
            throw "Unable to load LogParser Assembly`n$($_.Exception.Message)"
        }
    }

    PROCESS
    {
        $LogQuery = New-Object -TypeName Interop.MSUtil.LogQueryClassClass
        $IISW3CInputFormat = new-object Interop.MSUtil.COMIISW3CInputContextClassClass

        Write-Verbose -Message "Processing Query: $($Query)"

        $LogRecordSet = $LogQuery.Execute($Query, $IISW3CInputFormat)

        $ColumnCount = $LogRecordSet.getColumnCount()

        $ColumnTable = @{}
        for ($i = 0; $i -lt $ColumnCount; $i++) {
            $ColumnTable[$i] = $LogRecordSet.getColumnName($i)
        }

        Write-Verbose -Message "Column Table $($ColumnTable.Values -split ';')"
        
        if($LogRecordSet.atEnd()){
            Write-Warning -Message "The query didn't return any data!"
            return
        }

        $LogResult = @()

        do {
            $LogRecord = $LogRecordSet.getRecord()
            $LogEntry = @{}
            foreach ($Column in $ColumnTable.Keys) {
                $LogEntry[$ColumnTable[$Column]] = $LogRecord.getValue($Column)
            }
            Write-Verbose -Message "$($ColumnTable[0]): $($LogRecord.getValue(0))"
            $LogResult += New-Object -TypeName psobject -Property $LogEntry
            $LogRecordSet.moveNext()
        } until ($LogRecordSet.atEnd())
    }

    END
    {
    
    }
}