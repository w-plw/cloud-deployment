
#for VM custom script extension script deployment - lesson 073

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools
# Download web files
Invoke-WebRequest https://raw.githubusercontent.com/w-plw/cloud-deployment/refs/heads/main/bicep-json-templates/.tests/index.html -OutFile C:\inetpub\wwwroot\index.htm


$srvname = $Env:computername
$srvProc = (Get-CimInstance Win32_Processor).Name
$srvMem  = ((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb).TOString()+" GB"

$bootTime = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $machine.computer | Select-Object -ExpandProperty LastBootupTime
$upTime = New-TimeSpan -Start $bootTime
$upTimeminutes = [int]$upTime.TotalMinutes

function Replace-TextInFile {
    param(
        [string]$filePath,
        [string]$oldText,
        [string]$newText
    )

    # Read the file content
    $content = Get-Content $filePath

    # Replace the text
    $newContent = $content -replace $oldText, $newText

    # Write the new content back to the file
    $newContent | Set-Content $filePath
}

# replace text with function call
Replace-TextInFile -filePath 'C:\inetpub\wwwroot\index.htm' -oldText 'load balancing tests.</p>' -newText "load balancing tests.</p><p>vm instance hostname: $srvname<br>uptime: $upTimeminutes minutes<br>processor: $srvProc<br>memory: $srvMem</p>"
