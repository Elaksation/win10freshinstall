
#Installing applications not available in Chocolatey
Write-Host ""
Write-Host "Installing applications not available in Chocolatey" -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

#Install RMM
Set-ExecutionPolicy Bypass -force
Write-Host "Installing RMM..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

Start-Process msiexec.exe -Wait -ArgumentList '/I D:\installers\TWXRMM.msi /quiet' 

#Install Avaya
Write-Host "Installing Avaya..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Start-Process msiexec.exe -Wait -ArgumentList '/I D:\installers\avayacloudmsi.msi /quiet' 

#Windows Update Pass
Write-Host "Windows Updates Pass..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
#Check what updates are required for this server
Get-WindowsUpdate

#Accept and install 20h2 Update. 
Install-WindowsUpdate -Title "Cumulative" -AcceptAll -IgnoreReboot


#Restart
#Read-Host -Prompt "Setup is done, restart is needed, press [ENTER] to restart computer."
Restart-Computer 