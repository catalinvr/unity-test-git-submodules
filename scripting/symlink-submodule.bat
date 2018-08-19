REM Open cmd as administrator
REM Example: scripting\symlink-submodule submodules\unity-sample-project\SampleProject\Assets\com.company.product DummyProject\Assets\com.company.product_2

@ECHO off

SET SubmoduleSource=%1
SET SubmoduleTarget=%2

IF [%SubmoduleSource%] == [] GOTO :missingSource
IF [%SubmoduleTarget%] == [] GOTO :missingTarget

REM mklink /J DummyProject\Assets\com.company.product_2 submodules\unity-sample-project\SampleProject\Assets\com.company.product
mklink /J %SubmoduleTarget% %SubmoduleSource%
call :updateGitignoreFile %SubmoduleTarget%

GOTO :EOF



:missingSource
ECHO "Source undefined"
GOTO :EOF

:missingTarget
ECHO "Target undefined"
GOTO :EOF

:updateGitignoreFile
call %~dp0\config.bat
call :ignoreAllFilesButKeepDirectory %1
GOTO :EOF

:ignoreAllFilesButKeepDirectory
call :createKeepFile %1
call :ignoreFilesInDirectory %1
GOTO :EOF

:createKeepFile
ECHO. 2>%1/.keep
GOTO :EOF

:ignoreFilesInDirectory
ECHO %GitignoreFile%
ECHO %1
SET Filename=""
call :extractFilename %1 %Filename
FINDSTR %Filename% %GitignoreFile%
IF %errorlevel% EQU 0 GOTO :EOF 
ECHO %1\* >> %GitignoreFile%
ECHO !%1\.keep >> %GitignoreFile%
GOTO :EOF

:extractFilename
SET %2=%~nx1
GOTO :EOF