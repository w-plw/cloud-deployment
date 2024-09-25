$bootTime = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $machine.computer | Select-Object -ExpandProperty LastBootupTime
$upTime = New-TimeSpan -Start $bootTime
$upTimeminutes = [int]$upTime.TotalMinutes

$file = 'C:\inetpub\wwwroot\index.html'
$content = Get-Content -Path $file -Raw
$pattern = 'uptime: \d+ minutes'
$replacement = "uptime: $upTimeminutes minutes"
$content = $content -replace $pattern, $replacement
Set-Content -Path $file -Value $content





