@echo off
echo N|gpupdate /force
echo.
net stop bits
net stop wuauserv
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f  
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f  
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f 
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientIDValidation /f 
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v LastWaitTimeout /f
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v DetectionStartTime /f
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v NextDetectionTime /f
rd /s /q "C:\WINDOWS\SoftwareDistribution"
net start bits
net start wuauserv
wuauclt /scannow
wuauclt /resetauthorization /detectnow
wuauclt /r /ReportNow
wuauclt /UpdateNow
rem shutdown -r -t 0
PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()
C:\windows\system32\USOClient scaninstallwait