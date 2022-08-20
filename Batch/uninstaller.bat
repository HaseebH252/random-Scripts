@Echo OFF
set application=""
echo Uninstalling any old versions of 8x8....
powershell.exe "Get-Package -Name *%application%* | Uninstall-Package -Force -ErrorAction silentlycontinue"
echo Uninstalled!

