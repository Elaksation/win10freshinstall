#Check Admin Privs
Set-ExecutionPolicy bypass -Force
Write-host "Checking Admin Priviledges..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
function Check-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}


# Join the domain
Write-host 'Joining the domain...'
$Shell = New-Object -ComObject "WScript.Shell"
$Button = $Shell.Popup("GET READY TO JOIN THE DOMAIN.", 0, "DOMAIN TIME", 0)
add-computer –domainname "ad.twistedx.com"






#Installs


Write-Host "Installing Dell Update Utility..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install dell-update -y

choco install -y powershell-core
Write-Host "Installing Google Chrome..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install -y googlechrome

Write-Host ""
Write-Output "Creating BIN folder on C:\" -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
New-Item -Path C:\bin -ItemType "directory"

Write-Host "Installing 7zip..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install 7zip.install -y

Write-Host "Installing NotepadPlusPlus..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install notepadplusplus.install -y

Write-Host "Installing VLC..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install vlc -y

Write-Host "Installing WinDirStat..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install windirstat -y

Write-Host "Installing AdobeReader..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install adobereader -y

Write-Host "Installing Dropbox..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install dropbox -y

Write-Host "Installing Nextcloud..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install nextcloud-client -y

Write-Host "Installing Slack..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install slack -y


#Configure Windows Settings

# Remove Music icon from computer namespace
Write-Host "Removing Music icon from computer namespace..." -ForegroundColor Green 
Write-Host "------------------------------------" -ForegroundColor Green
Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Recurse -ErrorAction SilentlyContinue

# Show hidden files
Write-Host "Showing hidden files..." -ForegroundColor Green 
Write-Host "------------------------------------" -ForegroundColor Green 
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 1

# Show known file extensions
Write-Host "Showing Known File Extensions..." -ForegroundColor Green 
Write-Host "------------------------------------" -ForegroundColor Green 
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

# Show all tray icons
Write-Host "Showing all tray icons..." -ForegroundColor Green 
Write-Host "------------------------------------" -ForegroundColor Green 
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0

#Disable Sticky keys prompt
Write-Host ""
Write-Output ""Disabling Sticky keys prompt..."" -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green 
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"

# Disable Bing Search in Start Menu
Write-Host ""
Write-Output "Disabling Bing in Start Menu..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0

Write-Host ""
Write-Output "Setting the explorer to the actual folder you're in..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1

Write-Host ""
Write-Output "Adding things in your left pane like recycle bin..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1

Write-Host ""
Write-Output "Setting the open PC to This PC, not quick access..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1


#Uninstall Bloatware
Write-Host "Uninstalling Bloatware" -ForegroundColor Yellow
Write-Host "------------------------------------" -ForegroundColor Yellow
function removeApp {
	Param ([string]$appName)
	Write-Output "Trying to remove $appName"
	Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
	Get-AppXProvisionedPackage -Online | Where DisplayName -like $appName | Remove-AppxProvisionedPackage -Online
}

$applicationList = @(
	"Microsoft.3DBuilder"
	"Microsoft.CommsPhone"
	"Microsoft.Getstarted"
	"Microsoft.WindowsMaps"
	"*MarchofEmpires*"
	"*Minecraft*"
	"Microsoft.WindowsSoundRecorder"
	"*Solitaire*"
	"Microsoft.XboxApp"
	"Microsoft.XboxIdentityProvider"
	"Microsoft.ZuneMusic"
	"Microsoft.ZuneVideo"
	"Microsoft.NetworkSpeedTest"
	"Microsoft.FreshPaint"
	"Microsoft.Print3D"
	"*Autodesk*"
	"*BubbleWitch*"
    "king.com*"
    "G5*"
	"*Dell*"
	"*Facebook*"
	"*Keeper*"
	"*Netflix*"
	"*Twitter*"
	"*Plex*"
	"*.Duolingo-LearnLanguagesforFree"
	"*.EclipseManager"
	"ActiproSoftwareLLC.562882FEEB491" # Code Writer
	"*.AdobePhotoshopExpress"
);

foreach ($app in $applicationList) {
    removeApp $app
}



#Disable Sleep on AC Power
Write-Host ""
Write-Host "Disable Sleep on AC Power..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Powercfg /Change monitor-timeout-ac 20
Powercfg /Change standby-timeout-ac 0

# Disable Xbox Gamebar
Write-Host ""
Write-Output "Disable XBox Gamer Bar..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0

#--- Hide Cortana via Registry bit and restart explorer ---
Write-Host ""
Write-Output "Hiding Cortana..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0

# Turn off People in Taskbar
Write-Host ""
Write-Output "Turning off People in Taskbar..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0

# Privacy: Let apps use my advertising ID: Disable
Write-Host ""
Write-Output "Disabling Advertising ID..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

#Restart Explorer Process
Write-Host ""
Write-Host "Restarting Explorer" -ForegroundColor Yellow
Write-Host "------------------------------------" -ForegroundColor Yellow
Stop-Process -ProcessName Explorer


#Add 'This PC' Desktop Icon
Write-Host ""
Write-Host "Add 'This PC' Desktop Icon..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$thisPCIconRegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
$thisPCRegValname = "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" 
$item = Get-ItemProperty -Path $thisPCIconRegPath -Name $thisPCRegValname -ErrorAction SilentlyContinue 
if ($item) { 
    Set-ItemProperty  -Path $thisPCIconRegPath -name $thisPCRegValname -Value 0  
} 
else { 
    New-ItemProperty -Path $thisPCIconRegPath -Name $thisPCRegValname -Value 0 -PropertyType DWORD | Out-Null  
} 

#Enable Godmode Menu
if (-Not (Test-Path -Path '$env:USERPROFILE\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}' -Pathtype Container)) {
    Write-Host ""
    Write-Host "Creating GodMode Menu on Desktop..." -ForegroundColor Green
    Write-Host "------------------------------------" -ForegroundColor Green
    $godmodeSplat = @{
    Path = "$env:USERPROFILE\Desktop"
    Name = "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
    ItemType = 'Directory'
    }
    New-Item @godmodeSplat
}
else {
Write-Host "GodMode Menu already exists." -ForegroundColor Yellow
}


# Create Hidden IT folder
Write-host 'Creating Hidden IT Folder...'-ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$itdir = "C:\NTSERVICE"
if (test-path $itdir)
{
}
else
{
    New-Item -ItemType Directory -Force -Path $itdir | foreach {$_.Attributes = "Hidden"}
}

#Create RunOnce Regkey
Write-Host "Creating RunOnce Regkey..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name install -Value "D:\install3.ps1"

# Clean up trash.
Write-Host "Cleaning up Trash..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Remove-Item "$env:USERPROFILE\Desktop\*.ini" -Force


Write-Host "------------------------------------" -ForegroundColor Red

#Restart-Computer
#Read-Host -Prompt "Setup is done, restart is needed, press [ENTER] to restart computer."
Restart-Computer