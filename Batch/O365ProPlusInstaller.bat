echo "Installing Microsoft 365 Apps for Enterprise."

@REM Set true if you also want Visio or Project installed
set "projectinstalled=false"
set "visioinstalled=false"

@REM Enter path and configure.xml file for Office installer
set o365installer_path=""
set o365installer_xml=""



echo "Installing Microsoft Apps for Enterprise"
"%o365installer_path%" /Configure "%o365installer_xml%"

echo "Installed."

set visioinstaller_path=""
set visioinstaller_xml=""
 

if "%visioinstalled%" == "true"(
	echo "Installing Visio 365"

	"%visioinstaller_path%" /configure "%visioinstaller_xml%"
	echo "Visio Installed"
)


set projectinstaller_path=""
set projectinstaller_xml=""

if "%projectinstalled% == "true"(
	echo "Installing Project 365"	"%projectinstaller_path%" /configure "%projectinstaller_xml%"
	echo "Project Installed"

)