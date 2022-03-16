function Get-IniFile
{
    param(
        [parameter(Mandatory = $true)] [string] $filePath
    )

    $anonymous = "NoSection"

    $ini = @{}
    switch -regex -file $filePath
    {
        "^\[(.+)\]$" # Section
        {
            $section = $matches[1]
            $ini[$section] = @{}
            $CommentCount = 0
        }

        "^(;.*)$" # Comment
        {
            if (!($section))
            {
                $section = $anonymous
                $ini[$section] = @{}
            }
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = "Comment" + $CommentCount
            $ini[$section][$name] = $value
        }

        "(.+?)\s*=\s*(.*)" # Key
        {
            if (!($section))
            {
                $section = $anonymous
                $ini[$section] = @{}
            }
            $name,$value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }

    return $ini
}

$cfgPath = "C:\Program Files (x86)\National Instruments\LabVIEW 2019\LabVIEW.ini"
$fileContent = Get-IniFile $cfgPath
if ($fileContent["LabVIEW"]["server.tcp.enabled"])
{
}
else{
	Add-Content $cfgPath "server.tcp.enabled=True"
}

if($fileContent["LabVIEW"]["server.tcp.port"])
{
	$portNum = $fileContent["LabVIEW"]["server.tcp.port"]
}
else{
	$portNum=3363
}
echo $portNum
