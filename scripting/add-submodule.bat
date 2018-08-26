@ECHO OFF
::Example: scripting\add-submodule https://github.com/lars-wobus/unity-sample-project unity-sample-project

:: Extract %SubmodulesPath% from config
CALL %~dp0\config.bat

:: Save input argument
SET RemoteRepositoryUrl=%1
IF [%GitRepository%] == [] GOTO :MissingArgumentException

:: Extract project name
SET ProjectName=""
CALL :ExtractFilename %RemoteRepositoryUrl% %ProjectName
SET LocalPath=%SubmodulePath%\%ProjectName%

@ECHO ON

:: Add submodule
git submodule add %RemoteRepositoryUrl% %LocalPath%

@ECHO OFF

:: End on successful execution
GOTO :EOF

:: End on failure
:MissingArgumentException
ECHO Missing argument! First argument must define a repository. For instance: https://github.com/lars-wobus/unity-sample-project
GOTO :EOF

:ExtractFilename
SET %2=%~nx1
GOTO :EOF