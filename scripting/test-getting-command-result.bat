:: Check if master branch is 
git branch > prev_com.txt
FINDSTR /B /C:"* master" prev_com.txt
IF %errorlevel% NEQ  0 GOTO :EOF