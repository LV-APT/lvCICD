# Determine script location for PowerShell


$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
Write-Host "Current script directory is $ScriptDir"

$LabVIEW_Version = $args[0]
$Architecture = $args[1]
if($LabVIEW_Version){} else {$LabVIEW_Version = '2019'}
if($Architecture){} else {$Architecture = 'x86'}

$LabVIEWExePath = .\LabVIEW_exe_path.ps1 $LabVIEW_Version $Architecture;
$PortNum = .\ViServerPort.ps1 $LabVIEW_Version;
$Operation = $args[2]; if($Operation){} else {$Operation = 'lvEcho'}
$Parameter1 = $args[3]; if ( $Parameter1 ) { $Parameter1 = """$Parameter1""" }
$Parameter2 = $args[4]; if ( $Parameter2 ) { $Parameter2 = """$Parameter2""" }
$Parameter3 = $args[5]; if ( $Parameter3 ) { $Parameter3 = """$Parameter3""" }
$Parameter4 = $args[6]; if ( $Parameter4 ) { $Parameter4 = """$Parameter4""" }
$Parameter5 = $args[7]; if ( $Parameter5 ) { $Parameter5 = """$Parameter5""" }

Write-Host "LabVIEW_Version = $LabVIEW_Version"
Write-Host "Architecture = $Architecture"
Write-Host "Operation = $Operation"
Write-Host "Parameter1 = $Parameter1"
Write-Host "Parameter2 = $Parameter2"
Write-Host "Parameter3 = $Parameter3"
Write-Host "Parameter4 = $Parameter4"
Write-Host "Parameter5 = $Parameter5"
Write-Host "LabVIEWExePath = $LabVIEWExePath"
Write-Host "PortNum = $PortNum"

$lvCICDVIPath = "$ScriptDir\LabVIEW-Adapter\lvCICD.vi"

Write-Host "LabVIEWCLI -OperationName RunVI -VIPath ""$lvCICDVIPath"" -LogFilePath ""$ScriptDir\lVCLI.log"" -LogToConsole True -LabVIEWPath ""$LabVIEWExePath"" -PortNumber $PortNum $Operation $Parameter1 $Parameter2 $Parameter3 $Parameter4 $Parameter5"

LabVIEWCLI -OperationName RunVI `
    -VIPath "$lvCICDVIPath" `
    -LogFilePath "$ScriptDir\lVCLI.log" `
    -LogToConsole True `
    -LabVIEWPath "$LabVIEWExePath" `
    -PortNumber $PortNum `
    $Operation `
    $Parameter1 $Parameter2 $Parameter3 $Parameter4 $Parameter5