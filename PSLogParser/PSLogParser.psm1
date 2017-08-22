#Manually set `PSScriptRoot if it isn't set
if(-not $PSScriptRoot)
{
    Write-Host -Object "Manually set `$PSScriptRoot"
    $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}

#Get public and private function definition files.
$Public  = @(Get-ChildItem -Path "$($PSScriptRoot)\Public\*.ps1" -ErrorAction SilentlyContinue )
$Private = @(Get-ChildItem -Path "$($PSScriptRoot)\Private\*.ps1" -ErrorAction SilentlyContinue )

$ModuleRoot = $PSScriptRoot

#Dot source the files
Foreach($import in @($Public + $Private))
{
    Write-Verbose -Message "$($import) found for importing"
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
Update-FormatData -AppendPath "$($PSScriptRoot)\PSLogParser.Format.ps1xml"