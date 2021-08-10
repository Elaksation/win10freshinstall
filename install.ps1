#7/26 Boxstarter/Choco script#
#Download Avaya and RMM into ntservice download folder before starting script#
#Run from Elevated PS#

#Install Choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install powershell-core --pre -y

#Create RunOnce Regkey
Write-Host "Creating RunOnce Regkey..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name install -Value "D:\install2.ps1"

#Create PSDrive for HKEY_CLASSES_ROOT
Write-Host "Creating PSDrive for HKEY_CLASSES_ROOT" -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
New-PSDrive HKCR Registry HKEY_CLASSES_ROOT


#Configure Double Clicking Powershell Scripts to Launch Directly
Write-Host "Configuring Double Click to Launch PS Scripts..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty HKCR:\Microsoft.PowerShellScript.1\Shell '(Default)' 0

#Set Powershell as Default Value for .ps1 file launch
Write-Host "Configuring Powershell as Default Program for .PS1 Files..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty HKCR:\Microsoft.PowerShellScript.1\Shell\Open\Command '(Default)' '"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "%1"'

#Install Windows Update Module
Write-Host "Installing Windows Update Module" -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
#TLS Setting
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Trust PowerShell Gallery - this will avoid you getting any prompts that it's untrusted
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

#Install NuGet
Install-PackageProvider -name NuGet -Force

#Install Module
Install-Module PSWindowsUpdate
Import-Module -Name PSWindowsUpdate

#Restart-Computer
#Read-Host -Prompt "Setup is done, restart is needed, press [ENTER] to restart computer."
Restart-Computer
