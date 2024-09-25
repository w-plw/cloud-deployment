$bootTime = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $machine.computer | Select-Object -ExpandProperty LastBootupTime
$upTime = New-TimeSpan -Start $bootTime
$upTimeminutes = [int]$upTime.TotalMinutes

# update uptime time in index.html
$file = 'C:\inetpub\wwwroot\index.html'
$content = Get-Content -Path $file -Raw
$pattern = 'uptime: \d+ minutes'
$replacement = "uptime: $upTimeminutes minutes"
$content = $content -replace $pattern, $replacement
Set-Content -Path $file -Value $content

# update task presence in index.html
$srvIISwwwPath = GetPhysicalPath "Default Web Site"
if (Get-ScheduledTask $SchedTaskName) {
    $srvIISwwwTask = "present"
}
else {
    $srvIISwwwTask = "none"
}
$content = Get-Content -Path $file -Raw
$pattern = 'IIS website update task: .+'
$replacement = "IIS website update task: $srvIISwwwTask"
$content = $content -replace $pattern, $replacement
Set-Content -Path $file -Value $content


