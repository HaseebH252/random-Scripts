@Echo OFF
set application=""
echo Uninstalling any versions of %application%....
powershell.exe "Get-Package -Name *%application%* | Uninstall-Package -Force -ErrorAction silentlycontinue"
echo Uninstalled!

