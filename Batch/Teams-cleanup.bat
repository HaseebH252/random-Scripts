@Echo off
echo Killing Teams
taskkill /IM "teams.exe" /F
echo Removing Cached Files
del /q "%appdata%\Microsoft\Teams\*"
del /q "%AppData%\Microsoft\teams\application cache\cache\*"
del /q "%AppData%\Microsoft\teams\blob_storage\*"
del /q "%AppData%\Microsoft\teams\databases\*"
del /q "%AppData%\Microsoft\teams\cache\*"
del /q "%AppData%\Microsoft\teams\gpucache\*"
del /q "%AppData%\Microsoft\teams\Indexeddb\*"
del /q "%AppData%\Microsoft\teams\Local Storage\*"
del /q "%AppData%\Microsoft\teams\tmp\*"
echo Completed, Please Restart Teams.
pause
