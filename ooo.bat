set password=1306
::change     ^^^^^^^^^^^^^      to change password - dont add any spaces
































































































































































































































@ECHO OFF

setlocal
call :setESC 
echo %ESC%[94m - MADE - BY - JAZZII - %ESC%[0m
echo %ESC%[94m      - v0.1.3 -        %ESC%[0m
echo.
echo [Intended use to protect files from other users without pc knowledge]
goto STARTUP
	
:STARTUP
echo.
echo %ESC%[37mIs this a first time launch? (Y/N)%ESC%[0m
echo.
set/p "fst=>"
if %fst%==Y goto FIRSTTIME
if %fst%==y goto FIRSTTIME
if %fst%==n goto PROCEED
if %fst%==N goto PROCEED
echo.
echo %ESC%[31mInvalid Choice%ESC%[0m
goto STARTUP

:FIRSTTIME
driverquery /FO list /v
cls
tree C:
echo.
if EXIST "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK
md ...
echo %ESC%[92mFolder "ooo" created successfully%ESC%[0m
echo.
echo I will only lock the 'ooo'  folder so DO NOT change the name
TIMEOUT /T -1
cls
goto PROCEED
	
:PROCEED
if EXIST "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK
goto CONFIRM
	
:CONFIRM
echo.
echo Would you like to Encrypt (LOCK) the folder? (Y/N)
echo.
set/p "cho=>"
if %cho%==Y goto LOCK
if %cho%==y goto LOCK
if %cho%==n goto END
if %cho%==N goto END
echo.
echo %ESC%[31mInvalid Choice%ESC%[0m
goto CONFIRM
	
:LOCK
ren ooo "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
goto LOCKED
	
:UNLOCK
echo.
echo KEY:
echo.
set/p "pass=>"
if NOT %pass%== %password% goto FAIL
attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" ooo
echo.
echo %ESC%[92mFolder unlocked successfully%ESC%[0m
echo. 
echo %ESC%[37mOptional: Change password? (Y/N)%ESC%[0m
echo.
set/p "cps=>"
if %cps%==Y goto RESETPASS
if %cps%==y goto RESETPASS
if %cps%==n goto UNLOCK_STEP_2
if %cps%==N goto UNLOCK_STEP_2

:UNLOCK_STEP_2
echo.
echo %ESC%[37mOptional: Check Folder Contents? (1(yes)/2(no))%ESC%[0m
echo.
set/p "cds=>"
if %cds%==1 goto CHECKDATA
if %cds%==one goto CHECKDATA
if %cds%==2 goto End
if %cds%==two goto End

:FAIL
echo.
echo %ESC%[31mInvalid Key%ESC%[0m
goto UNLOCK

:LOCKED
echo.
echo %ESC%[92mSuccessfully Locked Folder%ESC%[0m
TIMEOUT /T 10
goto end

:RESETPASS
echo.
echo %ESC%[33m[READ THIS]%ESC%[0m
echo.
echo Make sure to %ESC%[32m*SAVE*%ESC%[0m your password after changing it by just simply saving the notepad (.txt) file
echo The next time you reopen ooo.bat the password will be applied
echo.
pause
start notepad ooo.bat

:CHECKDATA
echo.
tree C:
TIMEOUT /T 10

:End
 exit
 
:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)