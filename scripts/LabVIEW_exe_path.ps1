$LabVIEW_Version = $args[0]
$Architecture = $args[1]
if($LabVIEW_Version){} else {$LabVIEW_Version = '2019'}
if($Architecture){} else {$Architecture = 'x86'}

$ProgramFolder = ''
if( $Architecture -eq 'x64')
{
    $ProgramFolder = 'C:\Program Files'
}
else
{
    $ProgramFolder = 'C:\Program Files (x86)'
}

$LabVIEWExePath = "$ProgramFolder\National Instruments\LabVIEW $LabVIEW_Version\LabVIEW.exe"

return $LabVIEWExePath
