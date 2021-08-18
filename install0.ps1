Set-ExecutionPolicy Bypass -Force


#Create RunOnce Regkey
Write-Host "Creating RunOnce Regkey..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name install -Value "D:\install.ps1"


#Rename Computer
$Shell = New-Object -ComObject "WScript.Shell"
$Button = $Shell.Popup("GET READY TO RENAME THE MACHINE.", 0, "RENAME TIME", 0)
$Rename = Read-Host 'Time to rename this machine. Enter the new name.' -AsSecureString
$Newname = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Rename))
Rename-Computer -NewName "$NewName" 



Restart-Computer







