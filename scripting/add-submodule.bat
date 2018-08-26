@ECHO OFF
::Example: scripting\add-submodule https://github.com/lars-wobus/unity-sample-project unity-sample-project

:: Extract %SubmodulesPath% from config
CALL %~dp0\config.bat

:: Save input arguments
SET GitRepository=%1
SET ProjectName=""

:: Check if arguments are set
IF [%GitRepository%] == [] GOTO :MissingArgumentException
::IF [%ProjectName%] == [] CALL :MissingArgumentException "Second argument must define a project name. For instance: unity-sample-project".

CALL :ExtractFilename %GitRepository% %ProjectName

@ECHO ON

:: Add submodule
git submodule add %GitRepository% %SubmodulesPath%/%ProjectName%

:: End on successful execution
GOTO :EOF

:: End on failure
:MissingArgumentException
ECHO Missing argument! First argument must define a repository. For instance: https://github.com/lars-wobus/unity-sample-project
GOTO :EOF

:ExtractFilename
SET %2=%~nx1
GOTO :EOF