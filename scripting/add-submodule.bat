REM Example: scripting\add-submodule https://github.com/lars-wobus/unity-sample-project unity-sample-project

call %~dp0\config.bat

SET GitRepository=%1
SET ProjectName=%2

IF [%GitRepository%] == [] GOTO :missingRepository
IF [%ProjectName%] == [] GOTO :missingProjectName

SET CurrentDirectory=%cd%
CD /D %SubmodulesRoot%

git submodule add %GitRepository% %ProjectName%

CD /D %CurrentDirectory%


GOTO :EOF




:missingRepository
ECHO "Missing repository. E.g.: https://github.com/lars-wobus/unity-sample-project"
GOTO :EOF

:missingProjectName
ECHO "Missing project name. E.g.: unity-sample-project"
GOTO :EOF