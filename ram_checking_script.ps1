<#
  PowerShell script used on Windows Server 2016.
   Script was used to monitor RAM usage and restart application if 
    system has no more resources left as defiened in script!
#>

$trueValue = $true
while ($trueValue = $true){
	$availableMemory = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
	Write-Host "Available memory in MB before service restart : " $availableMemory

	If ($availableMemory -lt 22500) {
		Stop-Process -name chrome
		Write-Host "Chrome closed as there were not enough memory"
		Start-Process -FilePath "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
		Write-Host "Chrome started"
		Start-Sleep 30
	} else {
		Write-Host "Memory usage hadn't reached  required for restart"
		Start-Sleep 30
	}
	$availableMemory = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
	Write-Host "Available memory in MB after memory check / service restart : " $availableMemory
	$trueValue = $true
}
