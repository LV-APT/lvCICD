# Determine script location for PowerShell


$lvCICD_Tool_dir = Split-Path $script:MyInvocation.MyCommand.Path
Write-Host "lvCICD tool script directory is $lvCICD_Tool_dir"

$LabVIEW_Version = $args[0]
$Architecture = $args[1]
$OperationVIPath = $args[2]
if($LabVIEW_Version){} else {$LabVIEW_Version = '2019'}
if($Architecture){} else {$Architecture = 'x86'}
if($OperationVIPath){} else {$OperationVIPath = "$lvCICD_Tool_dir"}


$LabVIEWExePath = & "$lvCICD_Tool_dir\scripts\LabVIEW_exe_path.ps1" $LabVIEW_Version $Architecture;
$PortNum = & "$lvCICD_Tool_dir\scripts\ViServerPort.ps1" $LabVIEW_Version;
$Operation = $args[3]; if($Operation){} else {$Operation = 'lvEcho'}
$Parameter1 = $args[4]; if ( $Parameter1 ) { $Parameter1 = "'$Parameter1'" }
$Parameter2 = $args[5]; if ( $Parameter2 ) { $Parameter2 = "'$Parameter2'" }
$Parameter3 = $args[6]; if ( $Parameter3 ) { $Parameter3 = "'$Parameter3'" }
$Parameter4 = $args[7]; if ( $Parameter4 ) { $Parameter4 = "'$Parameter4'" }
$Parameter5 = $args[8]; if ( $Parameter5 ) { $Parameter5 = "'$Parameter5'" }
$Parameter6 = $args[9]; if ( $Parameter6 ) { $Parameter6 = "'$Parameter6'" }
$Parameter7 = $args[10]; if ( $Parameter7 ) { $Parameter7 = "'$Parameter7'" }
$Parameter8 = $args[11]; if ( $Parameter8 ) { $Parameter8 = "'$Parameter8'" }
$Parameter9 = $args[12]; if ( $Parameter9 ) { $Parameter9 = "'$Parameter9'" }
$Parameter10 = $args[13]; if ( $Parameter10 ) { $Parameter10 = "'$Parameter10'" }

Write-Host "LabVIEW_Version = $LabVIEW_Version"
Write-Host "Architecture = $Architecture"
Write-Host "OperationVIPath = $OperationVIPath"
Write-Host "Operation = $Operation"
Write-Host "Parameter1 = $Parameter1"
Write-Host "Parameter2 = $Parameter2"
Write-Host "Parameter3 = $Parameter3"
Write-Host "Parameter4 = $Parameter4"
Write-Host "Parameter5 = $Parameter5"
Write-Host "Parameter6 = $Parameter6"
Write-Host "Parameter7 = $Parameter7"
Write-Host "Parameter8 = $Parameter8"
Write-Host "Parameter9 = $Parameter9"
Write-Host "Parameter10 = $Parameter10"
Write-Host "LabVIEWExePath = $LabVIEWExePath"
Write-Host "PortNum = $PortNum"

# Start LabVIEW Process to ensure TCP Port of VI Server is active.
Write-Host "Start-Process -FilePath ""$LabVIEWExePath"""
Start-Process -FilePath "$LabVIEWExePath"

# Wait 10 second for LabVIEW Starting up
Start-Sleep -Seconds 10

$lvCICDVIPath = "$lvCICD_Tool_dir\LabVIEW-Adapter\lvCICD.vi"

Write-Host "LabVIEWCLI -OperationName RunVI -VIPath ""$lvCICDVIPath"" -LogFilePath ""$lvCICD_Tool_dir\lVCLI.log"" -LogToConsole True -LabVIEWPath ""$LabVIEWExePath"" -PortNumber $PortNum ""$OperationVIPath"" $Operation $Parameter1 $Parameter2 $Parameter3 $Parameter4 $Parameter5 $Parameter6 $Parameter7 $Parameter8 $Parameter9 $Parameter10"

LabVIEWCLI -OperationName RunVI `
    -VIPath "$lvCICDVIPath" `
    -LogFilePath "$lvCICD_Tool_dir\lVCLI.log" `
    -LogToConsole True `
    -LabVIEWPath "$LabVIEWExePath" `
    -PortNumber $PortNum `
    "$OperationVIPath" `
    $Operation `
    $Parameter1 `
    $Parameter2 `
    $Parameter3 `
    $Parameter4 `
    $Parameter5 `
    $Parameter6 `
    $Parameter7 `
    $Parameter8 `
    $Parameter9 `
    $Parameter10

$outputVFile="$lvCICD_Tool_dir\output.txt"
Write-Host "lvCICD output is saved to ""$outputVFile"""
$Result=Get-Content -Path "$outputVFile";
Write-Host "Result=$Result";
